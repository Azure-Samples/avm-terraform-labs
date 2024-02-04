# Coming soon: https://github.com/Azure/terraform-azurerm-avm-res-network-publicipaddress
resource "azurerm_public_ip" "bastionpip" {
  name                = local.bastion_host_public_ip_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Coming soon: https://github.com/Azure/terraform-azurerm-avm-res-network-bastionhost
resource "azurerm_bastion_host" "bastion" {
  name                = local.bastion_host_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                 = "ipconfig"
    subnet_id            = module.virtual_network.subnets["AzureBastionSubnet"].id
    public_ip_address_id = azurerm_public_ip.bastionpip.id
  }
}
