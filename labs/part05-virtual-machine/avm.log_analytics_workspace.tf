module "log_analytics_workspace" {
  source  = "Azure/avm-res-operationalinsights-workspace/azurerm"
  version = "~> 0.4"

  name                = module.naming.log_analytics_workspace.name_unique
  location            = var.location
  resource_group_name = module.resource_group.name
  tags                = var.tags
}
