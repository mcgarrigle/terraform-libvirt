# We are targeting this KVM instance

export LIBVIRT_DEFAULT_URI="qemu:///system"
export LIBVIRT_DEFAULT_URI="qemu+ssh://${USER}@wee.mac.wales/system?keyfile=${HOME}/.ssh/id_rsa&sshauth=privkey&no_verify=1"

# Provide configuration to terraform
#
# look at variables.tf - adjust and expand as necessary

export TF_VAR_libvirt_uri="${LIBVIRT_DEFAULT_URI}"

# choose Rocky or Ubuntu

export TF_VAR_base_volume_name="base-rocky-9.3.qcow2"
export TF_VAR_network_interface="eth0"
# export TF_VAR_base_volume_name="base-ubuntu-jammy.qcow2"
# export TF_VAR_network_interface="ens3"

export TF_VAR_user="${USER}"
export TF_VAR_ssh_public_key="$(cat ~/.ssh/id_rsa.pub)"
