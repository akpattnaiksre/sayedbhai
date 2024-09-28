terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "1.14.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.115.0"
    }
    # azurerm_hub = {
    #   source  = "hashicorp/azurerm"
    #   version = "3.115.0"
    #   Configuration_alias = [azurerm.hub_sub1]
    # }
  }
  backend "azurerm" {
    features {}
  }

}

provider "azapi" {}
provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = var.subscription_id
}

provider "azurerm" {
  # Configuration options
  features {}
  skip_provider_registration = true
  subscription_id            = var.hub_subscription_id
  alias                      = "hub_sub1"

}




