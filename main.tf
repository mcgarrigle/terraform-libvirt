terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud-init/user-data")
}

data "template_file" "network_config" {
  template = file("${path.module}/cloud-init/network-config")
}

resource "libvirt_cloudinit_disk" "terraform_test" {
  name           = "terraform_test.iso"
  pool           = "filesystems"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
}

resource "libvirt_volume" "terraform_test" {
  name   = "terraform_test.qcow2"
  pool   = "filesystems"
  source = "http://node1.mac.wales:8081/repository/cloud-images/rocky/Rocky-9-GenericCloud-Base-9.2-20230513.0.x86_64.qcow2"
  # source = "http://ftp3.br.freebsd.org/pub/rocky/9.2/images/x86_64/Rocky-9-GenericCloud-Base-9.2-20230513.0.x86_64.qcow2"
}

resource "libvirt_domain" "terraform_test" {
  name = "terraform_test"

  cpu {
    mode = "host-passthrough"
  }
  vcpu   = 2
  memory = 4096

  disk {
    volume_id = libvirt_volume.terraform_test.id
  }

  cloudinit = libvirt_cloudinit_disk.terraform_test.id

  network_interface {
    hostname       = "master"
    network_name   = "default"
    wait_for_lease = false
  }

  graphics {
    type = "vnc"
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

}
