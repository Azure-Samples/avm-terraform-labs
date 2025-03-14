variable "location" {
  type        = string
  description = "The location/region where the resources will be created. Must be in the short form (e.g. 'uksouth')"
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.location))
    error_message = "The location must only contain lowercase letters, numbers, and hyphens"
  }
  validation {
    condition     = length(var.location) <= 20
    error_message = "The location must be 20 characters or less"
  }
}

variable "resource_name_workload" {
  type        = string
  description = "The name segment for the workload"
  default     = "demo"
  validation {
    condition     = can(regex("^[a-z0-9]+$", var.resource_name_workload))
    error_message = "The name segment for the workload must only contain lowercase letters and numbers"
  }
  validation {
    condition     = length(var.resource_name_workload) <= 4
    error_message = "The name segment for the workload must be 4 characters or less"
  }
}

variable "resource_name_environment" {
  type        = string
  description = "The name segment for the environment"
  default     = "dev"
  validation {
    condition     = can(regex("^[a-z0-9]+$", var.resource_name_environment))
    error_message = "The name segment for the environment must only contain lowercase letters and numbers"
  }
  validation {
    condition     = length(var.resource_name_environment) <= 4
    error_message = "The name segment for the environment must be 4 characters or less"
  }
}

variable "resource_name_sequence_start" {
  type        = number
  description = "The number to use for the resource names"
  default     = 1
  validation {
    condition     = var.resource_name_sequence_start >= 1 && var.resource_name_sequence_start <= 999
    error_message = "The number must be between 1 and 999"
  }
}
variable "resource_name_templates" {
  type        = map(string)
  description = "A map of resource names to use"
  default = {
    resource_group_name          = "rg-$${workload}-$${environment}-$${location}-$${sequence}"
    log_analytics_workspace_name = "law-$${workload}-$${environment}-$${location}-$${sequence}"
    virtual_network_name         = "vnet-$${workload}-$${environment}-$${location}-$${sequence}"
    network_security_group_name  = "nsg-$${workload}-$${environment}-$${location}-$${sequence}"
    nat_gateway_name             = "nat-$${workload}-$${environment}-$${location}-$${sequence}"
    nat_gateway_public_ip_name   = "pip-nat-$${workload}-$${environment}-$${location}-$${sequence}"
  }
}

variable "address_space" {
  type        = string
  description = "The address space that is used the virtual network"
}

variable "subnets" {
  type = map(object({
    size                       = number
    has_nat_gateway            = bool
    has_network_security_group = bool
  }))
  description = "The subnets"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}
