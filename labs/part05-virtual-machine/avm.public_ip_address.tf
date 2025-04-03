module "bastion_host_public_ip" {
  source  = "Azure/avm-res-network-publicipaddress/azurerm"
  version = "~> 0.2"

  name                = "${module.naming.public_ip.name}-bastion"
  location            = var.location
  resource_group_name = module.resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
  diagnostic_settings = local.diagnostic_settings
  tags                = var.tags
}
