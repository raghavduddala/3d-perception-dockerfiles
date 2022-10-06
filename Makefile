VERSION := 0.0.1
IMAGE := raghav-3d
CONTAINER := ${IMAGE}:${VERSION}
CONTAINER_NAME := raghav-ta-open3d
DOCKER := docker
XAUTH := /tmp/.docker.xauth
XSOCK := /tmp/.X11-unix
# No Image name as it has to be maintained with the github container registry
# Later on we can add specific tags and version names depending on long-term maintenance

.PHONY: help
help: ## Display the help message
		@grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:[[:blank:]]*\(##\)[[:blank:]]*/\1/' | column -s '##' -t


# X11 - UNIX SOCKET for network over the container
# XAUTH - authorizing other users to run graphical applications 
.PHONY: dev
dev: ## runs the env for open3d in the container
		@$ xhost +local:root 
		@$ xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $(XAUTH) nmerge -
		@$ docker run --rm -it \
			--privileged \
			--network host \
			--device=/dev/dri:/dev/dri \
			--env="DISPLAY" \
			--env="QT_X11_NO_MITSHM=1" \
			--env="TERM=xterm-256color" \
			--env="XAUTHORITY=$(XAUTH)" \
			--mount="type=bind,source="$(XAUTH)",target=$(XAUTH)" \
			--mount="type=bind,source="/tmp",target=/tmp:rw" \
			--volume="$(HOME)/.Xauthority:/root/.Xauthority:rw" \
			--volume $(PWD):/workspace/ \
			--volume $(XSOCK):$(XSOCK) \
			--name $(CONTAINER_NAME) \
			$(CONTAINER) \
			/bin/bash
		@xhost -local:root


.PHONY: shell
shell: ## attaches a shell to a currently running container
		@$(DOCKER) exec -ti \
		$(CONTAINER_NAME) \
		/bin/bash


.PHONY: build
build: ## Builds the container image
		@DOCKER_BUILDKIT=1 $(DOCKER) build \
		--no-cache \
		--progress=plain \
		--tag $(CONTAINER) \
		.




