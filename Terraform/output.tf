output "resource_group_name" {
  value = data.azurerm_resource_group.aces.name
}

output "keyvault_id" {
  value = azurerm_key_vault.e2e.id
}