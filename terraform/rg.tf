resource "azurerm_resource_group" "rg_ante" {
  name     = "rg_ante"
  location = "West Europe"
  tags     = merge(var.tags, { createdAt = timestamp() } )
}