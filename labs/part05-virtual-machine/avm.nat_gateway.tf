module "nat_gateway" {
  source  = "Azure/avm-res-network-natgateway/azurerm"
  version = "0.2.1"

  resource_group_name = module.resource_group.name
  location            = var.location
  name                = local.nat_gateway_name
  public_ips = {
    default = {
      name = local.nat_public_ip_name
    }
  }
}
