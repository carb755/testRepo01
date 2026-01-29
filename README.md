# Azure Infrastructure as Code Library

A comprehensive library for deploying Azure resources using Terraform and Bicep, organized by resource groups following best practices. This repository provides reusable infrastructure code for building scalable data platforms.

## 📁 Repository Structure

```
.
├── terraform/              # Terraform configurations
│   ├── modules/           # Reusable Terraform modules
│   ├── environments/      # Environment-specific configurations
│   └── resource-groups/   # Organized by resource group
├── bicep/                 # Bicep configurations
│   ├── modules/           # Reusable Bicep modules
│   └── resource-groups/   # Organized by resource group
└── docs/                  # Additional documentation
```

## 🚀 Supported Resources

This library includes configurations for:

- **Logic Apps** - Workflow automation and integration
- **Function Apps** - Serverless compute
- **Storage Accounts** - Blob, File, Queue, and Table storage
- **Databases** - Azure SQL Database and Cosmos DB
- **Data Factory** - Data integration and orchestration
- **Key Vault** - Secrets management
- **Application Insights** - Application monitoring

## 📚 Getting Started

### Prerequisites

- Azure subscription
- Azure CLI installed
- For Terraform: Terraform >= 1.0
- For Bicep: Bicep CLI >= 0.4

### Terraform Usage

```bash
cd terraform/environments/dev
terraform init
terraform plan
terraform apply
```

### Bicep Usage

```bash
cd bicep/resource-groups/data-platform
az deployment group create \
  --resource-group <resource-group-name> \
  --template-file main.bicep \
  --parameters main.parameters.json
```

## 🏗️ Best Practices

- Resources are organized by resource groups for better management
- Modules promote code reusability and maintainability
- Environment-specific configurations enable multi-environment deployments
- Variables and outputs support infrastructure scalability
- Tagging strategy for cost management and organization

## 📖 Documentation

See the following for detailed documentation:

- [Terraform Guide](terraform/README.md)
- [Bicep Guide](bicep/README.md)
- [Module Documentation](docs/modules.md)
- [Deployment Guide](docs/deployment.md)

## 🤝 Contributing

Contributions are welcome! Please ensure code follows the established patterns and includes appropriate documentation.

## 📄 License

MIT License