# Azure Provider source and version being used
terraform { //https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#example-usage
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" { //https://developer.hashicorp.com/terraform/language/settings/backends/azurerm#example-configuration
    resource_group_name  = "rg-msdocs-tables-sdk-demo"
    storage_account_name = "rgmsdocstablessdkstorage"
    container_name       = "terraform"                    // 
    key                  = "staticsite.terraform.tfstate" //"nameYouWant.terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" { //https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#example-usage
  features {}
}


resource "azurerm_resource_group" "resource_group" { //https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group#example-usage
  name     = "rg-terraform-static-demo"
  location = "eastus"
}

resource "azurerm_storage_account" "storage_account" {                      //https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#example-usage
  name                     = "storagedemo101a"                              // azure says this can only be lowercase and 3-24 char long
  resource_group_name      = azurerm_resource_group.resource_group.name     // By specifying resource_group.name it will get the name rg-terraform-static-demo from the above block
  location                 = azurerm_resource_group.resource_group.location // By specifying resource_group.location it will get the name eastus from the above block
  account_tier             = "Standard"
  account_replication_type = "LRS"       // can be changed based on need
  account_kind             = "StorageV2" // can be changed based on need

  enable_https_traffic_only = true // this forces people to access this via https


  tags = {
    environment = "dev"
  }
}


resource "azurerm_storage_blob" "storage_blob_site" {                   // https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_blob#type
  name                   = "storage-terraform-blog-site"                // choose a name you want
  storage_account_name   = azurerm_storage_account.storage_account.name // Use the .storage_account.name to refer to the name of the storage account above
  storage_container_name = "$web"                                       // that is needed for the static web site just like in the gui
  type                   = "Block"
  content_type           = "text/html" // that is needed for the static web site just like in the gui
  source                 = "C:/Programming/Projects/DeployStaticSiteAzureTerrraform/Static-Website-Test.html"
}