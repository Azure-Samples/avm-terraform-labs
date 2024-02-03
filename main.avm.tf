module "virtual_network" {
  source                        = "Azure/avm-res-network-virtualnetwork/azurerm"
  version                       = "~> 0.1"
  resource_group_name           = azurerm_resource_group.this.name
  subnets                       = local.subnets
  virtual_network_address_space = [local.virtual_network_address_space]
  vnet_location                 = var.location
  vnet_name                     = local.virtual_network_name
}

module "key_vault" {
  source                        = "Azure/avm-res-keyvault-vault/azurerm"
  version                       = "~> 0.5"
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
      key_type     = "RSA"
      key_vault_id = module.key_vault.resource.id
      name         = "cmk-for-storage-account"
      key_size     = 2048
    }
  }
  private_endpoints = {
    primary = {
      private_dns_zone_resource_ids = [azurerm_private_dns_zone.key_vault.id]
      subnet_resource_id            = module.virtual_network.subnets["private_endpoints"].id
      subresource_name              = ["vault"]
    }
  }
  role_assignments = {
    deployment_user_secrets = {
      role_definition_id_or_name = "Key Vault Administrator"
      principal_id               = data.azurerm_client_config.current.object_id
    }
    customer_managed_key = {
      role_definition_id_or_name = "Key Vault Crypto Officer"
      principal_id               = azurerm_user_assigned_identity.this.principal_id
    }
  }
  wait_for_rbac_before_secret_operations = {
    create = "60s"
  }
  network_acls = {
    bypass   = "AzureServices"
    ip_rules = ["${data.http.ip.response_body}/32"]
  }
}

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

module "virtual_machine" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "~> 0.4"

  resource_group_name                    = azurerm_resource_group.this.name
  virtualmachine_os_type                 = "linux"
  name                                   = local.virtual_machine_name
  admin_credential_key_vault_resource_id = module.key_vault.resource.id
  virtualmachine_sku_size                = "Standard_B1s"

  managed_identities = {
    system_assigned = true
  }

  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  network_interfaces = {
    private = {
      name = "private"
      ip_configurations = {
        private = {
          name                          = "private"
          private_ip_subnet_resource_id = module.virtual_network.subnets["virtual_machines"].id
        }
      }
    }
  }
  depends_on = [module.key_vault]
}

module "avm-res-authorization-roleassignment" {
  source  = "Azure/avm-res-authorization-roleassignment/azurerm"
  version = "~> 0.0"

  system_assigned_managed_identities_by_principal_id = {
    virtual_machine = module.virtual_machine.virtual_machine_azurerm.identity[0].principal_id
  }

  role_definitions = {
    storage_blob_data_contributor = "Storage Blob Data Contributor"
  }

  role_assignments_for_scopes = {
    storage_container = {
      scope = module.storage_account.containers["demo"].id
      role_assignments = {
        contributor = {
          role_definition                    = "storage_blob_data_contributor"
          system_assigned_managed_identities = ["virtual_machine"]
        }
      }
    }
  }

  depends_on = [module.storage_account, module.virtual_machine]
}
