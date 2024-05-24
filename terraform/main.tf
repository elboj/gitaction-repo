module "azurerm_linux_virtual_machine" {
  source = "git::https://github.com/elboj/Terraform-Modules.git//modules/linux-virtual-machine" 
  virtual_network_name = "vnt-uks-gen-dev001"
  resource_group_name = "rg-uks-gen-dev001"
  location = "UK South"
  subnet_name = "default"
  vm_public_ip = "nic-uks-vm-dev001"
  nic_name = "ip_config"
  ip_config = "pip-uks-gen-dev001"
  vm_name = "vm-uks-gen-dev001"
  vm_size = "Standard_DS1_v2"
  admin_username = "elboj_admin"
  admin_password = "__VM_PASSWORD__"
}
