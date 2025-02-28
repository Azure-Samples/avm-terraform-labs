module "virtual_machine" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "0.18.0"

  resource_group_name        = module.resource_group.name
  os_type                    = "linux"
  name                       = local.resource_names.virtual_machine_name
  sku_size                   = "Standard_B1s"
  location                   = var.location
  zone                       = "1"
  encryption_at_host_enabled = var.enable_encryption_at_host # Turned off by default in this demo as requires the Microsoft.Compute/EncryptionAtHost feature to be enabled on the subscription

  generated_secrets_key_vault_secret_config = {
    key_vault_resource_id = module.key_vault.resource_id
  }

  managed_identities = {
    system_assigned = true
  }

  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  network_interfaces = {
    private = {
      name = local.resource_names.network_interface_name
      ip_configurations = {
        private = {
          name                          = "private"
          private_ip_subnet_resource_id = module.virtual_network.subnets["virtual_machines"].resource_id
        }
      }
    }
  }

  diagnostic_settings = local.diagnostic_settings
  tags                = var.tags

  depends_on = [module.key_vault, azapi_update_resource.enable_encryption_at_host]
}

resource "azapi_update_resource" "enable_encryption_at_host" {
  count = var.enable_encryption_at_host ? 1 : 0

  type = "Microsoft.Features/featureProviders/subscriptionFeatureRegistrations@2021-07-01"
  body = {
    properties = {}
  }
  resource_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/providers/Microsoft.Features/featureProviders/Microsoft.Compute/subscriptionFeatureRegistrations/EncryptionAtHost"
}