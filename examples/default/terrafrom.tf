terraform {
  required_version = ">= 1.15"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.77"
    }
     azapi = {
      source  = "azure/azapi"
      version = "~> 1.13"
    }
  }
}
