resource "random_pet" "unique_name" {
  length    = 2
  separator = "-"
}

resource "azurerm_resource_group" "this" {
  location = var.location
  name     = local.resource_group_name
  tags     = var.tags
}
