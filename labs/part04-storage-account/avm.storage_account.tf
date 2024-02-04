module "storage_account" {
  source                            = "Azure/avm-res-storage-storageaccount/azurerm"
  version                           = "~> 0.1"
  account_replication_type          = "LRS"
  location                          = azurerm_resource_group.this.location
  name                              = local.storage_account_name
  resource_group_name               = azurerm_resource_group.this.name
  infrastructure_encryption_enabled = true
  managed_identities = {
    system_assigned            = true
    user_assigned_resource_ids = [azurerm_user_assigned_identity.this.id]
  }
  customer_managed_key = {
    key_vault_resource_id              = module.key_vault.resource.id
    key_name                           = module.key_vault.resource_keys["cmk_for_storage_account"].name
    user_assigned_identity_resource_id = azurerm_user_assigned_identity.this.id
  }
  containers = {
    demo = {
      name                  = "demo"
      container_access_type = "private"
    }
  }
  private_endpoints = {
    primary = {
      private_dns_zone_resource_ids = [azurerm_private_dns_zone.storage_account.id]
      subnet_resource_id            = module.virtual_network.subnets["private_endpoints"].id
      subresource_name              = ["blob"]
    }
  }
}
