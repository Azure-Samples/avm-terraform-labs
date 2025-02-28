module "bastion_host_public_ip" {
  source  = "Azure/avm-res-network-publicipaddress/azurerm"
  version = "0.2.0"

  name                = local.resource_names.bastion_host_public_ip_name
  location            = var.location
  resource_group_name = module.resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
  diagnostic_settings = local.diagnostic_settings
  tags                = var.tags
}
