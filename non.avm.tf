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

####################################################################################################

# Coming soon: TBC
resource "azurerm_user_assigned_identity" "this" {
  location            = azurerm_resource_group.this.location
  name                = local.user_assigned_managed_identity_name
  resource_group_name = azurerm_resource_group.this.name
}

####################################################################################################

# Coming soon: https://github.com/Azure/Azure-Verified-Modules/issues/306
resource "azurerm_private_dns_zone" "key_vault" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "key_vault" {
  name                  = "key-vault"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.key_vault.name
  virtual_network_id    = module.virtual_network.vnet-resource.id
}

resource "azurerm_private_dns_zone" "storage_account" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "storage_account" {
  name                  = "storage-account"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.storage_account.name
  virtual_network_id    = module.virtual_network.vnet-resource.id
}

####################################################################################################

# Coming soon: https://github.com/Azure/terraform-azurerm-avm-res-network-publicipaddress
resource "azurerm_public_ip" "bastionpip" {
  name                = local.bastion_host_public_ip_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

####################################################################################################

# Coming soon: https://github.com/Azure/terraform-azurerm-avm-res-network-bastionhost
resource "azurerm_bastion_host" "bastion" {
  name                = local.bastion_host_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                 = "ipconfig"
    subnet_id            = module.virtual_network.subnets["AzureBastionSubnet"].id
    public_ip_address_id = azurerm_public_ip.bastionpip.id
  }
}

####################################################################################################
