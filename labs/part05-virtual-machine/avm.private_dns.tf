module "private_dns_zone_key_vault" {
  source  = "Azure/avm-res-network-privatednszone/azurerm"
  version = "0.4.2"

  parent_id   = module.resource_group.resource_id
  domain_name = "privatelink.vaultcore.azure.net"

  virtual_network_links = {
    vnetlink1 = {
      vnetlinkname = "key-vault"
      vnetid       = module.virtual_network.resource_id
    }
  }

  tags = var.tags
}

module "private_dns_zone_storage_account" {
  source  = "Azure/avm-res-network-privatednszone/azurerm"
  version = "0.4.2"

  parent_id   = module.resource_group.resource_id
  domain_name = "privatelink.blob.core.windows.net"

  virtual_network_links = {
    vnetlink1 = {
      vnetlinkname = "storage-account"
      vnetid       = module.virtual_network.resource_id
    }
  }

  tags = var.tags
}
