# Module Documentation

This document provides detailed information about each infrastructure module available in this repository.

## Table of Contents

- [Storage Account](#storage-account)
- [Function App](#function-app)
- [Logic App](#logic-app)
- [SQL Database](#sql-database)
- [Cosmos DB](#cosmos-db)
- [Key Vault](#key-vault)
- [Application Insights](#application-insights)

---

## Storage Account

### Description
Creates an Azure Storage Account with default containers for data and logs.

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `storage_account_name` | string | - | Name of the storage account (must be globally unique) |
| `resource_group_name` | string | - | Name of the resource group |
| `location` | string | `eastus` | Azure region |
| `account_tier` | string | `Standard` | Storage account tier |
| `account_replication_type` | string | `LRS` | Replication type |
| `enable_https_traffic_only` | bool | `true` | Enable HTTPS only |
| `min_tls_version` | string | `TLS1_2` | Minimum TLS version |
| `tags` | map | `{}` | Resource tags |

### Outputs

- `storage_account_id` - Resource ID
- `storage_account_name` - Account name
- `primary_blob_endpoint` - Blob endpoint URL
- `primary_access_key` - Primary access key (sensitive)
- `primary_connection_string` - Connection string (sensitive)

### Usage

**Terraform:**
```hcl
module "storage_account" {
  source = "../../modules/storage-account"
  
  storage_account_name = "mystorageacct123"
  resource_group_name  = azurerm_resource_group.main.name
  location             = "eastus"
  tags                 = var.tags
}
```

**Bicep:**
```bicep
module storageAccount '../../modules/storage-account/main.bicep' = {
  name: 'storageAccountDeployment'
  params: {
    storageAccountName: 'mystorageacct123'
    location: location
    tags: tags
  }
}
```

---

## Function App

### Description
Creates an Azure Function App with Linux runtime support.

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `function_app_name` | string | - | Name of the function app |
| `resource_group_name` | string | - | Name of the resource group |
| `location` | string | `eastus` | Azure region |
| `storage_account_name` | string | - | Storage account for function app |
| `storage_account_access_key` | string | - | Storage account access key (sensitive) |
| `app_service_plan_id` | string | - | App Service Plan ID |
| `runtime_stack` | string | `dotnet` | Runtime stack (dotnet, node, python, java) |
| `runtime_version` | string | `6` | Runtime version |
| `tags` | map | `{}` | Resource tags |

### Outputs

- `function_app_id` - Resource ID
- `function_app_name` - Function app name
- `default_hostname` - Default hostname
- `outbound_ip_addresses` - Outbound IP addresses

### Usage

**Terraform:**
```hcl
module "function_app" {
  source = "../../modules/function-app"
  
  function_app_name          = "my-function-app"
  resource_group_name        = azurerm_resource_group.main.name
  location                   = "eastus"
  storage_account_name       = module.storage.storage_account_name
  storage_account_access_key = module.storage.primary_access_key
  app_service_plan_id        = azurerm_service_plan.main.id
  tags                       = var.tags
}
```

---

## Logic App

### Description
Creates an Azure Logic App workflow.

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `logic_app_name` | string | - | Name of the logic app |
| `resource_group_name` | string | - | Name of the resource group |
| `location` | string | `eastus` | Azure region |
| `tags` | map | `{}` | Resource tags |

### Outputs

- `logic_app_id` - Resource ID
- `logic_app_name` - Logic app name
- `access_endpoint` - Access endpoint URL

---

## SQL Database

### Description
Creates an Azure SQL Server and Database.

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `server_name` | string | - | Name of the SQL server |
| `database_name` | string | - | Name of the database |
| `resource_group_name` | string | - | Name of the resource group |
| `location` | string | `eastus` | Azure region |
| `administrator_login` | string | - | Admin username |
| `administrator_login_password` | string | - | Admin password (sensitive) |
| `sku_name` | string | `S0` | Database SKU |
| `max_size_gb` | number | `32` | Maximum database size in GB |
| `tags` | map | `{}` | Resource tags |

### Outputs

- `sql_server_id` - Server resource ID
- `sql_server_fqdn` - Fully qualified domain name
- `database_id` - Database resource ID
- `database_name` - Database name
- `connection_string` - Connection string (sensitive)

### Best Practices

- Store credentials in Azure Key Vault
- Enable Advanced Threat Protection
- Configure firewall rules appropriately
- Use managed identities for authentication

---

## Cosmos DB

### Description
Creates an Azure Cosmos DB account with SQL API.

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `cosmos_account_name` | string | - | Name of the Cosmos DB account |
| `database_name` | string | - | Name of the database |
| `container_name` | string | - | Name of the container |
| `resource_group_name` | string | - | Name of the resource group |
| `location` | string | `eastus` | Azure region |
| `partition_key_path` | string | `/id` | Partition key path |
| `throughput` | number | `400` | Throughput (RU/s) |
| `tags` | map | `{}` | Resource tags |

### Outputs

- `cosmos_account_id` - Account resource ID
- `cosmos_account_endpoint` - Account endpoint
- `cosmos_account_primary_key` - Primary key (sensitive)
- `connection_strings` - Connection strings (sensitive)
- `database_name` - Database name

---

## Key Vault

### Description
Creates an Azure Key Vault for secrets management.

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `key_vault_name` | string | - | Name of the Key Vault |
| `resource_group_name` | string | - | Name of the resource group |
| `location` | string | `eastus` | Azure region |
| `tenant_id` | string | - | Azure AD tenant ID |
| `sku_name` | string | `standard` | SKU (standard or premium) |
| `enabled_for_disk_encryption` | bool | `true` | Enable for disk encryption |
| `soft_delete_retention_days` | number | `7` | Soft delete retention (7-90 days) |
| `purge_protection_enabled` | bool | `false` | Enable purge protection |
| `tags` | map | `{}` | Resource tags |

### Outputs

- `key_vault_id` - Resource ID
- `key_vault_uri` - Vault URI
- `key_vault_name` - Vault name

### Security Considerations

- Configure access policies for users and applications
- Enable soft delete in production
- Consider enabling purge protection for critical vaults
- Use RBAC for fine-grained access control

---

## Application Insights

### Description
Creates an Azure Application Insights instance for application monitoring.

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `app_insights_name` | string | - | Name of Application Insights |
| `resource_group_name` | string | - | Name of the resource group |
| `location` | string | `eastus` | Azure region |
| `application_type` | string | `web` | Application type |
| `tags` | map | `{}` | Resource tags |

### Outputs

- `app_insights_id` - Resource ID
- `instrumentation_key` - Instrumentation key (sensitive)
- `connection_string` - Connection string (sensitive)
- `app_id` - Application ID

### Integration

Use the instrumentation key or connection string in your applications:

**Environment Variables:**
```bash
APPLICATIONINSIGHTS_CONNECTION_STRING=<connection-string>
```

**Function App Settings:**
```hcl
app_settings = {
  APPINSIGHTS_INSTRUMENTATIONKEY = module.app_insights.instrumentation_key
}
```
