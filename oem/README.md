# Micro Docker

## RancherOS kernel

### RancherOS vmlinuz

```
wget https://github.com/rancher/os/releases/download/v1.0.2/vmlinuz -O vmlinuz-1.0.2-rancher
copy vmlinuz-1.0.2-rancher to on-http/static/http/common
```

### RancherOS initrd

```
wget https://github.com/rancher/os/releases/download/v1.0.2/initrd -O initrd-1.0.2-rancher
copy initrd-1.0.2-rancher to on-http/static/http/common
```

### Discovery Image

```
cd discovery
sudo docker build -t rackhd/micro .
sudo docker save rackhd/micro | xz -z > discovery.docker.tar.xz
copy discovery.docker.tar.xz to on-http/static/http/common
```

## Build ipxe

### ipxe

```
cd ipxe
sudo docker build -t rackhd/ipxe .
sudo docker run -d --name rackhd-ipxe rackhd/ipxe
sudo docker cp rackhd-ipxe:/build-ipxe-artifact-path .
```

### syslinux ipxe

```
cd syslinux
sudo docker build -t rackhd/syslinux .
sudo docker run -d --name rackhd-syslinux rackhd/syslinux
sudo docker cp rackhd-syslinux:/build-syslinux-artifact-path .
```

## OEM docker image

### Secure Erase Image

```
cd secure-erase
sudo docker build -t rackhd/micro \
  --build-arg PERCCLI=perccli_1.11.03-1_all.deb \
  --build-arg STORCLI=storcli_1.17.08_all.deb .
sudo docker save rackhd/micro | xz -z > secure.erase.docker.tar.xz
copy secure.erase.docker.tar.xz to on-http/static/http/common
```

### Intel Flash Image

```
cd intel-flash
sudo docker build -t rackhd/micro .
sudo docker save rackhd/micro | xz -z > intel.flash.docker.tar.xz
copy intel.flash.docker.tar.xz to on-http/static/http/common
```

### Quanta Flash Image

```
cd quanta-flash
sudo docker build -t rackhd/micro .
sudo docker save rackhd/micro | xz -z > quanta.flash.docker.tar.xz
copy quanta.flash.docker.tar.xz to on-http/static/http/common
```
