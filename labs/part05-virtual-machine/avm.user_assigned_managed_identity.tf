module "user_assigned_managed_identity" {
  source  = "Azure/avm-res-managedidentity-userassignedidentity/azurerm"
  version = "~> 0.3"

  location            = var.location
  name                = module.naming.user_assigned_identity.name_unique
  resource_group_name = module.resource_group.name
  tags                = var.tags
}
