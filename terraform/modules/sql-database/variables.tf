variable "location" {
  description = "Azure region for the SQL database"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "server_name" {
  description = "Name of the SQL server"
  type        = string
}

variable "database_name" {
  description = "Name of the SQL database"
  type        = string
}

variable "administrator_login" {
  description = "Administrator login for the SQL server"
  type        = string
}

variable "administrator_login_password" {
  description = "Administrator password for the SQL server"
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "SKU name for the database"
  type        = string
  default     = "S0"
}

variable "max_size_gb" {
  description = "Maximum size of the database in GB"
  type        = number
  default     = 32
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}
