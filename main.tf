terraform {
  required_providers {
    libvirt = { source = "dmacvicar/libvirt" }
  }
}

provider "libvirt" {
  uri = var.libvirt_uri
}

module "libvirt_domain" {
  source = "./modules/terraform-module-libvirt-domain"

  providers = { libvirt = libvirt }

  for_each = var.cluster

  guest_name           = "${each.value.guest_name}"
  hostname             = "${each.value.guest_name}"
  vcpu                 = "${each.value.vcpu}"
  memory               = "${each.value.memory}"
  network_name         = "bridge"
  subnet_type          = "static"
  ip_address           = "${each.value.ip_address}"
  gateway_address      = "192.168.1.254"
  dns_server           = "1.1.1.1"
  base_volume_name     = var.base_volume_name
  base_volume_size     = "${each.value.base_volume_size}"
  cloud_init_user_data = templatefile("${path.module}/cloud-init/user-data", {
    fqdn           = "${each.value.guest_name}"
    hostname       = "${each.value.guest_name}"
    user           = var.user
    ssh_public_key = var.ssh_public_key
  })
}
