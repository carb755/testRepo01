output "logic_app_id" {
  description = "The ID of the logic app"
  value       = azurerm_logic_app_workflow.main.id
}

output "logic_app_name" {
  description = "The name of the logic app"
  value       = azurerm_logic_app_workflow.main.name
}

output "access_endpoint" {
  description = "The access endpoint for the logic app"
  value       = azurerm_logic_app_workflow.main.access_endpoint
}
