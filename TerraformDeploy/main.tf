#needed
module "vnet_rg" {
  # source = "git::https://dev.azure.com/CTS-Babbage/VoyagerData/_git/TerraformModules//azure-resourcegroup?ref=0.0.1"
  source              = "../TerraformModules/azure-resourcegroup"
  resource_group_name = var.vnet_resource_group_name
  location            = var.location
}



module "connectivity_rg" {
  # source = "git::https://dev.azure.com/CTS-Babbage/VoyagerData/_git/TerraformModules//azure-resourcegroup?ref=0.0.1"
  source              = "../TerraformModules/azure-resourcegroup"
  resource_group_name = var.resource_group_name_connectivity
  location            = var.location
}

module "virtual_network" {
  # source = "git::https://dev.azure.com/CTS-Babbage/VoyagerData/_git/TerraformModules//networking?ref=0.0.1"
  source                    = "../TerraformModules/networking"
  ddos_protection_plan_name = var.ddos_protection_plan_name
  vnet_resource_group_name  = module.vnet_rg.resource_group_name
  vnet_location             = module.vnet_rg.location
  vnet_address_space        = var.vnet_address_space
  name                      = var.name
  cidr                      = var.cidr
  vnet_name                 = var.vnet_name
  # resource_group_name = var.resource_group_name
  # delegation = var.delegation
  service_endpoints = var.service_endpoints
  # nsg_id= var.nsg_id
  route_table_id = module.route_table_1.route_table_id
  depends_on     = [module.route_table_1, module.connectivity_rg]

}


module "Vnet_peering_1" {
  #source = "git::https://dev.azure.com/CTS-Babbage/VoyagerData/_git/TerraformModules//vnetpeering?ref=0.0.1"
  source                      = "../TerraformModules/vnetpeering"
  vnet_peering_name_2         = var.vnet_peering_name_2
  vnet_peering_rg_name_2      = var.vnet_peering_rg_name_2
  vnet_name_2                 = var.vnet_name_2
  vnet_peering_name_1         = var.vnet_peering_name_1
  vnet_peering_rg_name_1      = module.virtual_network.vnet_rg_op
  vnet_name_1                 = module.virtual_network.vnet_name_op
  remote_virtual_network_id_1 = module.virtual_network.vnet_id_op
  providers = {
    # azurerm.sub1 = azurerm
    azurerm.hub_sub1 = azurerm.hub_sub1
  }

}




##### Route Table #####

module "route_table_1" {
  #source = "git::https://dev.azure.com/CTS-Babbage/VoyagerData/_git/TerraformModules//routetable?ref=0.0.1"
  source               = "../TerraformModules/routetable"
  route_table_name     = var.route_table_name_1
  route_table_location = var.route_table_location_1
  route_table_rg_name  = module.connectivity_rg.resource_group_name
}

module "route_1" {
  #source = "git::https://dev.azure.com/CTS-Babbage/VoyagerData/_git/TerraformModules//route?ref=0.0.1"
  source                 = "../TerraformModules/route"
  route_name             = var.route_name_1
  route_rg_name          = module.connectivity_rg.resource_group_name
  route_table_name       = var.route_table_name_1
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.204.2.70"
  depends_on             = [module.route_table_1]
}


# not needed
module "rg" {
  # source = "git::https://dev.azure.com/CTS-Babbage/VoyagerData/_git/TerraformModules//azure-resourcegroup?ref=0.0.1"
  source              = "../TerraformModules/azure-resourcegroup"
  resource_group_name = var.resource_group_name_adls
  location            = var.location
}




module "adls" {
  # source = "git::https://dev.azure.com/CTS-Babbage/VoyagerData/_git/TerraformModules//azure-storageaccount?ref=0.0.1"
  source                   = "../TerraformModules/azure-storageaccount"
  storage_account_name     = var.storage_account_name
  resource_group_name      = module.rg.resource_group_name
  location                 = var.location
  containers               = tomap(var.containers)
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
  storage-containers       = var.storage-containers
  container_folders        = var.container_folders
  depends_on               = [module.Vnet_peering_1]

}

module "private_endpoint" {
  #source = "git::https://dev.azure.com/CTS-Babbage/VoyagerData/_git/TerraformModules//private-endpoint?ref=0.0.1"
  source              = "../TerraformModules/private-endpoint"
  private_enpoints    = tomap(var.private_enpoints)
  location            = var.location
  resource_group_name = module.connectivity_rg.resource_group_name
  subnet_id           = module.virtual_network.subnet_id
  resource_id         = module.adls.id
  depends_on          = [module.Vnet_peering_1, module.route_table_1]

}


module "kv" {
  # source = "git::https://dev.azure.com/CTS-Babbage/VoyagerData/_git/TerraformModules//azure-resourcegroup?ref=0.0.1"
  source         = "../TerraformModules/azure-keyvault"
  key_vault_name = var.key_vault_name
  #  purge_protection_enabled = var.purge_protection_enabled
  #  soft_delete_retention_days = var.soft_delete_retention_days
  kv_sku_name     = var.kv_sku_name
  access_policies = var.access_policies
  #  public_network_access_enabled= var.public_network_access_enabled 
  resource_group_name = module.rg.resource_group_name
  location            = var.location
}

module "private_endpoint_kv" {
  #source = "git::https://dev.azure.com/CTS-Babbage/VoyagerData/_git/TerraformModules//private-endpoint?ref=0.0.1"
  source              = "../TerraformModules/private-endpoint"
  private_enpoints    = tomap(var.private_enpoints_kv)
  location            = var.location
  resource_group_name = module.connectivity_rg.resource_group_name
  subnet_id           = module.virtual_network.subnet_id
  resource_id         = module.kv.id
  depends_on          = [module.Vnet_peering_1, module.route_table_1]

}








