
variable "cluster" {
  type = map(any)
  default = {
    guest1 = {
      guest_name       = "node1"
      ip_address       = "192.168.1.21"
      gateway_address  = "192.168.1.254"
      dns_server       = "1.1.1.1"
      vcpu             = 2
      memory           = 8192
      base_volume_size = 80 * 1073741824
    }
    guest2 = {
      guest_name       = "node2"
      ip_address       = "192.168.1.22"
      gateway_address  = "192.168.1.254"
      dns_server       = "1.1.1.1"
      vcpu             = 2
      memory           = 8192
      base_volume_size = 80 * 1073741824
    }
    guest3 = {
      guest_name       = "node3"
      ip_address       = "192.168.1.23"
      gateway_address  = "192.168.1.254"
      dns_server       = "1.1.1.1"
      vcpu             = 2
      memory           = 8192
      base_volume_size = 80 * 1073741824
    }
  }
}

variable "libvirt_uri" {
  type    = string
}

variable "storage_pool" {
  type    = string
  default = "filesystems"
}

variable "base_volume_name" {
  type    = string
}

variable "user" {
  type = string
}

variable "ssh_public_key" {
  type = string
}
