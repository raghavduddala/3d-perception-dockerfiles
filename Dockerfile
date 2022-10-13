FROM ubuntu:focal-20220922

# Sets up non interactive mode when running apt install commands
ENV DEBIAN_FRONTEND=noninteractive

# Setup Locales
RUN apt update && apt install -y locales
ENV LANG="en_US.UTF-8" LC_ALL="en_US.UTF-8" LANGUAGE="en_US.UTF-8"
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen --purge $LANG && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=$LANG LC_ALL=$LC_ALL LANGUAGE=$LANGUAGE

# Setting up LA/Pacific Time
ENV TZ=Etc/UTC

# Setting up workspace for workdir
ENV WORKSPACE="/workspace/"

#libgl1 - for rendering 2D & 3D graphics in ubuntu(Open GL)
# libgomp1 - for multi-processing (GNU/GCC Open MP)
# are required dependencies for open3d
# link for reason of installing follwong libraries: 
# http://www.open3d.org/docs/latest/docker.html(on master 6d28a5b)
# available pip versions: 010.0.0, 0.11.0, 0.11.1, 0.11.2, 0.12.0, 0.13.0, 0.14.1, 0.15.2

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
    python3.8 \
    python3-pip \
    wget \
    && apt clean && rm -rf /var/lib/apt/lists/*


RUN python3 -m pip install --no-cache-dir --upgrade pip>=20.3 && \
    python3 -m pip install open3d==0.15.2

WORKDIR ${WORKSPACE}