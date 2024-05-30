# Define resource names
locals {
  unique_postfix = random_pet.unique_name.id

  resource_group_name          = "rg-demo-${local.unique_postfix}"
  log_analytics_workspace_name = "law-demo-${local.unique_postfix}"
  virtual_network_name         = "vnet-demo-${local.unique_postfix}"
  network_security_group_name  = "nsg-demo-${local.unique_postfix}"
}

# Caluculate the CIDR for the subnets
locals {
  virtual_network_address_space = "${var.address_space_start_ip}/${var.address_space_size}"
  subnet_keys                   = keys(var.subnets_and_sizes)
  subnet_new_bits               = [for size in values(var.subnets_and_sizes) : size - var.address_space_size]
  cidr_subnets                  = cidrsubnets(local.virtual_network_address_space, local.subnet_new_bits...)

  skip_nsg = ["AzureBastionSubnet", "virtual_machines"]
  subnets = { for key, value in var.subnets_and_sizes : key => {
    name             = key
    address_prefixes = [local.cidr_subnets[index(local.subnet_keys, key)]]
    network_security_group = contains(local.skip_nsg, key) ? null : {
      id = module.network_security_group.resource_id
    }
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
