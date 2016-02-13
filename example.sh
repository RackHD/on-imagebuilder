#!/bin/bash
set -e

# Use the initrd wrapper playbook to build an initrd.
sudo ansible-playbook -i hosts common/initrd_wrapper.yml -e "config_file=vars/initrd.yml provisioner=roles/initrd/provision_initrd"

# Use the basefs wrapper playbook to build a basefs.
sudo ansible-playbook -i hosts common/basefs_wrapper.yml -e "config_file=vars/basefs.yml provisioner=roles/basefs/provision_rootfs"

# Use the overlay wrapper playbook to build an overlay.
sudo ansible-playbook -i hosts common/overlay_wrapper.yml -e "config_file=vars/overlay.yml provisioner=roles/overlay/provision_discovery_overlay"

# If an overlay provisioner will install vendor-specific tooling,
# use the convention of putting it into the oem directory.
sudo ansible-playbook -i hosts common/overlay_wrapper.yml -e "config_file=vars/oem/intel.yml provisioner=roles/oem/overlay/provision_intel_flashing_overlay"
