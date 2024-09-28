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
    # storage-containers            = list(string)
    # container_folders             = list(string)
  }))
}


# variable "subscription_id" {

# }

# variable "hub_subscription_id" {

# }
# variable "resource_group_name_connectivity" {

# }

# variable "ddos_protection_plan_name" {

# }
# variable "vnet_resource_group_name" {

# }

# variable "vnet_address_space" {

# }
# variable "name" {
#   description = "The name of the subnet"
#   type        = string
# }

# variable "cidr" {
#   description = "The CIDR block for the subnet"
#   type        = string
# }

# variable "vnet_name" {
#   description = "The name of the virtual network"
#   type        = string
# }

# # variable "resource_group_name" {
# #   description = "The name of the resource group"
# #   type        = string
# # }

# # variable "delegation" {
# #   description = "The name of the service to delegate to"
# #   type        = string
# #   default     = null
# # }

# variable "service_endpoints" {
#   description = "The list of service endpoints"
#   type        = list(string)
#   default     = []
# }

# # variable "nsg_id" {
# #   description = "The ID of the network security group"
# #   type        = string
# #   default     = null
# # }

# # variable "route_table_id" {
# #   description = "The ID of the route table"
# #   type        = string
# #   default     = null
# # }

# ##### ADLS #####

# variable "storage_account_name" {
#   type        = string
#   description = "The name of the storage account."
# }

# variable "resource_group_name_adls" {
#   type        = string
#   description = "The name of the resource group in which to create the storage account."
# }

# variable "location" {
#   type        = string
#   description = "The location/region in which to create the storage account."
# }

# // variable "container_name" {
# //   description = "The name of the storage container"
# //   type        = string
# // }

# variable "containers" {
#   description = "A map of container objects"
#   type = map(object({
#     container_name        = string
#     container_access_type = string
#   }))
# }
# variable "account_tier" {
#   type        = string
#   description = "The location/region in which to create the storage account."
# }

# variable "account_replication_type" {
#   type        = string
#   description = "The location/region in which to create the storage account."
# }

# variable "account_kind" {
#   type        = string
#   description = "The location/region in which to create the storage account."
# }


# ###### Private Endpoint #####

# variable "private_enpoints" {
#   description = "A map of container objects"
#   type = map(object({
#     private_endpoint_name = string
#     private_service_connection = string
#     subresource_name = string
#   }))
# }

# ##### Vnet Peering 1 #####
# variable "vnet_peering_name_1" {
#   description = "The name of the Vnet name 1"
#   type        = string
# }

# variable "vnet_peering_rg_name_1" {
#   description = "The CIDR block for the subnet"
#   type        = string
# }

# variable "vnet_name_1" {
#   description = "The name of the virtual network"
#   type        = string
# }

# ##### Vnet Peering 2 #####
# variable "vnet_peering_name_2" {
#   description = "The name of the Vnet name 1"
#   type        = string
# }

# variable "vnet_peering_rg_name_2" {
#   description = "The CIDR block for the subnet"
#   type        = string
# }

# variable "vnet_name_2" {
#   description = "The name of the virtual network"
#   type        = string
# }

# ##### Route Table 1 #####


# variable "route_table_name_1" {
#   type        = string
#   description = "The name of the resource group in which to create the storage account."
# }

# variable "route_table_location_1" {
#   type        = string
#   description = "The location/region in which to create the storage account."
# }

# # variable "route_table_rg_name_1" {
# #   type        = string
# #   description = "The location/region in which to create the storage account."

# # }

# ##### Route 1 #####
# variable "route_name_1" {
#   type        = string
#   description = "The name of the resource group in which to create the storage account."
# }

# # variable "route_rg_name_1" {
# #   type        = string
# #   description = "The location/region in which to create the storage account."
# # }

# # Name of the keyvault
# variable "key_vault_name" {
#   type = string

# }
# # As per policy purge protection should be enabled
# variable "purge_protection_enabled" {
#   type = bool
#   default = true
# }



# variable "soft_delete_retention_days" {
#   type = number
#   default = 90
# }




# # The Azure tenant ID (the unique identifier of your Azure Active Directory instance)


# # The SKU name for the Key Vault (e.g., "standard" or "premium")
# variable "kv_sku_name" {
#   type = string
#   description = "The SKU name for the Key Vault"
# }

# # The access policies for the Key Vault
# variable "access_policies" {
#   type = list(object({
#     # object_id               = string
#     key_permissions         = list(string)
#     secret_permissions      = list(string)
#     certificate_permissions = list(string)
#   }))
#   default = []
#   description = "The access policies for the Key Vault"
# }

# variable "private_enpoints_kv" {
#  type = map(object({
#     private_endpoint_name = string
#     private_service_connection = string
#     subresource_name = string
#   }))

# }





# # #Variable for enabling public access. disabled by default
# # variable "public_network_access_enabled" {
# #   description = "Is public network access enabled?"
# #   type        = bool
# #   default     = false
# # }


# variable "storage-containers" {
#   type        = list(string)
#   description = "The location/region in which to create the storage account."
# }

# variable "container_folders" {
#   type        = list(string)
#   description = "The location/region in which to create the storage account."
# }