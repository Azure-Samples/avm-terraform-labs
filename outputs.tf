output "subnets" {
  value = local.subnets
}

output "names" {
  value = {
    resource_group_name                 = local.resource_group_name
    virtual_network_name                = local.virtual_network_name
    network_security_group_name         = local.network_security_group_name
    storage_account_name                = local.storage_account_name
    key_vault_name                      = local.key_vault_name
    user_assigned_managed_identity_name = local.user_assigned_managed_identity_name
    virtual_machine_name                = local.virtual_machine_name
    bastion_host_public_ip_name         = local.bastion_host_public_ip_name
    bastion_host_name                   = local.bastion_host_name
  }
}

output "virtual_machine_system_assigned_managed_identity_principal_id" {
  value = module.virtual_machine.virtual_machine_azurerm.identity[0].principal_id
}