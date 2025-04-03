module "nat_gateway" {
  source  = "Azure/avm-res-network-natgateway/azurerm"
  version = "~> 0.2"

  resource_group_name = module.resource_group.name
  location            = var.location
  name                = module.naming.nat_gateway.name
  public_ips = {
    default = {
      name = module.naming.public_ip.name_unique
    }
  }
}
