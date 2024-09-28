output "key_vault_id_op" {
  value = {
    for rg_key, key_vault in azurerm_key_vault.keyvault-env : rg_key => key_vault.id
  }
}

output "storage_account_id_op" {
  value = {
    for rg_key, storage in azurerm_storage_account.appstore : rg_key => storage.id
  }
}

