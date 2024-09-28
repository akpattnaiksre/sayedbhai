resource "azurerm_route_table" "route_table" {
  name                = var.route_table_name
  location            = var.route_table_location
  resource_group_name = var.route_table_rg_name
}
