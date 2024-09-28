output "location" {
  description = "The location of the Azure Storage Account"
  value       = azurerm_resource_group.resource_group.location
}

output "resource_group_name" {
  description = "The name of the resource group that the Azure Storage Account is in"
  value       = azurerm_resource_group.resource_group.name
}

output "resource_group_id" {
  description = "The name of the resource group that the Azure Storage Account is in"
  value       = azurerm_resource_group.resource_group.id
}