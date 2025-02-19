output "names" {
  value = {
    resource_group_name                 = module.resource_group.name
    virtual_network_name                = module.virtual_network.name
    network_security_group_name         = module.network_security_group.name
    key_vault_name                      = module.key_vault.name
    storage_account_name                = module.storage_account.name
    user_assigned_managed_identity_name = module.user_assigned_identity.name
    virtual_machine_name                = module.virtual_machine.name
    network_interface_name              = module.network_interface.name
    bastion_host_public_ip_name         = module.bastion_host_public_ip.name
    bastion_host_name                   = module.bastion_host.name
  }
}

output "subnets" {
  value = local.subnets
}
