# Data Platform Resource Group Deployment

This Terraform configuration deploys a complete data platform infrastructure to Azure, organized by resource group.

## Resources Deployed

- Resource Group
- Storage Account (with data and logs containers)
- App Service Plan (Consumption tier)
- Function App
- Logic App
- Application Insights

## Optional Resources (Commented Out)

- Key Vault (requires tenant_id)
- SQL Database (requires admin credentials)
- Cosmos DB (for NoSQL scenarios)

## Prerequisites

1. Azure CLI installed and logged in
2. Terraform >= 1.0 installed
3. Appropriate Azure permissions

## Usage

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Review the plan:
   ```bash
   terraform plan
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```

4. View outputs:
   ```bash
   terraform output
   ```

## Customization

Edit `variables.tf` to customize:
- Environment name
- Azure region
- Project name
- Resource tags

Uncomment sections in `main.tf` to enable:
- Key Vault
- SQL Database
- Cosmos DB

## Clean Up

To destroy all resources:
```bash
terraform destroy
```

## Notes

- Resource names follow Azure naming conventions
- Storage account name must be globally unique (automatically generated)
- Some resources may require additional configuration for production use
