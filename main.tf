# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  terraform {
  backend "azurerm" {
    resource_group_name  = "rg-msdocs-tables-sdk-demo"
    storage_account_name = "rgmsdocstablessdkstorage"
    container_name       = "terraform"
    key                  = "msdocs.terraform.tfstate"
  }
}
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}


