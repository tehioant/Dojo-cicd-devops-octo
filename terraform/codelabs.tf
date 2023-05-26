resource "azurerm_storage_account" "sa_codelabs" {
  name                     = "sadojocodelabs"
  resource_group_name      = azurerm_resource_group.rg_ante.name
  location                 = azurerm_resource_group.rg_ante.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = var.tags
}

resource "azurerm_storage_container" "sc_codelabs" {
  name                  = "scdojocodelabs"
  storage_account_name  = azurerm_storage_account.sa_codelabs.name
  container_access_type = "blob"
}