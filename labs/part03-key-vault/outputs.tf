output "names" {
  value = {
    resource_group_name         = module.resource_group.name
    virtual_network_name        = module.virtual_network.name
    network_security_group_name = module.network_security_group.name
    key_vault_name              = module.key_vault.name
  }
}

output "subnets" {
  value = local.subnets
}
