variable "image_url" {
  type    = string
  default = "http://node1.mac.wales:8081/repository/cloud-images/rocky/Rocky-9-GenericCloud-Base-9.2-20230513.0.x86_64.qcow2"
  # default = "http://ftp3.br.freebsd.org/pub/rocky/9.2/images/x86_64/Rocky-9-GenericCloud-Base-9.2-20230513.0.x86_64.qcow2"
}

variable "guest_name" {
  type    = string
  default = "terraform_test"
}

variable "guest_host_name" {
  type    = string
  default = "terraform"
}

variable "storage_pool" {
  type    = string
  default = "filesystems"
}
