variable "location" {
  type        = string
  description = "The location/region where the resources will be created"
}

variable "address_space_start_ip" {
  type        = string
  description = "The address space that is used the virtual network"
}

variable "address_space_size" {
  type        = number
  description = "The address space that is used the virtual network"
}

variable "subnets_and_sizes" {
  type        = map(number)
  description = "The size of the subnets"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}
