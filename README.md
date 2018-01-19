on-imagebuilder [![Build Status](https://travis-ci.org/RackHD/on-imagebuilder.svg?branch=master)](https://travis-ci.org/RackHD/on-imagebuilder)
===============

Copyright 2015-2018, Dell EMC, Inc.

This repository contains a set of scripts that uses [Docker](https://www.docker.com) to build
docker images that run in [RancherOS](https://rancher.com/rancher-os), primarily for use
with the [on-taskgraph workflow engine](https://github.com/rackhd/on-taskgraph).

Requirements
---------------

- Docker

Overview
---------------

### Bootstrap process

The docker images produced by these scripts are intended to be netbooted and run in RAM.
The typical flow for how these images are used/booted is this:

- Netboot `RacherOS`(kernel and initrd) via PXE/iPXE
- The custom cloud-config file requests a `rackhd/micro` docker image from the boot server.
It then starts a container with full container capabilities using the `rackhd/micro` docker image.

Getting started
---------------

### Building default images and ipxe

To build images, define an imagebuilding script (see `build_all.sh` or `build_oem.sh` for an example) or
use the default one. For example, to build the default images:

```
$ cd on-imagebuilder/
$ sudo ./build_all.sh
```

The build artifacts will be located in these directories below (which are defined in the `./build_all.sh` file):
- **/tmp/on-imagebuilder/builds/**    :  it includes the artifacts:
  * discovery.docker.tar.xz
  * initrd-*-rancher
  * vmlinuz-*-rancher

- **/tmp/on-imagebuilder/ipxe/**      :  it includes the artifacts:
  * monorail-efi32-snponly.efi
  * monorail-efi64-snponly.efi
  * monorail.ipxe
  * monorail-undionly.kpxe

- **/tmp/on-imagebuilder/syslinux**   :  it includes the artifacts:
  * undionly.kkpxe


### OEM tools

  * OEM docker images `raid` and `secure_erase` require storcli_1.17.08_all.deb being copied into the folder oem/raid or oem/secure_erase.
    User can download it from http://docs.avagotech.com/docs/1.17.08_StorCLI.zip.
    If a package with different name is to be used, user should use the build parameter `STORCLI`(see the example below).

  * OEM docker images `dell_raid` and `secure_erase` require perccli_1.11.03-1_all.deb being copied into the folder oem/dell_raid or oem/secure_erase.
    There is no .deb version perccli tool. User can download .rpm perccli from:
    https://downloads.dell.com/FOLDER02444760M/1/perccli-1.11.03-1_Linux_A00.tar.gz.

    Unzip the package and then use **alien** to get a .deb version perccli tool as below:

    ```
    sudo apt-get install alien
    sudo alien -k perccli-1.11.03-1.noarch.rpm
    ```
    Again, user can use a different perccli package via the build parameter `PERCCLI`(see the example below).

  * OEM docker image `intel-flash` requires `flashupdt` and `syscfg` under the folder oem/intel-flash.
    Download the files from [Intel Download Center](https://downloadcenter.intel.com).

  * OEM docker image `quanta-flash` requires directory `ami` and `socflash` under the folder oem/quanta-flash.
    The essential files used by RackHD are:

    ```
    ami/afulnx_64
    ami/SCELNX_64
    socflash/socflash_x64
    ```
    Get `SCELNX_64` from vendor, and `afulnx_64/socflash_x64` from [Quanta Download Center](https://www.qct.io/Download).


**An example to use oem tools for secure-erase**(see more examples in `build_oem.sh`):

```
cd secure-erase
sudo docker build -t rackhd/micro \
  --build-arg PERCCLI=perccli_1.11.03-1_all.deb \
  --build-arg STORCLI=storcli_1.17.08_all.deb .
sudo docker save rackhd/micro | xz -z > secure.erase.docker.tar.xz
copy secure.erase.docker.tar.xz to on-http/static/http/common
```

Licensing
---------------

Licensed under the Apache License, Version 2.0 (the “License”); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

RackHD is a Trademark of Dell EMC
