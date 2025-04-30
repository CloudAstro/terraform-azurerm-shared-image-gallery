terraform {
  required_version = "~> 1.9.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
     azapi = {
      source  = "azure/azapi"
      version = "~> 1.13"
    }
  }

  backend "azurerm" {
    key                  = "image-build.tfstate"
    resource_group_name  = "resource_group_name"
    storage_account_name = "storage_account_name"
    container_name       = "container_name"
  }
}
