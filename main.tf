
module "libvirt_domain_foo" {
  source = "./modules/terraform-module-libvirt-domain"

  guest_name           = "foo"
  cloud_init_user_data = file("${path.module}/cloud-init/user-data")
}

module "libvirt_domain_bar" {
  source = "./modules/terraform-module-libvirt-domain"

  guest_name           = "bar"
  vcpu                 = 2
  memory               = 4096
  network_name         = "bridge"
  subnet_type          = "static"
  ip_address           = "192.168.1.24" 
  gateway_address      = "192.168.1.254"
  dns_server           = "192.168.1.254"
  root_disk_size       = 20480
  cloud_init_user_data = file("${path.module}/cloud-init/user-data")
}
