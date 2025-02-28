module "storage_account" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.5.0"

  account_replication_type          = "LRS"
  location                          = var.location
  name                              = local.resource_names.storage_account_name
  resource_group_name               = module.resource_group.name
  infrastructure_encryption_enabled = true

  managed_identities = {
    system_assigned            = true
    user_assigned_resource_ids = [module.user_assigned_managed_identity.resource_id]
  }

  customer_managed_key = {
    key_vault_resource_id  = module.key_vault.resource_id
    key_name               = reverse(split("/", module.key_vault.keys_resource_ids["cmk_for_storage_account"].versionless_id))[0]
    user_assigned_identity = { resource_id = module.user_assigned_managed_identity.resource_id }
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
