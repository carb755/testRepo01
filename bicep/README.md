# Bicep Infrastructure

This directory contains Bicep configurations for deploying Azure infrastructure organized by best practices.

## Structure

- **modules/** - Reusable Bicep modules for each resource type
- **resource-groups/** - Resource group-specific deployments

## Quick Start

1. Navigate to the desired resource group:
   ```bash
   cd resource-groups/data-platform
   ```

2. Deploy using Azure CLI:
   ```bash
   az deployment group create \
     --resource-group <resource-group-name> \
     --template-file main.bicep \
     --parameters main.parameters.json
   ```

3. Or deploy at subscription level:
   ```bash
   az deployment sub create \
     --location eastus \
     --template-file main.bicep \
     --parameters main.parameters.json
   ```

## Module Usage

Each module can be used independently in your Bicep configurations:

```bicep
module storageAccount '../modules/storage-account/main.bicep' = {
  name: 'storageAccountDeployment'
  params: {
    storageAccountName: 'mystorageacct'
    location: location
    tags: tags
  }
}
```

## Best Practices

- Use parameters for environment-specific values
- Leverage modules for reusability
- Apply consistent naming conventions
- Use resource tagging strategy
- Implement proper RBAC and security

## Validation

Before deploying, validate your templates:
```bash
az deployment group validate \
  --resource-group <resource-group-name> \
  --template-file main.bicep \
  --parameters main.parameters.json
```

## What-If Analysis

Preview changes before deployment:
```bash
az deployment group what-if \
  --resource-group <resource-group-name> \
  --template-file main.bicep \
  --parameters main.parameters.json
```
