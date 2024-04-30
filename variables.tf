
variable "cluster" {
  type = map(any)
  default = {
    node4 = {
      ip_address       = "192.168.1.24" 
      vcpu             = 4
      memory           = 8192
      base_volume_size = 80 * 1073741824
    }
    node5 = {
      ip_address        = "192.168.1.25" 
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
