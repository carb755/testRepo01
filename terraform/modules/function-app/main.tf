resource "azurerm_linux_function_app" "main" {
  name                       = var.function_app_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  service_plan_id            = var.app_service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  site_config {
    application_stack {
      dotnet_version = var.runtime_version
    }
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = var.runtime_stack
  }

  tags = var.tags
}
