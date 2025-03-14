module "avm-utl-network-ip-addresses" {
  source  = "Azure/avm-utl-network-ip-addresses/azurerm"
  version = "0.1.0"

  address_space    = var.address_space
  address_prefixes = { for key, value in var.subnets : key => value.size }
}