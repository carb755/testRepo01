output "sql_server_id" {
  description = "The ID of the SQL server"
  value       = azurerm_mssql_server.main.id
}

output "sql_server_fqdn" {
  description = "The FQDN of the SQL server"
  value       = azurerm_mssql_server.main.fully_qualified_domain_name
}

output "database_id" {
  description = "The ID of the SQL database"
  value       = azurerm_mssql_database.main.id
}

output "database_name" {
  description = "The name of the SQL database"
  value       = azurerm_mssql_database.main.name
}

output "connection_string" {
  description = "The connection string for the database"
  value       = "Server=tcp:${azurerm_mssql_server.main.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.main.name};Persist Security Info=False;User ID=${var.administrator_login};Password=${var.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  sensitive   = true
}
