# Name of the keyvault
variable "key_vault_name" {
  type = string

}
# As per policy purge protection should be enabled
variable "purge_protection_enabled" {
  type    = bool
  default = true
}

// variable "create_secrets" {
//   type = bool
//   default = false
// }

variable "soft_delete_retention_days" {
  type    = number
  default = 90
}

# The Azure location where your resources will be created
variable "location" {
  type        = string
  description = " location for the resources"
}

# The name of the Azure resource group where your resources will be created
variable "resource_group_name" {
  type        = string
  description = "The name of the  resource group"
}

# The Azure tenant ID (the unique identifier of your Azure Active Directory instance)


# The SKU name for the Key Vault (e.g., "standard" or "premium")
variable "kv_sku_name" {
  type        = string
  description = "The SKU name for the Key Vault"
}

# The access policies for the Key Vault
variable "access_policies" {
  type = list(object({
    # object_id               = string
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
  }))
  default     = []
  description = "The access policies for the Key Vault"
}

#The secrets to be stored in the Key Vault
# variable "secrets" {
#   description = "The secrets to be stored in the key vault"
#   type        = list(object({
#     secret_name  = string
#     secret_value = string
#   }))
#   default = []
# }


#Variable for enabling public access. disabled by default
variable "public_network_access_enabled" {
  description = "Is public network access enabled?"
  type        = bool
  default     = false
}