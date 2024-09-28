alias_provider = {
  sub1     = azurerm.sub1
  hub_sub1 = azurerm.hub_sub1
}

subscription_id     = "e39d7cfb-d17a-469e-8812-790e0a04825e"
hub_subscription_id = "d37c4fd1-7016-4acd-93f9-2935dce3cdde"

resource_group_name_connectivity = "rg-Fabric-Corp-Connectivity-prod-eus"

ddos_protection_plan_name = "ddos-chub-uks"
vnet_resource_group_name  = "rg-dfc-config-prod-uks"
vnet_address_space        = ["10.204.67.0/24"]
name                      = "sn-stfabricprodeus-eus"
cidr                      = "10.204.67.0/25"
vnet_name                 = "vnet-cis-fabric-prod-eus"


service_endpoints = ["Microsoft.EventHub", "Microsoft.KeyVault", "Microsoft.Web", "Microsoft.Storage"]
# nsg_id= var.nsg_id
# route_table_id = "/subscriptions/5132c26c-51da-4450-aa7a-a9d861c9950b/resourceGroups/rg-Fabric-Corp-Connectivity-eus/providers/Microsoft.Network/routeTables/rt-cis-fabric-d-eus"

###################################
storage_account_name     = "stfabricprodeus"
resource_group_name_adls = "rg-Fabric-Corp-Application-prod-eus"
location                 = "East US"
containers = {
  "object1" = {
    container_name        = "scrip-landing"
    container_access_type = "private"
  },
  "object2" = {
    container_name        = "scrip-stage"
    container_access_type = "private"
  },

  "object3" = {
    container_name        = "scrip-error"
    container_access_type = "private"
  },
  "object4" = {
    container_name        = "scrip-archive"
    container_access_type = "private"
} }
account_tier             = "Standard"
account_replication_type = "RAGRS"
account_kind             = "StorageV2"

#### private endpoint ####

private_enpoints = {
  "object1" = {
    private_endpoint_name      = "pe-st-blob-stfabricprodeus"
    private_service_connection = "connection"
    subresource_name           = "blob"
  },
  "object2" = {
    private_endpoint_name      = "pe-st-dfs-stfabricprodeus"
    private_service_connection = "connection1"
    subresource_name           = "dfs"
} }

private_enpoints_kv = {
  "object1" = {
    private_endpoint_name      = "pe-st-kv-stfabricprodeus"
    private_service_connection = "connection"
    subresource_name           = "vault"
} }

##### Vnet Peering 1 #####
vnet_peering_name_1    = "vnet-cis-fabric-prod-eus-vnet-chub-eus"
vnet_peering_rg_name_1 = "rg-dfc-config-prod-uks"
vnet_name_1            = "vnet-cis-fabric-prod-eus"



##### Vnet Peering 2 #####
vnet_peering_name_2    = "vnet-chub-eus-vnet-cis-fabric-prod-eus"
vnet_peering_rg_name_2 = "rg-chub-connectivity-eus"
vnet_name_2            = "vnet-chub-eus"

##### Route Table 1 #####

route_table_name_1     = "rt-cis-fabric-prod-eus"
route_table_location_1 = "East US"
# route_table_rg_name_1 = "rg-dfc-config-prod-uks"



##### Route 1 #####
route_name_1 = "udr-default"
# route_rg_name_1 = "rg-dfc-config-prod-uks"

key_vault_name = "kv-fabricnp-prod-eus"
kv_sku_name    = "standard"
access_policies = [{
  certificate_permissions = ["Get", "List"]
  key_permissions         = ["Get", "List"]
  secret_permissions      = ["Get", "List"]
}]
#Scrip-landing and scrip-stage :full,delta,non-issuer
storage-containers = ["scrip-landing", "scrip-stage"]
container_folders  = ["full", "delta", "non-issuer"]

