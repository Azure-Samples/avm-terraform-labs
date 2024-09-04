module "nat_gateway" {
  source  = "Azure/avm-res-network-natgateway/azurerm"
  version = "0.2.0"

  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  name                = local.nat_gateway_name
  public_ips = {
    default = {
      name = local.nat_public_ip_name
    }
  }
}
