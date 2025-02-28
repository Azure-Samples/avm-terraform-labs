output "resource_names" {
  value = local.resource_names
}

output "resource_ids" {
  value = {
    resource_group          = module.resource_group.resource_id
    log_analytics_workspace = module.log_analytics_workspace.resource_id
  }
}
