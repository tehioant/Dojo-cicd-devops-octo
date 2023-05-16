provider "azurerm" {
  features {}
}

terraform {
  required_version = "1.4.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.52.0"
    }
  }
  backend "azurerm" {
    container_name       = "tfstates"
    storage_account_name = "dojocicdtfstate"
    key                  = "<your-poly>.tfstate"
    resource_group_name  = "rg-dojo-cicd"
  }
}