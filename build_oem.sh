#!/bin/bash
set -e

BUILD_ARTIFACT_PATH=/tmp/on-imagebuilder/builds
mkdir -p $BUILD_ARTIFACT_PATH

# build docker image for intel
pushd oem/intel-flash
sudo docker build -t rackhd/micro .
sudo docker save rackhd/micro | xz -z > intel.flash.docker.tar.xz
cp intel.flash.docker.tar.xz $BUILD_ARTIFACT_PATH
popd

# build docker image for quanta
pushd oem/quanta-flash
sudo docker build -t rackhd/micro .
sudo docker save rackhd/micro | xz -z > quanta.flash.docker.tar.xz
cp quanta.flash.docker.tar.xz $BUILD_ARTIFACT_PATH
popd

# build docker image for dell
pushd oem/dell-raid
sudo docker build -t rackhd/micro .
sudo docker save rackhd/micro | xz -z > dell.raid.docker.tar.xz
cp dell.raid.docker.tar.xz $BUILD_ARTIFACT_PATH
popd

# build docker image for raid
pushd oem/raid
sudo docker build -t rackhd/micro .
sudo docker save rackhd/micro | xz -z > raid.docker.tar.xz
cp raid.docker.tar.xz $BUILD_ARTIFACT_PATH
popd

# build docker image for secure erase
pushd oem/secure-erase
sudo docker build -t rackhd/micro .
sudo docker save rackhd/micro | xz -z > secure.erase.docker.tar.xz
cp secure.erase.docker.tar.xz $BUILD_ARTIFACT_PATH
popd
