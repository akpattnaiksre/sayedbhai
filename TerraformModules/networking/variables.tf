variable "ddos_protection_plan_name" {

}
variable "name" {
  description = "The name of the subnet"
  type        = string
}

variable "cidr" {
  description = "The CIDR block for the subnet"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

# variable "resource_group_name" {
#   description = "The name of the resource group"
#   type        = string
# }

variable "delegation" {
  description = "The name of the service to delegate to"
  type        = string
  default     = null
}

variable "service_endpoints" {
  description = "The list of service endpoints"
  type        = list(string)
  default     = []
}

variable "nsg_id" {
  description = "The ID of the network security group"
  type        = string
  default     = null
}

variable "route_table_id" {
  description = "The ID of the route table"
  type        = string
  default     = null
}

variable "vnet_location" {

}

variable "vnet_resource_group_name" {

}

variable "vnet_address_space" {

}
