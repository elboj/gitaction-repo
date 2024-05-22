variable "resource_group_name" {
  description = "RG name"
  default = "rg-uks-gen-dev001"
}

variable "location" {
  description = "RG location"
  default = "UK South"
}

variable "virtual_network_name" {
  description = "virtual_network_name"
  default = "vnt-uks-gen-dev001"
}

variable "subnet_name" {
  description = "subnet_name"
  default = "default"
}

variable "nic_name" {
  description = "nic_name"
  default = "nic-uks-vm-dev001"
}

variable "ip_config" {
  description = "ip_config"
  default = "ip_config"
}

variable "vm_public_ip" {
  description = "vm_public_ip"
  default = "pip-uks-gen-dev001"
}

variable "vm_name" {
  description = "vm_name"
  default = "vm-uks-gen-dev001"
}

variable "vm_size" {
  description = "vm_size"
  default = "Standard_DS1_v2"
}

variable "admin_username" {
  description = "admin_username"
  default = "elboj_admin"
}

variable "admin_password" {
  description = "admin_password"
  default = "__VM_PASSWORD__"
}

