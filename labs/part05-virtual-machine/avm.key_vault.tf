module "key_vault" {
  source  = "Azure/avm-res-keyvault-vault/azurerm"
  version = "0.9.1"

  name                          = local.key_vault_name
  location                      = azurerm_resource_group.this.location
  resource_group_name           = azurerm_resource_group.this.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  public_network_access_enabled = true

  keys = {
    cmk_for_storage_account = {
      key_opts = [
        "decrypt",
        "encrypt",
        "sign",
        "unwrapKey",
        "verify",
        "wrapKey"
      ]
      key_type = "RSA"
      name     = "cmk-for-storage-account"
      key_size = 2048
    }
  }

  private_endpoints = {
    primary = {
      private_dns_zone_resource_ids = [module.private_dns_zone_key_vault.resource_id]
      subnet_resource_id            = module.virtual_network.subnets["private_endpoints"].resource_id
      subresource_name              = ["vault"]
      tags                          = var.tags
    }
  }

  role_assignments = {
    deployment_user_secrets = {
      role_definition_id_or_name = "Key Vault Administrator"
      principal_id               = data.azurerm_client_config.current.object_id
    }
    customer_managed_key = {
      role_definition_id_or_name = "Key Vault Crypto Officer"
      principal_id               = module.azurerm_user_assigned_identity.principal_id
    }
  }

  wait_for_rbac_before_key_operations = {
    create = "60s"
  }

  network_acls = {
    bypass   = "AzureServices"
    ip_rules = ["${data.http.ip.response_body}/32"]
  }

  diagnostic_settings = local.diagnostic_settings
  tags                = var.tags
}
