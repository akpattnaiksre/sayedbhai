
variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}



variable "resource_id" {
  type = string
}



variable "private_enpoints" {
  description = "A map of container objects"
  type = map(object({
    private_endpoint_name      = string
    private_service_connection = string
    subresource_name           = string
  }))
}