module "network_security_group" {
  source              = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version             = "0.2.0"
  resource_group_name = azurerm_resource_group.this.name
  name                = local.network_security_group_name
  location            = azurerm_resource_group.this.location

  security_rules = {
    no_internet = {
      access                     = "Deny"
      direction                  = "Outbound"
      name                       = "block-internet-traffic"
      priority                   = 100
      protocol                   = "*"
      destination_address_prefix = "Internet"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      source_port_range          = "*"
    }
  }

  diagnostic_settings = { for k, v in local.diagnostic_settings : k => {
    name                  = v.name
    workspace_resource_id = v.workspace_resource_id
    metric_categories     = []
    }
  }
  tags = var.tags
}
