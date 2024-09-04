module "bastion" {
  source  = "Azure/avm-res-network-bastionhost/azurerm"
  version = "0.3.0"

  name                   = local.bastion_host_name
  location               = azurerm_resource_group.this.location
  resource_group_name    = azurerm_resource_group.this.name
  copy_paste_enabled     = true
  file_copy_enabled      = false
  sku                    = "Standard"
  ip_connect_enabled     = true
  scale_units            = 2
  shareable_link_enabled = true
  tunneling_enabled      = true

  ip_configuration = {
    name                 = "ipconfig"
    subnet_id            = module.virtual_network.subnets["AzureBastionSubnet"].resource_id
    public_ip_address_id = module.bastion_public_ip.public_ip_id
  }

  diagnostic_settings = local.diagnostic_settings
  tags                = var.tags
}
