locals {
  nsg = {
    "allow_ssh" = {
        name                       = "SSH"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    },
    "allow_http" = {
        name                       = "http"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    },
    "allow_https" = {
        name                       = "https"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
  }
   # Create a map of rule names to their calculated priorities
   security_rules_with_priority = zipmap(
    [for i, rule in local.nsg : rule.name],
    [for i in range(length(local.nsg)) : 1000 + i]
  )
}


  
