module "bastion_public_ip" {
  source              = "Azure/avm-res-network-publicipaddress/azurerm"
  version             = "~> 0.1"
  name                = local.bastion_host_public_ip_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
