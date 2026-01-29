# Quick Start Guide

Get started with the Azure Infrastructure Library in minutes!

## 🚀 Quick Deploy - Development Environment

### Option 1: Terraform

```bash
# Clone repository
git clone <repo-url>
cd testRepo01

# Navigate to deployment
cd terraform/resource-groups/data-platform

# Initialize
terraform init

# Deploy (will prompt for confirmation)
terraform apply
```

### Option 2: Bicep

```bash
# Clone repository
git clone <repo-url>
cd testRepo01

# Navigate to deployment
cd bicep/resource-groups/data-platform

# Login to Azure
az login

# Deploy
az deployment sub create \
  --location eastus \
  --template-file main.bicep \
  --parameters main.parameters.json
```

## 📦 What Gets Deployed

By default, the data platform deployment creates:

1. **Resource Group** - `rg-dataplatform-dev`
2. **Storage Account** - `stdataplatformdev` (with data and logs containers)
3. **App Service Plan** - `asp-dataplatform-dev` (Consumption tier)
4. **Function App** - `func-dataplatform-dev`
5. **Logic App** - `logic-dataplatform-dev`
6. **Application Insights** - `appi-dataplatform-dev`

## 🔧 Customization

### Change Environment

**Terraform** - Edit `variables.tf` or create `terraform.tfvars`:
```hcl
environment = "prod"
```

**Bicep** - Edit `main.parameters.json`:
```json
"environment": {
  "value": "prod"
}
```

### Change Region

**Terraform:**
```hcl
location = "westus"
```

**Bicep:**
```json
"location": {
  "value": "westus"
}
```

### Add Additional Resources

Uncomment sections in `main.tf` or `main.bicep`:
- SQL Database
- Cosmos DB
- Key Vault

## 🔍 Verify Deployment

### Check Resources

```bash
# List all resources in the resource group
az resource list \
  --resource-group rg-dataplatform-dev \
  --output table
```

### Get Outputs

**Terraform:**
```bash
terraform output
terraform output storage_account_name
```

**Bicep:**
```bash
az deployment sub show \
  --name dataplatform-deployment \
  --query properties.outputs
```

## 🧹 Clean Up

### Remove Everything

**Terraform:**
```bash
cd terraform/resource-groups/data-platform
terraform destroy
```

**Bicep:**
```bash
az group delete --name rg-dataplatform-dev --yes
```

## 📚 Next Steps

1. **Explore Modules** - Check out individual modules in `terraform/modules/` or `bicep/modules/`
2. **Read Documentation** - See `docs/` for detailed guides
3. **Customize** - Modify for your specific needs
4. **Deploy to Production** - Use separate environments

## 🆘 Common Commands

### Terraform

```bash
# Validate configuration
terraform validate

# Format code
terraform fmt

# Show current state
terraform show

# List resources
terraform state list

# View specific resource
terraform state show azurerm_resource_group.main
```

### Bicep

```bash
# Build Bicep file
az bicep build --file main.bicep

# Validate template
az deployment group validate \
  --template-file main.bicep \
  --parameters main.parameters.json

# What-if analysis
az deployment group what-if \
  --template-file main.bicep \
  --parameters main.parameters.json
```

### Azure CLI

```bash
# Login
az login

# Set subscription
az account set --subscription <subscription-id>

# List resource groups
az group list --output table

# Show resource
az resource show --ids <resource-id>

# Delete resource group
az group delete --name <resource-group-name> --yes
```

## 💡 Tips

- **Start Small**: Deploy basic resources first, then add more
- **Use Variables**: Don't hardcode values
- **Tag Everything**: Makes cost tracking easier
- **Test First**: Always test in dev before prod
- **Document Changes**: Keep README files updated

## 📖 Learn More

- [Module Documentation](docs/modules.md) - Detailed module reference
- [Deployment Guide](docs/deployment.md) - Step-by-step deployment
- [Best Practices](docs/best-practices.md) - Azure best practices
- [Naming Conventions](docs/naming-conventions.md) - Resource naming

## 🤝 Get Help

- Check existing documentation
- Review example configurations
- Open an issue for bugs
- Contribute improvements

Happy deploying! 🎉
