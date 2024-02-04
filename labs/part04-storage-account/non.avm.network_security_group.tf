# Coming soon: https://github.com/Azure/Azure-Verified-Modules/issues/233
resource "azurerm_network_security_group" "this" {
  location            = azurerm_resource_group.this.location
  name                = local.network_security_group_name
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_network_security_rule" "no_internet" {
  access                      = "Deny"
  direction                   = "Outbound"
  name                        = "block-internet-traffic"
  network_security_group_name = azurerm_network_security_group.this.name
  priority                    = 100
  protocol                    = "*"
  resource_group_name         = azurerm_resource_group.this.name
  destination_address_prefix  = "Internet"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  source_port_range           = "*"
}
