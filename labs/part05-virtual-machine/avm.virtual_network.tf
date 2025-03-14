module "virtual_network" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.8.1"

  resource_group_name = module.resource_group.name
  subnets             = local.subnets
  address_space       = [var.address_space]
  location            = var.location
  name                = local.resource_names.virtual_network_name
  diagnostic_settings = local.diagnostic_settings
  tags                = var.tags
}
