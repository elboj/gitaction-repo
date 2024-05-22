#CREATE RESOURCE GROUP
resource "azurerm_resource_group" "resoure_group" {
  name     = var.resource_group_name
  location = var.location
}

#CREATE VNET
resource "azurerm_virtual_network" "virtual_network" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.resoure_group.location
  resource_group_name = azurerm_resource_group.resoure_group.name
}

#CREATE SUBNET
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.resoure_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = ["10.0.2.0/24"]
}

#CREATE PUBLIC IP
resource "azurerm_public_ip" "public_ip" {
  name                =  var.vm_public_ip
  location            =  azurerm_resource_group.resoure_group.location
  resource_group_name =  azurerm_resource_group.resoure_group.name
  allocation_method   = "Dynamic"
}

#CREATE NIC
resource "azurerm_network_interface" "network_interface" {
  name                = var.nic_name
  location            = azurerm_resource_group.resoure_group.location
  resource_group_name = azurerm_resource_group.resoure_group.name

  ip_configuration {
    name                          = var.ip_config
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

#CREATE LINUX VM
resource "azurerm_linux_virtual_machine" "example" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.resoure_group.name
  location            = azurerm_resource_group.resoure_group.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.network_interface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

#CREATE NSG
# Create Network Security Group and rule
resource "azurerm_network_security_group" "network_security_group" {
  name                = "nsg-uks-gen-dev001"
  location            = azurerm_resource_group.resoure_group.location
  resource_group_name = azurerm_resource_group.resoure_group.name
  dynamic "security_rule" {
    for_each = local.nsg
    content {
      name                       = security_rule.value.name
      priority                   = local.security_rules_with_priority[security_rule.value.name]
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.network_interface.id
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}