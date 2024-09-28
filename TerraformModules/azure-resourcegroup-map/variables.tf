# variable "resource_group_name" {
#   type        = string
#   description = "The name of the resource group in which to create the storage account."
# }

# variable "location" {
#   type        = string
#   description = "The location/region in which to create the storage account."
# }
# variable "resource_group_map" {
#   default = {
#     dev = {
#       rg_name = "luke"
#       location = ""
#       key_vault_name = "4252"
#       kv_sku_name= "4252"
#       soft_delete_retention_days= "4252"
#       purge_protection_enabled= "4252"
#       access_policies= "4252"
#       public_network_access_enabled= "4252"
#       storage_account_name = 
#       account_tier =
#       account_replication_type = 
#       account_kind = 
#       storage-containers = 
#       container_folders = 
#     }
#     ptest = {
#       rg = "luke"
#       kv = 4252
#     }
#     pperf = {
#       rg = "luke"
#       kv = 4252
#     }
#   }
# }


variable "resource_group_map" {
  type = map(object({
    rg_name                       = string
    location                      = string
    key_vault_name                = string
    kv_sku_name                   = string
    soft_delete_retention_days    = string
    purge_protection_enabled      = bool
    access_policies               = list(any)
    public_network_access_enabled = bool
    storage_account_name          = string
    account_tier                  = string
    account_replication_type      = string
    account_kind                  = string
    containers_folders            = map(list(string))
    # storage-containers = list(string)
    # container_folders = list(string)
  }))
}