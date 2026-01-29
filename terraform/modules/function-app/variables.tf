variable "location" {
  description = "Azure region for the function app"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "function_app_name" {
  description = "Name of the function app"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account for the function app"
  type        = string
}

variable "storage_account_access_key" {
  description = "Access key for the storage account"
  type        = string
  sensitive   = true
}

variable "app_service_plan_id" {
  description = "ID of the app service plan"
  type        = string
}

variable "runtime_stack" {
  description = "Runtime stack for the function app"
  type        = string
  default     = "dotnet"
}

variable "runtime_version" {
  description = "Runtime version"
  type        = string
  default     = "6"
}

variable "tags" {
  description = "Tags to apply to the function app"
  type        = map(string)
  default     = {}
}
