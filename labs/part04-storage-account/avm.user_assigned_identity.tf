module "user_assigned_identity" {
  source  = "Azure/avm-res-managedidentity-userassignedidentity/azurerm"
  version = "0.3.3"

  location            = var.location
  name                = local.user_assigned_managed_identity_name
  resource_group_name = module.resource_group.name
  tags                = var.tags
}
