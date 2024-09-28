data "azurerm_client_config" "current" {

}
resource "azurerm_key_vault" "keyvault-env" {
  name                          = var.key_vault_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = var.kv_sku_name
  soft_delete_retention_days    = var.soft_delete_retention_days
  purge_protection_enabled      = var.purge_protection_enabled
  public_network_access_enabled = var.public_network_access_enabled



  dynamic "access_policy" {
    for_each = var.access_policies
    content {
      tenant_id = data.azurerm_client_config.current.tenant_id
      object_id = data.azurerm_client_config.current.object_id

      key_permissions         = access_policy.value.key_permissions
      secret_permissions      = access_policy.value.secret_permissions
      certificate_permissions = access_policy.value.certificate_permissions
    }
  }
}

# resource "azurerm_key_vault_secret" "secret" {
#   count         = length(var.secrets) > 0 ? length(var.secrets) : 0
#   name          = var.secrets[count.index].secret_name
#   value         = var.secrets[count.index].secret_value
#   key_vault_id  = azurerm_key_vault.keyvault-env.id
# }