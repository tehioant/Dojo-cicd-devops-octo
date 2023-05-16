resource "azurerm_service_plan" "ochoNinja" {
  name                = "<name of you service plan>"
  resource_group_name = "<link to resource group>"
  location            = "<resource group location>"
  os_type             = "Linux"
  sku_name            = "Y1" # Consumption Plan
  tags                = local.mandatoryTags
}

resource "azurerm_storage_account" "ochoNinjaAccess" {
  name                      = "<name of you storage account>"
  resource_group_name       = "<link to resource group>"
  location                  = "<resource group location>"
  account_replication_type  = "LRS"
  account_tier              = "Standard"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  tags                      = local.mandatoryTags
}

resource "azurerm_linux_function_app" "UserAccess" {
  name                       =  "<name of you azure function app>"
  resource_group_name        = "<link to resource group>"
  location                   = "<resource group location>"
  storage_account_name       = "<link to storage account>"
  storage_account_access_key = azurerm_storage_account.ochoNinjaAccess.primary_access_key
  service_plan_id            = "<link to service plan>"
  tags                       = local.mandatoryTags

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
  }

  site_config {
    always_on     = false
    http2_enabled = true
    application_stack {
      node_version = "16"
    }
  }
}