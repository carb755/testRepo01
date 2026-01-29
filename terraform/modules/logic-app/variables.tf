variable "location" {
  description = "Azure region for the logic app"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "logic_app_name" {
  description = "Name of the logic app"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the logic app"
  type        = map(string)
  default     = {}
}
