resource "azurerm_private_endpoint" "generic_private_endpoint" {
  for_each            = var.private_enpoints
  name                = each.value.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = each.value.private_service_connection
    private_connection_resource_id = var.resource_id
    is_manual_connection           = false
    subresource_names              = [each.value.subresource_name]
  }

  lifecycle {
    ignore_changes = [
      tags,
      private_dns_zone_group,
    ]
  }
}