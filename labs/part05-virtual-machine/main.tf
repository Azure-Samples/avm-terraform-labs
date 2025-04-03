module "naming" {
  source  = "Azure/naming/azurerm"
  version = "~> 0.4"

  suffix = [
    var.resource_name_workload,
    var.resource_name_environment
  ]
  unique-length = 8
}

module "resource_group" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "~> 0.2"

  location = var.location
  name     = module.naming.resource_group.name_unique
  tags     = var.tags
}
