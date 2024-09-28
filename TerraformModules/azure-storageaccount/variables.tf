variable "storage_account_name" {
  type        = string
  description = "The name of the storage account."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account."
}

variable "location" {
  type        = string
  description = "The location/region in which to create the storage account."
}

// variable "container_name" {
//   description = "The name of the storage container"
//   type        = string
// }

variable "containers" {
  description = "A map of container objects"
  type = map(object({
    container_name        = string
    container_access_type = string
  }))
}
variable "account_tier" {
  type        = string
  description = "The location/region in which to create the storage account."
}

variable "account_replication_type" {
  type        = string
  description = "The location/region in which to create the storage account."
}

variable "account_kind" {
  type        = string
  description = "The location/region in which to create the storage account."
}

variable "storage-containers" {
  type        = list(string)
  description = "The location/region in which to create the storage account."
}

variable "container_folders" {
  type        = list(string)
  description = "The location/region in which to create the storage account."
}



// variable "container_access_type" {
//   description = "The access type of the storage container"
//   type        = string
// }

