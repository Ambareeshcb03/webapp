terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.17.0"
    }
  }
}

provider "azurerm" {
  features {}

  

}

resource "azurerm_resource_group" "webapprg" {
  name     = var.webapprg
  location = var.location
}

resource "azurerm_service_plan" "appserviceplan" {
  name                = var.appserviceplan
  resource_group_name = azurerm_resource_group.webapprg.name
  location            = azurerm_resource_group.webapprg.location
  sku_name            = "S1"
  os_type             = "Windows"

  depends_on = [azurerm_resource_group.webapprg]
}

resource "azurerm_windows_web_app" "testwebapp" {
  name                = var.testwebapp
  resource_group_name = azurerm_resource_group.webapprg.name
  location            = azurerm_resource_group.webapprg.location
  service_plan_id     = azurerm_service_plan.appserviceplan.id

 

  site_config {}
}
