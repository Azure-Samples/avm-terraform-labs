output "resource_names" {
  value = {
    resource_group                 = module.resource_group.name
    log_analytics_workspace        = module.log_analytics_workspace.resource.name
    virtual_network                = module.virtual_network.name
    network_security_group         = module.network_security_group.name
    nat_gateway                    = module.nat_gateway.resource.name
    nat_gateway_public_ip          = module.nat_gateway.public_ip_resource["default"].name
    key_vault                      = module.key_vault.name
    storage_account                = module.storage_account.name
    user_assigned_managed_identity = module.user_assigned_managed_identity.resource_name
    virtual_machine                = module.virtual_machine.name
    network_interface              = module.virtual_machine.network_interfaces["private"].name
    bastion_host_public_ip         = module.bastion_host_public_ip.name
    bastion_host                   = module.bastion_host.name
  }
}

output "resource_ids" {
  value = {
    resource_group                 = module.resource_group.resource_id
    log_analytics_workspace        = module.log_analytics_workspace.resource_id
    virtual_network                = module.virtual_network.resource_id
    network_security_group         = module.network_security_group.resource_id
    nat_gateway                    = module.nat_gateway.resource.id
    nat_gateway_public_ip          = module.nat_gateway.public_ip_resource["default"].id
    key_vault                      = module.key_vault.resource_id
    storage_account                = module.storage_account.resource_id
    user_assigned_managed_identity = module.user_assigned_managed_identity.resource_id
    virtual_machine                = module.virtual_machine.resource_id
    network_interface              = module.virtual_machine.network_interfaces["private"].id
    bastion_host_public_ip         = module.bastion_host_public_ip.public_ip_id
    bastion_host                   = module.bastion_host.resource_id
  }
}

output "subnets" {
  value = local.subnets
}
