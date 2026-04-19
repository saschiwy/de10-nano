# Introduction

A simple repository which provices a generic docker image to build yocto images.

- Install Docker

[Installation of Docker Engine](https://docs.docker.com/engine/install/)

[Linux Post Install](https://docs.docker.com/engine/install/linux-postinstall/)

- Run the build script:

~~~~
./build_docker_yocto.sh
~~~~

- Checkout the yocto environment you desire
- start the container with the yocto environment as argument

~~~~
./run_docker_yocto.sh <path/to/your/yocto/env>
~~~~

- Inside behave like on a regular host, source the yocto environment, bitbake ...