# 3d-obstacle-detection

---
This repository contains Dockerfile for the Open3D and will be updated regularly with updated versions 
to include various other libraries required to carry out 3D-perception. 

For now, the single Dockerfile is tested for the following settings for an x86_64:

|System         | Version       | 
| ------------- |:-------------:| 
| Ubuntu        | 20.04         | 
| Docker        | 20.10.14      | 

with : 

|System         | Version       | 
| ------------- |:-------------:| 
| pip           | 20.3          | 
| Python        | 3.8           |
| Open3D        | 0.15.2        | 

> The PyPI has open3d with version no. 0.15.2 instead of 0.15.1 . I believe it is just a new commit fully resolved with any issues from 0.15.1

---
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
After the docker container is launched, run the basic test file from Open3D tutorials [here](http://www.open3d.org/docs/release/tutorial/visualization/visualization.html#Function-draw_geometries) to check if the 
installation and build is fine.
```
~$ cd src/
~$ python3 test_open3d.py 
```
A sample .ply file containing a Point cloud from Open 3D is downloaded and visualized in the following way.

![Open-3D-Visualization](https://user-images.githubusercontent.com/12818429/194731824-540163ae-6506-442f-ac54-c0887e8891b6.png)

---
### Usage examples when using with other repos that require the docker container
My Repos using this include https://github.com/raghavduddala/point_clouds_open3d.git

where the repo we want to run can be cloned under the `src` directory of this docker `workspace` folder.