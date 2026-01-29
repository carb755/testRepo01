# Terraform Infrastructure

This directory contains Terraform configurations for deploying Azure infrastructure organized by best practices.

## Structure

- **modules/** - Reusable Terraform modules for each resource type
- **environments/** - Environment-specific configurations (dev, staging, prod)
- **resource-groups/** - Resource group-specific deployments

## Quick Start

1. Navigate to the desired environment:
   ```bash
   cd environments/dev
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the plan:
   ```bash
   terraform plan
   ```

4. Apply the configuration:
   ```bash
   terraform apply
   ```

## Module Usage

Each module can be used independently in your Terraform configurations:

```hcl
module "storage_account" {
  source              = "../../modules/storage-account"
  storage_account_name = "mystorageacct"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags                = var.tags
}
```

## Best Practices

- Use remote state storage (Azure Storage Account)
- Leverage modules for reusability
- Use variables for environment-specific values
- Apply consistent tagging strategy
- Use workspaces for environment isolation
