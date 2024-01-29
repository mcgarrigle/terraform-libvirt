
terraform {
  required_providers {
    libvirt = { source = "dmacvicar/libvirt" }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

module "libvirt_domain_foo" {
  source = "./modules/terraform-module-libvirt-domain"

  guest_name           = "foo"
  base_volume_name     = "rocky-base-9.2"
  base_volume_size     = 10 * 1073741824
  cloud_init_user_data = file("${path.module}/cloud-init/user-data")
}

module "libvirt_domain" {
  source = "./modules/terraform-module-libvirt-domain"

  providers = { libvirt = libvirt }

  for_each = var.swarm

  guest_name           = "${each.key}"
  vcpu                 = 2
  memory               = 4096
  network_name         = "bridge"
  subnet_type          = "static"
  ip_address           = "${each.value.ip_address}"
  gateway_address      = "192.168.1.254"
  dns_server           = "1.1.1.1"
  base_volume_name     = "rocky-base-9.2"
  base_volume_size     = 20 * 1073741824
  cloud_init_user_data = file("${path.module}/cloud-init/user-data")
}
