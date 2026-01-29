output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = module.storage_account.storage_account_name
}

output "function_app_name" {
  description = "The name of the function app"
  value       = module.function_app.function_app_name
}

output "function_app_url" {
  description = "The URL of the function app"
  value       = "https://${module.function_app.default_hostname}"
}

output "logic_app_name" {
  description = "The name of the logic app"
  value       = module.logic_app.logic_app_name
}

output "app_insights_instrumentation_key" {
  description = "The Application Insights instrumentation key"
  value       = module.app_insights.instrumentation_key
  sensitive   = true
}
