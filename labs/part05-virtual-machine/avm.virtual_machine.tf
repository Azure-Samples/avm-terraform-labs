module "virtual_machine" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "~> 0.4"

  resource_group_name                    = azurerm_resource_group.this.name
  virtualmachine_os_type                 = "linux"
  name                                   = local.virtual_machine_name
  admin_credential_key_vault_resource_id = module.key_vault.resource.id
  virtualmachine_sku_size                = "Standard_B1s"
  zone                                   = "1"

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
          private_ip_subnet_resource_id = module.virtual_network.subnets["virtual_machines"].id
        }
      }
    }
  }
  depends_on = [module.key_vault]
}
