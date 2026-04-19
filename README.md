# DE10-Nano Yocto Build Repository

This repository provides a Yocto-based build environment to run a Terasic DE10-Nano module.

> Warning: This repository is not intended to support everything the DE10-Nano board could possibly do. It is maintained only for my own use cases and requirements.

Base:
- Yocto Release: Scarthgap
- Target board: Terasic DE10-Nano (Cyclone V SoC)

## Prerequisites

- Linux build host
- Git
- Sufficient disk space (Yocto build artifacts are large)

### Docker

- The usage of docker is possible. Install the docker engine and run the script 
```
./docker/build_docker_yocto.sh`
```

- After the docker image is working, start it with 
```
./docker/run_docker_yocto.sh ./
```

## Clone Repository and Checkout Submodules

After cloning, the submodules must be initialized:

```bash
git clone <repo-url>
cd de10-nano-2
git submodule update --init --recursive
```

If the repository is already cloned, this is enough:

```bash
git submodule update --init --recursive
```

## Initialize Build Environment

```bash
source poky/oe-init-build-env build
```

## Build Image

```bash
bitbake de10-image-core
```

The build outputs are located at:

- build/tmp/deploy/images/de10-nano

## Flash SD Card

Example using dd:

```bash
sudo dd if=build/tmp/deploy/images/de10-nano/de10-image-core-de10-nano.rootfs.wic of=/dev/sdX bs=4M conv=fsync status=progress
sync
```

Note:
- Replace /dev/sdX with the correct target device.

## Goal

With this repository, you can build and run a bootable Yocto system for the Terasic DE10-Nano.


## FPGA

The image provides the environment to run fpga rbf-files. Log in to the device and type:
```
load-fpga.sh
```
to run the loading of the file `/lib/firmware/fpga.rbf` Simply replace the example by any binary you like. 