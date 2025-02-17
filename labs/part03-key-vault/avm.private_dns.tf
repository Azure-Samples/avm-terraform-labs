module "private_dns_zone_key_vault" {
  source  = "Azure/avm-res-network-privatednszone/azurerm"
  version = "0.3.2"

  resource_group_name = module.resource_group.name
  domain_name         = "privatelink.vaultcore.azure.net"
  virtual_network_links = {
    vnetlink1 = {
      vnetlinkname = "key-vault"
      vnetid       = module.virtual_network.resource_id
    }
  }

  tags = var.tags
}
