variable "location" {
  description = "Azure region for the Cosmos DB account"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "cosmos_account_name" {
  description = "Name of the Cosmos DB account"
  type        = string
}

variable "database_name" {
  description = "Name of the Cosmos DB database"
  type        = string
}

variable "container_name" {
  description = "Name of the Cosmos DB container"
  type        = string
}

variable "partition_key_path" {
  description = "Partition key path for the container"
  type        = string
  default     = "/id"
}

variable "throughput" {
  description = "Throughput for the container"
  type        = number
  default     = 400
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}
