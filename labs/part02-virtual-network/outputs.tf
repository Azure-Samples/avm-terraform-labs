output "names" {
  value = {
    resource_group_name         = local.resource_group_name
    virtual_network_name        = local.virtual_network_name
    network_security_group_name = local.network_security_group_name
  }
}

output "subnets" {
  value = local.subnets
}
