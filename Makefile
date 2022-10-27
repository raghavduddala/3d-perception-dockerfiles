VERSION := 0.0.2
IMAGE := raghav-tf-pt-o3d
CONTAINER := ${IMAGE}:${VERSION}
DOCKERFILE := Dockerfile.pt3d
# CONTAINER := nvcr.io/nvidia/tensorflow:22.02-tf2-py3
# CONTAINER := nvcr.io/nvidia/cuda:11.6.0-cudnn8-devel-ubuntu20.04
XSOCK := /tmp/.X11-unix
# No Image name as it has to be maintained with the github container registry
# Later on we can add specific tags and version names depending on long-term maintenance

.PHONY: help
help: ## Display the help message
		@grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:[[:blank:]]*\(##\)[[:blank:]]*/\1/' | column -s '##' -t

.PHONY: version
version: ## Display the version
		@echo $(VERSION)

# X11 - UNIX SOCKET for network over the container
# XAUTH - authorizing other users to run graphical applications 
.PHONY: dev
dev: ## runs the env for open3d in the container
		@xhost +local:root 		
		@docker run --rm -it \
			--privileged \
			--device  /dev:/dev \
			--env="DISPLAY" \
			--env="QT_X11_NO_MITSHM=1" \
			--env="TERM=xterm-256color" \
			--volume $(PWD):/workspace/ \
			--volume $(XSOCK):$(XSOCK) \
			--network host \
			--name $(IMAGE) \
			$(CONTAINER) \
			/bin/bash
		@xhost -local:root


# CUDA Development
.PHONY: cuda-dev
cuda-dev: ## runs perception dev docker on jetson devices
	@xhost +local:root
	@docker run --rm -it \
		--device  /dev:/dev \
		--env="DISPLAY" \
		--env="QT_X11_NO_MITSHM=1" \
		--env="TERM=xterm-256color" \
		--gpus all \
		--mount="type=bind,source="/tmp",target=/tmp:rw" \
		--privileged \
		--network host \
		--volume="$(HOME)/.Xauthority:/root/.Xauthority:rw" \
		--volume $(PWD):/workspace/ \
		--volume $(XSOCK):$(XSOCK) \
		--runtime nvidia \
		--name $(IMAGE) \
		$(CONTAINER) \
		/bin/bash
	@xhost -local:root

.PHONY: shell
shell: ## attaches a shell to a currently running container
		@docker exec -ti \
		$(IMAGE) \
		/bin/bash


.PHONY: build
build: ## Builds the container image
		@DOCKER_BUILDKIT=1 docker build \
		--progress=plain \
		--file docker/$(DOCKERFILE) \
		--tag $(CONTAINER) \
		.
