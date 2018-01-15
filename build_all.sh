#!/bin/bash
set -e

BUILD_ARTIFACT_PATH=/tmp/on-imagebuilder/builds
IPXE_BUILD_ARTIFACT_PATH=/tmp/on-imagebuilder/ipxe
SYSLINUX_BUILD_ARTIFACT_PATH=/tmp/on-imagebuilder/syslinux
RANCHER_VERSION=1.0.2

mkdir -p $BUILD_ARTIFACT_PATH
mkdir -p $IPXE_BUILD_ARTIFACT_PATH
mkdir -p $SYSLINUX_BUILD_ARTIFACT_PATH

wget https://github.com/rancher/os/releases/download/v${RANCHER_VERSION}/vmlinuz -O $BUILD_ARTIFACT_PATH/vmlinuz-${RANCHER_VERSION}-rancher
wget https://github.com/rancher/os/releases/download/v${RANCHER_VERSION}/initrd -O $BUILD_ARTIFACT_PATH/initrd-${RANCHER_VERSION}-rancher

# build docker image for discovery
pushd discovery
sudo docker build -t rackhd/micro .
sudo docker save rackhd/micro | xz -z > discovery.docker.tar.xz
cp discovery.docker.tar.xz $BUILD_ARTIFACT_PATH
popd

# build ipxe
pushd ipxe
sudo docker build -t rackhd/ipxe .
sudo docker run -d --name rackhd-ipxe rackhd/ipxe
sudo docker cp rackhd-ipxe:/build-ipxe-artifact-path/. $IPXE_BUILD_ARTIFACT_PATH
sudo docker rm -f rackhd-ipxe
popd

# syslinx ipxe
pushd syslinux
sudo docker build -t rackhd/syslinux .
sudo docker run -d --name rackhd-syslinux rackhd/syslinux
sudo docker cp rackhd-syslinux:/build-syslinux-artifact-path/. $SYSLINUX_BUILD_ARTIFACT_PATH
sudo docker rm -f rackhd-syslinux
popd
