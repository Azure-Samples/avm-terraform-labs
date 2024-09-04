module "virtual_machine" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "0.16.0"

  resource_group_name = azurerm_resource_group.this.name
  os_type             = "linux"
  name                = local.virtual_machine_name
  sku_size            = "Standard_B1s"
  location            = azurerm_resource_group.this.location
  zone                = "1"

  generated_secrets_key_vault_secret_config = {
    key_vault_resource_id = module.key_vault.resource_id
  }

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
      name = local.network_interface_name
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

  depends_on = [module.key_vault]
}
