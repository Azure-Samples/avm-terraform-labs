terraform {
  required_version = "~> 1.10"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.19"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.4"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false # This is to handle MCAPS or other policy driven resource creation.
    }
  }
  resource_provider_registrations = "extended"
  storage_use_azuread             = true
}
