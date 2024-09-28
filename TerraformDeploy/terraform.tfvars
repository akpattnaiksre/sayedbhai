resource_group_map = {
  tekiondev = {
    rg_name                    = "tekion1dev"
    location                   = "francecentral"
    key_vault_name             = "tekion1test"
    kv_sku_name                = "standard"
    soft_delete_retention_days = "90"
    purge_protection_enabled   = true
    access_policies = [{
      certificate_permissions = ["Get", "List"]
      key_permissions         = ["Get", "List"]
      secret_permissions      = ["Get", "List"]
    }]
    public_network_access_enabled = true
    storage_account_name          = "tekion1tkion1"
    account_tier                  = "Standard"
    account_replication_type      = "RAGRS"
    account_kind                  = "StorageV2"
    containers_folders = {
      scrip-landing = ["full", "delta", "non-issuer"]
      scrip-stage   = ["full", "delta", "non-issuer"]
    }
    # storage-containers            = ["scrip-landing", "scrip-stage"]
    # container_folders             = ["full", "delta", "non-issuer"]

  },
  tekiontest = {
    rg_name                    = "tekion2test"
    location                   = "francecentral"
    key_vault_name             = "tekion2test"
    kv_sku_name                = "standard"
    soft_delete_retention_days = "90"
    purge_protection_enabled   = true
    access_policies = [{
      certificate_permissions = ["Get", "List"]
      key_permissions         = ["Get", "List"]
      secret_permissions      = ["Get", "List"]
    }]
    public_network_access_enabled = true
    storage_account_name          = "tekion2tkion2"
    account_tier                  = "Standard"
    account_replication_type      = "RAGRS"
    account_kind                  = "StorageV2"
    containers_folders = {
      scrip-landing = ["full", "delta", "non-issuer"]
      scrip-stage   = ["full", "delta", "non-issuer"]
    }

  }
}

log_analytics_workspace           = "tekiontestloganalytics"
monitor_diagnostic_setting_name   = "tekiontestloganalytics"
log_analytics_resource_group_name = "tekiontestloganalytics"
log_analytics_location            = "francecentral"
