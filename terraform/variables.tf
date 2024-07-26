variable "subnet" {
  type = map(object({
    name = string
    address_prefix = string
    security_group = string
  }))
  default = {}
}

variable "nsg_rules" {
  description = "Name of the nsg rules"
  default = null
}