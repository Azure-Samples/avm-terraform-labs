# Define resource names
locals {
  unique_postfix = random_pet.unique_name.id

  resource_group_name          = "rg-demo-${local.unique_postfix}"
  log_analytics_workspace_name = "law-demo-${local.unique_postfix}"
}
