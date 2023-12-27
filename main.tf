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

resource "libvirt_cloudinit_disk" "cloudinit_disk" {
  name           = "${var.guest_name}.iso"
  pool           = "filesystems"
  user_data      = templatefile("${path.module}/cloud-init/user-data", {})
  meta_data      = templatefile("${path.module}/cloud-init/meta-data", { hostname = "${var.guest_host_name}" })
  network_config = templatefile("${path.module}/cloud-init/network-config", {})
}

resource "libvirt_volume" "primary_disk" {
  name   = "${var.guest_name}.qcow2"
  pool   = "filesystems"
  source = "http://node1.mac.wales:8081/repository/cloud-images/rocky/Rocky-9-GenericCloud-Base-9.2-20230513.0.x86_64.qcow2"
  # source = "http://ftp3.br.freebsd.org/pub/rocky/9.2/images/x86_64/Rocky-9-GenericCloud-Base-9.2-20230513.0.x86_64.qcow2"
}

resource "libvirt_domain" "guest_domain" {
  name = var.guest_name

  cpu {
    mode = "host-passthrough"
  }
  vcpu   = 2
  memory = 4096

  disk {
    volume_id = libvirt_volume.primary_disk.id
  }

  cloudinit = libvirt_cloudinit_disk.cloudinit_disk.id

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
