# Azure Naming Conventions

This document outlines the naming conventions used in this repository for Azure resources.

## General Principles

1. **Use lowercase** - All resource names should be lowercase
2. **Use hyphens** - Use hyphens (-) to separate words in resource names
3. **Be descriptive** - Names should clearly indicate the resource purpose
4. **Include environment** - Always include environment identifier (dev, stg, prod)
5. **Follow Azure limits** - Respect length and character restrictions

## Naming Pattern

```
<resource-type>-<project>-<environment>-<region>-<instance>
```

Components:
- **resource-type**: Abbreviation for Azure resource type
- **project**: Project or application name
- **environment**: Environment identifier (dev, stg, prod)
- **region**: Azure region (optional, for multi-region deployments)
- **instance**: Instance number (optional, for multiple instances)

## Resource Type Abbreviations

| Resource Type | Abbreviation | Example |
|--------------|--------------|---------|
| Resource Group | rg | rg-dataplatform-dev |
| Storage Account | st | stdataplatformdev |
| Function App | func | func-dataplatform-dev |
| Logic App | logic | logic-dataplatform-dev |
| App Service Plan | asp | asp-dataplatform-dev |
| SQL Server | sql | sql-dataplatform-dev |
| SQL Database | db | db-dataplatform-dev |
| Cosmos DB | cosmos | cosmos-dataplatform-dev |
| Key Vault | kv | kv-dataplatform-dev |
| App Insights | appi | appi-dataplatform-dev |
| Virtual Network | vnet | vnet-dataplatform-dev |
| Subnet | snet | snet-dataplatform-dev |
| Network Security Group | nsg | nsg-dataplatform-dev |
| Application Gateway | agw | agw-dataplatform-dev |
| Load Balancer | lb | lb-dataplatform-dev |
| Public IP | pip | pip-dataplatform-dev |
| Virtual Machine | vm | vm-dataplatform-dev |
| Disk | disk | disk-dataplatform-dev |

## Special Naming Rules

### Storage Account
- **No hyphens** - Azure storage accounts don't support hyphens
- **Globally unique** - Must be unique across all of Azure
- **Max 24 characters** - Keep it short
- Pattern: `st<project><environment><suffix>`
- Example: `stdataplatformdev01`

### Key Vault
- **Max 24 characters**
- Pattern: `kv-<project>-<env>`
- Example: `kv-dataplat-dev`

### Function App
- **Globally unique** - DNS name must be unique
- Pattern: `func-<project>-<environment>`
- Example: `func-dataplatform-dev`

### Cosmos DB
- **Globally unique** - Account name must be unique
- **Max 44 characters**
- Pattern: `cosmos-<project>-<environment>`
- Example: `cosmos-dataplatform-dev`

## Environment Identifiers

| Environment | Identifier | Usage |
|-------------|-----------|--------|
| Development | dev | Development and testing |
| Staging | stg | Pre-production staging |
| Production | prod | Production environment |
| QA/Test | qa | Quality assurance |
| Demo | demo | Demonstration environment |

## Region Codes (Optional)

Use when deploying to multiple regions:

| Region | Code | Full Name |
|--------|------|-----------|
| East US | eus | eastus |
| West US | wus | westus |
| Central US | cus | centralus |
| North Europe | neu | northeurope |
| West Europe | weu | westeurope |

Example: `rg-dataplatform-prod-eus`

## Tagging Strategy

All resources should include these tags:

```hcl
tags = {
  Environment = "dev"           # dev, stg, prod
  Project     = "DataPlatform"  # Project name
  ManagedBy   = "Terraform"     # Terraform or Bicep
  Owner       = "TeamName"      # Team responsible
  CostCenter  = "CC-1234"       # Cost allocation
  DataClass   = "Confidential"  # Data classification
}
```

## Examples

### Development Environment

```
rg-dataplatform-dev
stdataplatformdev
func-dataplatform-dev
logic-dataplatform-dev
asp-dataplatform-dev
sql-dataplatform-dev
db-dataplatform-dev
cosmos-dataplatform-dev
kv-dataplat-dev
appi-dataplatform-dev
```

### Production Environment with Region

```
rg-dataplatform-prod-eus
stdataplatformprodeus
func-dataplatform-prod-eus
logic-dataplatform-prod-eus
asp-dataplatform-prod-eus
sql-dataplatform-prod-eus
db-dataplatform-prod-eus
cosmos-dataplatform-prod-eus
kv-dataplat-prod-eus
appi-dataplatform-prod-eus
```

### Multiple Instances

```
func-dataplatform-prod-01
func-dataplatform-prod-02
sql-dataplatform-prod-primary
sql-dataplatform-prod-secondary
```

## Validation

Before deploying, validate names against Azure requirements:

- Storage accounts: 3-24 characters, lowercase letters and numbers only
- Key Vault: 3-24 characters, alphanumeric and hyphens
- Function App: 2-60 characters, alphanumeric and hyphens
- SQL Server: 1-63 characters, lowercase letters, numbers, and hyphens

## Best Practices

1. **Be consistent** - Use the same pattern across all resources
2. **Keep it short** - Shorter names are easier to work with
3. **Avoid redundancy** - Don't repeat information (e.g., "azure" in name)
4. **Document exceptions** - Note any deviations from standards
5. **Use automation** - Generate names programmatically to ensure consistency

## References

- [Azure Naming Conventions](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging)
- [Resource Naming Restrictions](https://docs.microsoft.com/azure/azure-resource-manager/management/resource-name-rules)
