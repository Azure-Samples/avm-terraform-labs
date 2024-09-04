module "azurerm_user_assigned_identity" {
  source  = "Azure/avm-res-managedidentity-userassignedidentity/azurerm"
  version = "0.3.3"

  location            = azurerm_resource_group.this.location
  name                = local.user_assigned_managed_identity_name
  resource_group_name = azurerm_resource_group.this.name
  tags                = var.tags
}
