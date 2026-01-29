# Data Platform Resource Group Deployment (Bicep)

This Bicep configuration deploys a complete data platform infrastructure to Azure, organized by resource group.

## Resources Deployed

- Resource Group
- Storage Account (with data and logs containers)
- App Service Plan (Consumption tier)
- Function App
- Logic App
- Application Insights

## Prerequisites

1. Azure CLI installed and logged in
2. Bicep CLI >= 0.4 installed
3. Appropriate Azure permissions

## Usage

### Deploy at Subscription Level

```bash
az deployment sub create \
  --location eastus \
  --template-file main.bicep \
  --parameters main.parameters.json
```

### Deploy to Existing Resource Group

If you want to deploy to an existing resource group, modify the `targetScope` in `main.bicep` to `resourceGroup` and use:

```bash
az deployment group create \
  --resource-group <resource-group-name> \
  --template-file main.bicep \
  --parameters main.parameters.json
```

### Validate Template

Before deploying, validate your template:

```bash
az deployment sub validate \
  --location eastus \
  --template-file main.bicep \
  --parameters main.parameters.json
```

### What-If Analysis

Preview changes before deployment:

```bash
az deployment sub what-if \
  --location eastus \
  --template-file main.bicep \
  --parameters main.parameters.json
```

## Customization

Edit `main.parameters.json` to customize:
- Environment name
- Azure region
- Project name
- Resource tags

## Optional Resources

To add additional resources like SQL Database, Cosmos DB, or Key Vault:

1. Add the module reference in `main.bicep`
2. Add required parameters to `main.parameters.json`
3. Redeploy

Example for SQL Database:

```bicep
module sqlDatabase '../../modules/sql-database/main.bicep' = {
  name: 'sqlDatabaseDeployment'
  scope: resourceGroup
  params: {
    serverName: 'sql-${projectName}-${environment}'
    databaseName: 'db-${projectName}-${environment}'
    location: location
    administratorLogin: 'sqladmin'
    administratorLoginPassword: 'YourSecurePassword123!'
    tags: tags
  }
}
```

## Clean Up

To delete all resources:

```bash
az group delete --name <resource-group-name> --yes
```

## Notes

- Resource names follow Azure naming conventions
- Storage account name must be globally unique (automatically generated)
- Some resources may require additional configuration for production use
- Bicep provides better type checking and validation than ARM templates
