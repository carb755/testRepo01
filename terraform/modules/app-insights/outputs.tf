output "app_insights_id" {
  description = "The ID of the Application Insights"
  value       = azurerm_application_insights.main.id
}

output "instrumentation_key" {
  description = "The instrumentation key of the Application Insights"
  value       = azurerm_application_insights.main.instrumentation_key
  sensitive   = true
}

output "connection_string" {
  description = "The connection string of the Application Insights"
  value       = azurerm_application_insights.main.connection_string
  sensitive   = true
}

output "app_id" {
  description = "The app ID of the Application Insights"
  value       = azurerm_application_insights.main.app_id
}
