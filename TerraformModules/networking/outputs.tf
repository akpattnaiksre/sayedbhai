output "subnet_id" {
  description = "The ID of the created subnet"
  value       = azurerm_subnet.subnet.id
}


output "subnet_name" {
  description = "The name of the created subnet"
  value       = azurerm_subnet.subnet.name
}

output "vnet_rg_op" {
  value = azurerm_virtual_network.virtual_network.resource_group_name
}

output "vnet_location_op" {
  value = azurerm_virtual_network.virtual_network.location
}

output "vnet_name_op" {
  value = azurerm_virtual_network.virtual_network.name
}

output "vnet_id_op" {
  value = azurerm_virtual_network.virtual_network.id
}