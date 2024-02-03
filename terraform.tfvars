location               = "uksouth"
address_space_start_ip = "10.0.0.0"
address_space_size     = 16
subnets_and_sizes = {
  AzureBastionSubnet = 24
  private_endpoints  = 28
  virtual_machines   = 24
}