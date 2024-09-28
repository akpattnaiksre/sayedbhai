terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "3.115.0"
      configuration_aliases = [azurerm.hub_sub1]
    }
  }
}


# data "azurerm_virtual_network" "existing_vnet_1" {
# #   provider = azurerm.sub1
#   name                = var.vnet_name_1
#   resource_group_name = var.vnet_peering_rg_name_1
# }


data "azurerm_virtual_network" "existing_vnet_2" {
  provider            = azurerm.hub_sub1
  name                = var.vnet_name_2
  resource_group_name = var.vnet_peering_rg_name_2
}

resource "azurerm_virtual_network_peering" "virtual_network_peering_1" {
  #   provider = azurerm.sub1
  name                         = var.vnet_peering_name_1
  resource_group_name          = var.vnet_peering_rg_name_1
  virtual_network_name         = var.vnet_name_1
  remote_virtual_network_id    = data.azurerm_virtual_network.existing_vnet_2.id
  allow_forwarded_traffic      = true
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "virtual_network_peering_2" {
  provider                     = azurerm.hub_sub1
  name                         = var.vnet_peering_name_2
  resource_group_name          = var.vnet_peering_rg_name_2
  virtual_network_name         = var.vnet_name_2
  remote_virtual_network_id    = var.remote_virtual_network_id_1
  allow_forwarded_traffic      = true
  allow_virtual_network_access = true
}



