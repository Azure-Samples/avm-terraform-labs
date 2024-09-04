# Define resource names
locals {
  unique_postfix = random_pet.unique_name.id

  resource_group_name          = "rg-demo-${local.unique_postfix}"
  log_analytics_workspace_name = "law-demo-${local.unique_postfix}"
  virtual_network_name         = "vnet-demo-${local.unique_postfix}"
  network_security_group_name  = "nsg-demo-${local.unique_postfix}"
  nat_gateway_name             = "natgw-demo-${local.unique_postfix}"
  nat_public_ip_name           = "natpip-demo-${local.unique_postfix}"
}

# Caluculate the CIDR for the subnets
locals {
  virtual_network_address_space = "${var.address_space_start_ip}/${var.address_space_size}"
  subnet_keys                   = keys(var.subnets)
  subnet_new_bits               = [for subnet in values(var.subnets) : subnet.size - var.address_space_size]
  cidr_subnets                  = cidrsubnets(local.virtual_network_address_space, local.subnet_new_bits...)

  subnets = { for key, value in var.subnets : key => {
    name             = key
    address_prefixes = [local.cidr_subnets[index(local.subnet_keys, key)]]
    network_security_group = value.has_network_security_group ? {
      id = module.network_security_group.resource_id
    } : null
    nat_gateway = value.has_nat_gateway ? {
      id = module.nat_gateway.resource_id
    } : null
    }
  }
}

# Diagnostic settings
locals {
  diagnostic_settings = {
    sendToLogAnalytics = {
      name                  = "sendToLogAnalytics"
      workspace_resource_id = module.log_analytics_workspace.resource.id
    }
  }
}
