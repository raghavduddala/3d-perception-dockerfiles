# 3d-obstacle-detection


This repository contains Dockerfile for the Open3D and will be updated regularly with updated versions 
to include vaious other libraries required to carry out 3D-perception.



### Steps to use the Docker files to create Docker Images:

```
~$ git clone https://github.com/raghavduddala/3d-obstacle-detection.git
~$ cd 3d-obstacle-detection/
```
and use the `Makefile` commands to building, launching and extending terminals to the containers
In the first terminal, to build and launch the Open3D Docker Container
```
~$ make build
~$ make dev
```
In the Second terminal, to attach a terminal to the container
```
~$ make shell
```
