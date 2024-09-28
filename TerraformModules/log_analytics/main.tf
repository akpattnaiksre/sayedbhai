resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = var.log_analytics_workspace
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

data "azurerm_monitor_diagnostic_categories" "monitor_diagnostic_categories" {
  resource_id = "/subscriptions/d92ade56-83bf-49f9-ba74-dbb15614ae84/resourceGroups/tekion1dev/providers/Microsoft.Storage/storageAccounts/tekion1tkion1"
}

output "monitor_diagnostic_categories" {
  value = data.azurerm_monitor_diagnostic_categories.monitor_diagnostic_categories.log_category_types
}

resource "azurerm_monitor_diagnostic_setting" "monitor_diagnostic_setting" {
  name               = var.monitor_diagnostic_setting_name
  target_resource_id = "${var.target_resource_id}/blobServices/default/" # The storage account resource

  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id # Link to Log Analytics



  enabled_log {
    category = "StorageRead"
  }

  enabled_log {
    category = "StorageWrite"
  }
  enabled_log {
    category = "StorageDelete"
  }

  depends_on = [azurerm_log_analytics_workspace.log_analytics_workspace]
  lifecycle {
    ignore_changes = [enabled_log, metric]
  }
}