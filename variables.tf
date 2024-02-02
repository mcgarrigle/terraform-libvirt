
variable "cluster" {
  type = map(any)
  default = {
    bar1 = {
             ip_address       = "192.168.1.24" 
             vcpu             = 2
             memory           = 4096
             base_volume_size = 20 * 1073741824
           }
    bar2 = {
            ip_address        = "192.168.1.25" 
             vcpu             = 2
             memory           = 4096
             base_volume_size = 20 * 1073741824
           }
  }
}

variable "storage_pool" {
  type    = string
  default = "filesystems"
}
