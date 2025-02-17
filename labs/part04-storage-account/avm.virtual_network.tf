module "virtual_network" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.8.1"

  resource_group_name = module.resource_group.name
  subnets             = local.subnets
  address_space       = [local.virtual_network_address_space]
  location            = var.location
  name                = local.virtual_network_name
  diagnostic_settings = local.diagnostic_settings
  tags                = var.tags
}
