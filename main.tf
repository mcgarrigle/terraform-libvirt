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
  pool           = var.storage_pool
  user_data      = templatefile("${path.module}/cloud-init/user-data", {})
  meta_data      = templatefile("${path.module}/cloud-init/meta-data", { hostname = "${var.guest_host_name}" })
  network_config = templatefile("${path.module}/cloud-init/network-config", {})
}

resource "libvirt_volume" "primary_disk" {
  name   = "${var.guest_name}.qcow2"
  pool   = var.storage_pool
  source = var.image_url
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
