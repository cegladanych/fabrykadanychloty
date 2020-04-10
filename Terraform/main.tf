terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  version = "=2.4.0" 
  skip_provider_registration = "true"
}

data "azurerm_client_config" "current" {}

