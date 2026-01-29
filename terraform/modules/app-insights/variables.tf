variable "location" {
  description = "Azure region for the Application Insights"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "app_insights_name" {
  description = "Name of the Application Insights"
  type        = string
}

variable "application_type" {
  description = "Type of application being monitored"
  type        = string
  default     = "web"
}

variable "tags" {
  description = "Tags to apply to the Application Insights"
  type        = map(string)
  default     = {}
}
