# data "azurerm_virtual_network" "existing" {
#   name                = var.vnet_name
#   resource_group_name = var.vnet_resource_group_name
# }

resource "azurerm_network_ddos_protection_plan" "ddos_protection_plan" {
  name                = var.ddos_protection_plan_name
  location            = var.vnet_location
  resource_group_name = var.vnet_resource_group_name
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = var.vnet_name
  location            = var.vnet_location
  resource_group_name = var.vnet_resource_group_name
  address_space       = var.vnet_address_space
  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.ddos_protection_plan.id
    enable = true
  }

}

resource "azurerm_subnet" "subnet" {
  name                 = var.name
  resource_group_name  = azurerm_virtual_network.virtual_network.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [var.cidr]

  dynamic "delegation" {
    for_each = var.delegation != null ? [1] : []
    content {
      name = "delegation"

      service_delegation {
        name    = var.delegation
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }
  }

  service_endpoints = var.service_endpoints != null ? var.service_endpoints : []

  depends_on = [azurerm_virtual_network.virtual_network]
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  count                     = var.nsg_id != null ? 1 : 0
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = var.nsg_id
}

resource "azurerm_subnet_route_table_association" "subnet_route_table" {
  # count = var.route_table_id != null ? 1 : 0
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = var.route_table_id
}