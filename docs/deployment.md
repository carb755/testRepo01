# Deployment Guide

This guide provides step-by-step instructions for deploying the Azure infrastructure using Terraform and Bicep.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Initial Setup](#initial-setup)
- [Terraform Deployment](#terraform-deployment)
- [Bicep Deployment](#bicep-deployment)
- [Post-Deployment](#post-deployment)
- [Common Issues](#common-issues)

---

## Prerequisites

### Required Tools

1. **Azure CLI** (>= 2.0)
   ```bash
   az --version
   ```
   Install: https://docs.microsoft.com/cli/azure/install-azure-cli

2. **Terraform** (>= 1.0)
   ```bash
   terraform version
   ```
   Install: https://www.terraform.io/downloads

3. **Bicep CLI** (>= 0.4)
   ```bash
   az bicep version
   ```
   Install: https://learn.microsoft.com/azure/azure-resource-manager/bicep/install

### Azure Permissions

- Contributor or Owner role on the subscription
- Permissions to create resource groups and resources

---

## Initial Setup

### 1. Login to Azure

```bash
az login
```

### 2. Set Active Subscription

```bash
# List subscriptions
az account list --output table

# Set active subscription
az account set --subscription "<subscription-id>"
```

### 3. Clone Repository

```bash
git clone <repository-url>
cd testRepo01
```

---

## Terraform Deployment

### Step 1: Navigate to Deployment Directory

```bash
cd terraform/resource-groups/data-platform
```

### Step 2: Review Variables

Edit `variables.tf` or create a `terraform.tfvars` file:

```hcl
# terraform.tfvars
environment  = "dev"
location     = "eastus"
project_name = "dataplatform"

tags = {
  Environment = "dev"
  ManagedBy   = "Terraform"
  Project     = "DataPlatform"
}
```

### Step 3: Initialize Terraform

```bash
terraform init
```

This will:
- Download required providers
- Initialize backend
- Validate configuration

### Step 4: Plan Deployment

```bash
terraform plan -out=tfplan
```

Review the plan carefully to understand what will be created.

### Step 5: Apply Configuration

```bash
terraform apply tfplan
```

Or apply directly:
```bash
terraform apply
```

Enter `yes` when prompted.

### Step 6: View Outputs

```bash
terraform output
```

To get specific output:
```bash
terraform output storage_account_name
```

### Step 7: Save State (Optional)

For team environments, configure remote state:

```hcl
# backend.tf
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate123"
    container_name       = "tfstate"
    key                  = "dataplatform.terraform.tfstate"
  }
}
```

---

## Bicep Deployment

### Step 1: Navigate to Deployment Directory

```bash
cd bicep/resource-groups/data-platform
```

### Step 2: Review Parameters

Edit `main.parameters.json`:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "environment": {
      "value": "dev"
    },
    "location": {
      "value": "eastus"
    },
    "projectName": {
      "value": "dataplatform"
    }
  }
}
```

### Step 3: Validate Template

```bash
az deployment sub validate \
  --location eastus \
  --template-file main.bicep \
  --parameters main.parameters.json
```

### Step 4: Preview Changes (What-If)

```bash
az deployment sub what-if \
  --location eastus \
  --template-file main.bicep \
  --parameters main.parameters.json
```

### Step 5: Deploy

**Subscription-level deployment:**
```bash
az deployment sub create \
  --location eastus \
  --template-file main.bicep \
  --parameters main.parameters.json \
  --name dataplatform-deployment
```

**Resource group deployment (if resource group exists):**
```bash
az deployment group create \
  --resource-group rg-dataplatform-dev \
  --template-file main.bicep \
  --parameters main.parameters.json
```

### Step 6: View Outputs

```bash
az deployment sub show \
  --name dataplatform-deployment \
  --query properties.outputs
```

---

## Post-Deployment

### 1. Verify Resources

```bash
# List resources in resource group
az resource list \
  --resource-group rg-dataplatform-dev \
  --output table
```

### 2. Test Function App

```bash
# Get function app URL
func_url=$(terraform output -raw function_app_url)
echo "Function App URL: $func_url"

# Test endpoint
curl https://${func_url}
```

### 3. Access Application Insights

```bash
# Get Application Insights details
az monitor app-insights component show \
  --app appi-dataplatform-dev \
  --resource-group rg-dataplatform-dev
```

### 4. Configure Access Policies (Key Vault)

If using Key Vault, grant access to your identity:

```bash
# Get your object ID
object_id=$(az ad signed-in-user show --query id -o tsv)

# Set access policy
az keyvault set-policy \
  --name kv-dataplatform-dev \
  --object-id $object_id \
  --secret-permissions get list set delete
```

### 5. Configure Firewall Rules (SQL Database)

Add your IP to SQL Server firewall:

```bash
# Get your public IP
my_ip=$(curl -s https://api.ipify.org)

# Add firewall rule
az sql server firewall-rule create \
  --resource-group rg-dataplatform-dev \
  --server sql-dataplatform-dev \
  --name AllowMyIP \
  --start-ip-address $my_ip \
  --end-ip-address $my_ip
```

---

## Common Issues

### Issue 1: Storage Account Name Not Unique

**Error:**
```
The storage account name 'stdataplatformdev' is already taken.
```

**Solution:**
Add a unique suffix to the storage account name:
```hcl
storage_account_name = "st${var.project_name}${var.environment}${random_string.suffix.result}"
```

### Issue 2: Insufficient Permissions

**Error:**
```
Authorization failed for user
```

**Solution:**
- Verify you have Contributor or Owner role
- Check subscription is correct: `az account show`

### Issue 3: Resource Provider Not Registered

**Error:**
```
The subscription is not registered to use namespace 'Microsoft.Storage'
```

**Solution:**
```bash
az provider register --namespace Microsoft.Storage
az provider register --namespace Microsoft.Web
az provider register --namespace Microsoft.Logic
az provider register --namespace Microsoft.Sql
az provider register --namespace Microsoft.DocumentDB
az provider register --namespace Microsoft.KeyVault
```

### Issue 4: Terraform State Lock

**Error:**
```
Error acquiring the state lock
```

**Solution:**
- Wait for other operations to complete
- If stuck, manually break lock (use with caution):
  ```bash
  terraform force-unlock <lock-id>
  ```

### Issue 5: Bicep Compilation Error

**Error:**
```
Unable to compile Bicep file
```

**Solution:**
- Update Bicep CLI: `az bicep upgrade`
- Validate syntax: `az bicep build --file main.bicep`

---

## Clean Up

### Terraform

```bash
cd terraform/resource-groups/data-platform
terraform destroy
```

### Bicep

```bash
# Delete resource group
az group delete --name rg-dataplatform-dev --yes --no-wait
```

### Verify Deletion

```bash
# Check if resource group still exists
az group exists --name rg-dataplatform-dev
```

---

## Next Steps

- Configure CI/CD pipelines for automated deployments
- Implement environment-specific configurations
- Add monitoring and alerting
- Set up backup and disaster recovery
- Implement security best practices
- Review and optimize costs

## Support

For issues or questions:
- Check the documentation
- Review example configurations
- Consult Azure documentation
- Open an issue in the repository
