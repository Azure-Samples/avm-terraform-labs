# Coming soon: TBC
resource "azurerm_user_assigned_identity" "this" {
  location            = azurerm_resource_group.this.location
  name                = local.user_assigned_managed_identity_name
  resource_group_name = azurerm_resource_group.this.name
}
