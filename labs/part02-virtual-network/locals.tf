# Calculate resource names
locals {
  name_replacements = {
    workload    = var.resource_name_workload
    environment = var.resource_name_environment
    location    = var.location
    sequence    = format("%03d", var.resource_name_sequence_start)
  }

  resource_names = { for key, value in var.resource_name_templates : key => templatestring(value, local.name_replacements) }
}

# Calculate the CIDR for the subnets
locals {
  subnets = { for key, value in var.subnets : key => {
    name             = key
    address_prefixes = [module.avm-utl-network-ip-addresses.address_prefixes[key]]
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
