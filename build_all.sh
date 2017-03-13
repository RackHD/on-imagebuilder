#!/bin/bash
set -e

# build initrd
sudo ansible-playbook -i hosts common/initrd_wrapper.yml -e "config_file=vars/initrd.yml provisioner=roles/initrd/provision_initrd"

# build minbasefs
sudo ansible-playbook -i hosts common/basefs_wrapper.yml -e "config_file=vars/basefs.yml provisioner=roles/basefs/provision_rootfs"

# build full basefs
sudo ansible-playbook -i hosts common/basefs_wrapper.yml -e "config_file=vars/basefs-full.yml provisioner=roles/basefs/provision_rootfs"

# build discovery overlay
sudo ansible-playbook -i hosts common/overlay_wrapper.yml -e "config_file=vars/discovery_overlay.yml provisioner=roles/overlay/provision_discovery_overlay"

# build micro-docker
sudo ansible-playbook -i hosts common/docker_builder.yml 

# build ipxe
sudo ansible-playbook -i hosts common/ipxe_builder.yml -e "config_file=vars/ipxe.yml"

# syslinx ipxe
sudo ansible-playbook -i hosts common/syslinux_builder.yml -e "config_file=vars/syslinux.yml"
