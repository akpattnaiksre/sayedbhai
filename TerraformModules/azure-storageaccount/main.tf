locals {
  container_folders_combo = setproduct(var.storage-containers, var.container_folders)
}

resource "azurerm_storage_account" "appstore" {
  name                            = var.storage_account_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  account_kind                    = var.account_kind
  public_network_access_enabled   = false # Disables public network access
  allow_nested_items_to_be_public = false # Ensures nested items are not public
  is_hns_enabled                  = true

  network_rules {
    default_action = "Deny"
    # Add additional network rules as needed
  }
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}

# resource "azurerm_storage_container" "container" {
#   for_each = var.containers

#   name                  = each.value.container_name
#   storage_account_name  = azurerm_storage_account.appstore.name
#   container_access_type = each.value.container_access_type
#   depends_on = [ azurerm_storage_account.appstore ]
# }


# Other resources omitted for brevity

# resource "azapi_resource" "storage_container" {
#   for_each = var.containers
#   type      = "Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01"
#   name      = each.value.container_name
#   parent_id = "${azurerm_storage_account.appstore.id}/blobServices/default"

#   body = jsonencode({
#     properties = {
#       # Set publicAccess to `None` to match the default behavior of
#       # azurerm_storage_container. May also be set to `Blob` or `Container`.
#       publicAccess = "None"
#     }
#   })
#   timeouts {
#     create = "10m"
#     update = "10m"
#     delete = "10m"
#   }
#   depends_on = [ azurerm_storage_account.appstore ]
# }

resource "azurerm_storage_data_lake_gen2_filesystem" "data_lake_gen2_filesystem" {
  for_each           = var.containers
  name               = each.value.container_name
  storage_account_id = azurerm_storage_account.appstore.id
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
  depends_on = [azurerm_storage_account.appstore]
}


# resource "azapi_resource_action" "storage_container_folder" {
#   for_each = var.containers
#   type      = "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write@2021-09-01"

#   resource_id = "${azapi_resource.storage_container[each.key].id}"

#   body = jsonencode({
#     properties = {
#       # Set publicAccess to `None` to match the default behavior of
#       # azurerm_storage_container. May also be set to `Blob` or `Container`.
#       blobType = "BlockBlob"
#     },
#     name = "myfolder/",
#     contentLength = 0
#   })
#   depends_on = [ azurerm_storage_account.appstore ]
# }

# resource "azurerm_storage_blob" "blob_folder" {
#   for_each = var.containers
#   name                   = "myfolder/"
#   storage_account_name   = azurerm_storage_account.appstore.name
#   storage_container_name = each.value.container_name
#   type                   = "Block"
#   source                 = ""
# }



resource "azurerm_storage_data_lake_gen2_path" "path" {
  for_each           = { for folder in local.container_folders_combo : "${folder[0]}_${folder[1]}" => folder }
  path               = each.value[1]
  filesystem_name    = each.value[0]
  storage_account_id = azurerm_storage_account.appstore.id
  resource           = "directory"
}