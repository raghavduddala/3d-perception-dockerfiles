VERSION := 0.0.1
IMAGE := raghav-3d
CONTAINER := ${IMAGE}:${VERSION}
CONTAINER_NAME := raghav-ta-open3d
DOCKER := docker
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
		@$ docker run --rm -it \
			--privileged \
			--device  /dev:/dev \
			--env="DISPLAY" \
			--env="QT_X11_NO_MITSHM=1" \
			--env="TERM=xterm-256color" \
			--volume $(PWD):/workspace/ \
			--volume $(XSOCK):$(XSOCK) \
			--network host \
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
