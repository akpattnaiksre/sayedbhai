module "test" {
  source             = "../TerraformModules/azure-resourcegroup-map"
  resource_group_map = var.resource_group_map
}


module "log_analytics_rg" {
  # source = "git::https://dev.azure.com/CTS-Babbage/VoyagerData/_git/TerraformModules//azure-resourcegroup?ref=0.0.1"
  source              = "../TerraformModules/azure-resourcegroup"
  resource_group_name = var.log_analytics_resource_group_name
  location            = var.log_analytics_location
}


locals {
  # Flatten the nested containers_folders map into a list of maps with required values
  container_map = flatten([
    for rg_key, rg_value in var.resource_group_map : [
      for container_name, container in rg_value.containers_folders : {
        rg_key          = rg_key
        storage_account = rg_key
        container_name  = container_name
      }
    ]
  ])
}

module "log_analytics_workspace" {
  for_each = var.resource_group_map

  source                          = "../TerraformModules/log_analytics"
  log_analytics_workspace         = var.log_analytics_workspace
  location                        = each.value.location
  resource_group_name             = module.log_analytics_rg.resource_group_name
  monitor_diagnostic_setting_name = var.monitor_diagnostic_setting_name
  target_resource_id              = module.test.storage_account_id_op[each.key]
  depends_on                      = [module.test]

}

variable "log_analytics_workspace" {

}

variable "monitor_diagnostic_setting_name" {

}

variable "log_analytics_resource_group_name" {

}
variable "log_analytics_location" {

}