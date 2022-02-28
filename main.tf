terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tf_rg_blogstorage"
    storage_account_name = "tfstorageagbonnon10"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}


# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf_test" {
  name = "tfmainrg"
  location = "East US"
}

resource "azurerm_container_group" "tfcg_test" {
  name                  = "weatherapi"
  location              = azurerm_resource_group.tf_test.location
  resource_group_name   = azurerm_resource_group.tf_test.name

  ip_address_type       = "public"
  dns_name_label        = "agbonnon10dns"
  os_type               = "linux"

  container {
    name                = "weatherapi"
    image               = "agbonnon10/weatherapi"
        cpu               = "1"
        memory            = "1"

        ports {
        port              = 80
        protocol          = "TCP"
        }   
  }

}