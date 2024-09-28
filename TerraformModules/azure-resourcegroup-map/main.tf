# https://stackoverflow.com/questions/56776130/map-within-a-map-in-terraform-variables


resource "azurerm_resource_group" "resource_group" {
  for_each = var.resource_group_map
  name     = each.value.rg_name
  location = each.value.location
}


resource "azurerm_key_vault" "keyvault-env" {
  for_each                      = var.resource_group_map
  name                          = each.value.key_vault_name
  location                      = each.value.location
  resource_group_name           = each.value.rg_name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = each.value.kv_sku_name
  soft_delete_retention_days    = each.value.soft_delete_retention_days
  purge_protection_enabled      = each.value.purge_protection_enabled
  public_network_access_enabled = each.value.public_network_access_enabled



  dynamic "access_policy" {
    for_each = each.value.access_policies
    content {
      tenant_id = data.azurerm_client_config.current.tenant_id
      object_id = data.azurerm_client_config.current.object_id

      key_permissions         = access_policy.value.key_permissions
      secret_permissions      = access_policy.value.secret_permissions
      certificate_permissions = access_policy.value.certificate_permissions
    }
  }
  depends_on = [azurerm_resource_group.resource_group]
}


# locals {
#   for_each = var.resource_group_map
#   container_folders_combo = setproduct(each.value.storage-containers,each.value.container_folders)
# }

resource "azurerm_storage_account" "appstore" {
  for_each                          = var.resource_group_map
  name                              = each.value.storage_account_name
  resource_group_name               = each.value.rg_name
  location                          = each.value.location
  account_tier                      = each.value.account_tier
  account_replication_type          = each.value.account_replication_type
  account_kind                      = each.value.account_kind
  public_network_access_enabled     = true # Disables public network access
  allow_nested_items_to_be_public   = true # Ensures nested items are not public
  is_hns_enabled                    = true
  infrastructure_encryption_enabled = true

  network_rules {
    default_action = "Deny"
    # Add additional network rules as needed
  }
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
  depends_on = [azurerm_resource_group.resource_group]
}

# resource "azurerm_storage_data_lake_gen2_filesystem" "data_lake_gen2_filesystem" {
#   for_each = var.resource_group_map
#   for_each = var.containers
#   name               = each.value.container_name
#   storage_account_id = azurerm_storage_account.appstore.id
#   timeouts {
#     create = "10m"
#     update = "10m"
#     delete = "10m"
#   }
#   depends_on = [ azurerm_storage_account.appstore ]
# }

# resource "azurerm_storage_container" "storage_containers" {
#   for_each = {for k, v in var.resource_group_map : k => v.containers }

#   storage_account_name = azurerm_storage_account.storage_accounts[each.key].name
#   name                 = each.key # This will be the container name
# }

# resource "azurerm_storage_data_lake_gen2_path" "path" {
#   for_each = {for folder in setproduct(each.value.storage-containers,each.value.container_folders) : "${folder[0]}_${folder[1]}" => folder }
#   path               = each.value[1]
#   filesystem_name    = each.value[0]
#   storage_account_id = azurerm_storage_account.appstore[each.key].id
#   resource           = "directory"
# }


# Create file systems (Data Lake Gen2 containers)
resource "azurerm_storage_data_lake_gen2_filesystem" "data_lake_gen2_filesystem" {
  for_each = {
    for i, data in local.container_map : "${data.rg_key}-${data.container_name}" => data
  }

  storage_account_id = azurerm_storage_account.appstore[each.value.storage_account].id
  name               = each.value.container_name
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
  depends_on = [azurerm_storage_account.appstore]
}


# Create directories inside the file systems
# resource "azurerm_storage_data_lake_gen2_path" "folders" {
#   for_each = flatten([
#     for storage_key, file_system_map in var.resource_group_map : [
#       for file_system_name, folders in file_system_map.containers_folders : [
#         for folder in folders : {
#           storage_account = azurerm_storage_account.appstore[storage_key].name
#           file_system     = file_system_name
#           folder_name     = folder
#         }
#       ]
#     ]
#   ])

#   filesystem_name       = azurerm_storage_data_lake_gen2_filesystem.data_lake_filesystems[each.value.file_system].name
#   storage_account_id    = azurerm_storage_account.appstore[each.value.storage_account].id
#   path                  = each.value.folder_name
#   resource              = "directory"
# }

resource "azurerm_storage_data_lake_gen2_path" "folders" {
  for_each = {
    for data in flatten([
      for rg_key, rg_value in var.resource_group_map : [
        for container_name, folders in rg_value.containers_folders : [
          for folder in folders : {
            rg_key          = rg_key
            storage_account = rg_key
            container_name  = container_name
            folder_name     = folder
            unique_key      = "${rg_key}-${container_name}"
          }
        ]
      ]
    ]) : "${data.rg_key}-${data.container_name}-${data.folder_name}" => data
  }

  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.data_lake_gen2_filesystem[each.value.unique_key].name
  storage_account_id = azurerm_storage_account.appstore[each.value.storage_account].id
  path               = each.value.folder_name
  resource           = "directory"
  depends_on         = [azurerm_storage_account.appstore, azurerm_storage_data_lake_gen2_filesystem.data_lake_gen2_filesystem]
}