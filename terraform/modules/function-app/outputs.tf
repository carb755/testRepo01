output "function_app_id" {
  description = "The ID of the function app"
  value       = azurerm_linux_function_app.main.id
}

output "function_app_name" {
  description = "The name of the function app"
  value       = azurerm_linux_function_app.main.name
}

output "default_hostname" {
  description = "The default hostname of the function app"
  value       = azurerm_linux_function_app.main.default_hostname
}

output "outbound_ip_addresses" {
  description = "The outbound IP addresses of the function app"
  value       = azurerm_linux_function_app.main.outbound_ip_addresses
}
