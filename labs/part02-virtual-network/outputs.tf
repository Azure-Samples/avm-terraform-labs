output "resource_names" {
  value = {
    resource_group          = module.resource_group.name
    log_analytics_workspace = module.log_analytics_workspace.resource.name
    virtual_network         = module.virtual_network.name
    network_security_group  = module.network_security_group.name
    nat_gateway             = module.nat_gateway.resource.name
    nat_gateway_public_ip   = module.nat_gateway.public_ip_resource["default"].name
  }
}

output "resource_ids" {
  value = {
    resource_group          = module.resource_group.resource_id
    log_analytics_workspace = module.log_analytics_workspace.resource_id
    virtual_network         = module.virtual_network.resource_id
    network_security_group  = module.network_security_group.resource_id
    nat_gateway             = module.nat_gateway.resource.id
    nat_gateway_public_ip   = module.nat_gateway.public_ip_resource["default"].id
  }
}
