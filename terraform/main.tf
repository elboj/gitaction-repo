# module "azurerm_linux_virtual_machine" {
#   source = "git::https://github.com/elboj/Terraform-Modules.git//modules/linux-virtual-machine" 
#   module_version = "0.1.1"
#   virtual_network_name = "vnt-uks-gen-dev002"
#   resource_group_name = "rg-uks-gen-dev002"
#   location = "UK South"
#   subnet_name = "web-uks-gen-dev002"
#   vm_public_ip = "pip-uks-gen-dev002"
#   nic_name = "nic-uks-vm-dev002"
#   ip_config = "ip-uks-vm-dev002" 
#   domain_name_label = "vm-uks-gen-dev002"
#   vm_name = "vm-uks-gen-dev002"
#   vm_size = "Standard_D4s_v3"
#   admin_username = "__VM_ADMIN__"
#   admin_password = "__VM_PASSWORD__"
#   storage_account_type = "Standard_LRS"
#   disk_size_gb         = "256"
#   managed_disk_name = "data-uks-gen-dev002"
# }

data "azurerm_resource_group" "rg" {
  name = "testingaksfw"
}

data "azurerm_subnet" "aks_subnet" {
  virtual_network_name = "testVnet"
  resource_group_name = "testingaksfw"
  name = "aks-subnet"
}

module "azurerm_virtual_network" {
  source = "git::https://github.com/elboj/Terraform-Modules.git//modules/virtual-network"
  module_version = "1.0"
  virtual_network_name = "testVnet"
  resource_group = data.azurerm_resource_group.rg.name
  location = "uk south"
  address_space = "172.16.0.0/16"
  subnet = var.subnet
  tags = merge(local.common_tags, tomap({ "DeployedBy" = "elboj" }))
}

module "azurerm_nsg" {
  source = "git::https://github.com/elboj/Terraform-Modules.git//modules/network-security-group"
  module_version = "1.0"
  nsg = "aks-subnet-nsg"
  nsg_rules = var.nsg_rules
  location = "uk south"
  subnet_id = data.azurerm_subnet.aks_subnet.id
  resource_group = data.azurerm_resource_group.rg.name
  tags = merge(local.common_tags, tomap({ "DeployedBy" = "elboj" }))
}


