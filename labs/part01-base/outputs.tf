output "resource_names" {
  value = {
    resource_group          = module.resource_group.name
    log_analytics_workspace = module.log_analytics_workspace.resource.name
  }
}

output "resource_ids" {
  value = {
    resource_group          = module.resource_group.resource_id
    log_analytics_workspace = module.log_analytics_workspace.resource_id
  }
}
