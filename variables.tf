
variable "swarm" {
  type = map(any)
  default = {
    bar1 = { ip_address = "192.168.1.24" }
    bar2 = { ip_address = "192.168.1.25" }
  }
}

variable "storage_pool" {
  type    = string
  default = "filesystems"
}
