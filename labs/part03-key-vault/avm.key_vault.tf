module "key_vault" {
  source                        = "Azure/avm-res-keyvault-vault/azurerm"
  version                       = "~> 0.5"
  name                          = local.key_vault_name
  location                      = azurerm_resource_group.this.location
  resource_group_name           = azurerm_resource_group.this.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  public_network_access_enabled = true
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
  }
}
