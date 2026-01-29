# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location
  tags     = var.tags
}

# Storage Account
module "storage_account" {
  source = "../../modules/storage-account"

  storage_account_name = "st${var.project_name}${var.environment}"
  resource_group_name  = azurerm_resource_group.main.name
  location             = azurerm_resource_group.main.location
  tags                 = var.tags
}

# App Service Plan for Function App
resource "azurerm_service_plan" "main" {
  name                = "asp-${var.project_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "Y1"
  tags                = var.tags
}

# Function App
module "function_app" {
  source = "../../modules/function-app"

  function_app_name           = "func-${var.project_name}-${var.environment}"
  resource_group_name         = azurerm_resource_group.main.name
  location                    = azurerm_resource_group.main.location
  storage_account_name        = module.storage_account.storage_account_name
  storage_account_access_key  = module.storage_account.primary_access_key
  app_service_plan_id         = azurerm_service_plan.main.id
  tags                        = var.tags
}

# Logic App
module "logic_app" {
  source = "../../modules/logic-app"

  logic_app_name      = "logic-${var.project_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags                = var.tags
}

# Application Insights
module "app_insights" {
  source = "../../modules/app-insights"

  app_insights_name   = "appi-${var.project_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  application_type    = "web"
  tags                = var.tags
}

# Key Vault (requires tenant_id - should be passed as variable)
# Uncomment and configure when deploying
# module "key_vault" {
#   source = "../../modules/key-vault"
#
#   key_vault_name      = "kv-${var.project_name}-${var.environment}"
#   resource_group_name = azurerm_resource_group.main.name
#   location            = azurerm_resource_group.main.location
#   tenant_id           = data.azurerm_client_config.current.tenant_id
#   tags                = var.tags
# }

# SQL Database (requires admin credentials - should be passed as variables)
# Uncomment and configure when deploying
# module "sql_database" {
#   source = "../../modules/sql-database"
#
#   server_name                  = "sql-${var.project_name}-${var.environment}"
#   database_name                = "db-${var.project_name}-${var.environment}"
#   resource_group_name          = azurerm_resource_group.main.name
#   location                     = azurerm_resource_group.main.location
#   administrator_login          = "sqladmin"
#   administrator_login_password = "YourSecurePassword123!"
#   tags                         = var.tags
# }

# Cosmos DB (optional for NoSQL scenarios)
# Uncomment when deploying
# module "cosmos_db" {
#   source = "../../modules/cosmos-db"
#
#   cosmos_account_name = "cosmos-${var.project_name}-${var.environment}"
#   database_name       = "db-${var.project_name}"
#   container_name      = "data"
#   resource_group_name = azurerm_resource_group.main.name
#   location            = azurerm_resource_group.main.location
#   tags                = var.tags
# }
