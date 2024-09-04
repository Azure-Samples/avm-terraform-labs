module "storage_account" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.2.5"

  account_replication_type          = "LRS"
  location                          = azurerm_resource_group.this.location
  name                              = local.storage_account_name
  resource_group_name               = azurerm_resource_group.this.name
  infrastructure_encryption_enabled = true

  managed_identities = {
    system_assigned            = true
    user_assigned_resource_ids = [module.azurerm_user_assigned_identity.resource_id]
  }

  customer_managed_key = {
    key_vault_resource_id  = module.key_vault.resource_id
    key_name               = "cmk-for-storage-account"
    user_assigned_identity = { resource_id = module.azurerm_user_assigned_identity.resource_id }
  }

  containers = {
    demo = {
      name                  = "demo"
      container_access_type = "private"
    }
  }

  private_endpoints = {
    primary = {
      private_dns_zone_resource_ids = [module.private_dns_zone_storage_account.resource_id]
      subnet_resource_id            = module.virtual_network.subnets["private_endpoints"].resource_id
      subresource_name              = "blob"
      tags                          = var.tags
    }
  }

  diagnostic_settings_storage_account = local.diagnostic_settings
  diagnostic_settings_blob            = local.diagnostic_settings
  tags                                = var.tags
}
