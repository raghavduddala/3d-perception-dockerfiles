FROM ubuntu:focal-20220922 as base

# Sets up non interactive mode when running apt install commands
ARG DEBIAN_FRONTEND=noninteractive
# Setting up Greenwich time or UTC
ENV TZ=Etc/UTC
ARG WORKSPACE="/workspace"

#libgl1 - for rendering 2D & 3D graphics in ubuntu(Open GL)
# libgomp1 - for multi-processing (GNU/GCC Open MP)
# are required dependencies for open3d
RUN apt update && apt install  --no-install-recommends -y \
    build-essential \
    curl \
    git \
    libgl1 \
    libgomp1 \
    libdrm2 \
    libedit2 \
    libexpat1 \
    libgcc-s1 \
    libglapi-mesa \
    libllvm10 \
    libx11-xcb1 \
    libxcb-dri2-0 \
    libxcb-glx0 \
    libxcb-shm0 \
    libxcb-xfixes0 \
    libxfixes3 \
    libxxf86vm1 \
    nano \
    python3 \
    python3-pip \
    wget \
    && apt clean && rm -rf /var/lib/apt/lists/*


RUN python3 -m pip install --no-cache-dir --upgrade pip>=20.3 && \
    python3 -m pip install --no-cache-dir --upgrade open3d==0.15.2

WORKDIR ${WORKSPACE}