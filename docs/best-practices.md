# Azure Infrastructure Best Practices

This document outlines best practices for deploying and managing Azure infrastructure.

## Security

### 1. Identity and Access Management

- **Use Managed Identities**: Prefer managed identities over service principals
- **Implement RBAC**: Use role-based access control with least privilege principle
- **Avoid Hardcoded Secrets**: Store secrets in Azure Key Vault
- **Enable MFA**: Require multi-factor authentication for administrative access

```hcl
# Example: Assign managed identity to function app
resource "azurerm_linux_function_app" "main" {
  identity {
    type = "SystemAssigned"
  }
}
```

### 2. Network Security

- **Use Private Endpoints**: Enable private endpoints for PaaS services
- **Implement NSGs**: Configure Network Security Groups for subnet-level protection
- **Enable DDoS Protection**: For production workloads
- **Use Azure Firewall**: For centralized network security

### 3. Data Protection

- **Enable Encryption**: Use encryption at rest and in transit
- **Configure TLS 1.2+**: Minimum TLS version for all services
- **Enable Soft Delete**: For Key Vault and Storage Accounts
- **Regular Backups**: Implement backup strategy for databases

```hcl
# Example: Enable encryption and TLS
enable_https_traffic_only = true
min_tls_version          = "TLS1_2"
```

### 4. Key Vault Best Practices

- Store all secrets, keys, and certificates in Key Vault
- Enable soft delete and purge protection in production
- Use access policies or RBAC for fine-grained access
- Rotate secrets regularly
- Enable diagnostic logging

## High Availability

### 1. Availability Zones

- Deploy across multiple availability zones
- Use zone-redundant services where available
- Configure automatic failover

### 2. Redundancy

- **Storage**: Use GRS or RAGRS for critical data
- **Databases**: Enable geo-replication
- **Applications**: Deploy to multiple regions

### 3. Health Monitoring

- Configure health probes
- Implement auto-scaling
- Set up alerts for critical metrics

## Performance Optimization

### 1. Right-Sizing

- Choose appropriate SKUs based on workload
- Start small and scale up as needed
- Use consumption-based pricing where possible

### 2. Caching

- Implement Azure Cache for Redis
- Use CDN for static content
- Enable output caching

### 3. Database Optimization

- Use appropriate indexing strategy
- Implement connection pooling
- Consider read replicas for read-heavy workloads

## Cost Management

### 1. Tagging Strategy

```hcl
tags = {
  Environment = "production"
  CostCenter  = "CC-1234"
  Owner       = "data-team"
  Project     = "data-platform"
}
```

### 2. Cost Optimization

- Use Azure Advisor recommendations
- Implement auto-shutdown for non-production VMs
- Use reserved instances for predictable workloads
- Enable Azure Hybrid Benefit if applicable
- Right-size resources based on actual usage

### 3. Budget Alerts

- Set up budget alerts in Azure Cost Management
- Monitor spending trends
- Review costs regularly

## Infrastructure as Code

### 1. State Management (Terraform)

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate123"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
```

### 2. Module Design

- Create reusable modules
- Version your modules
- Document module inputs and outputs
- Use variables for flexibility

### 3. Version Control

- Store IaC code in Git
- Use branching strategy
- Implement pull request reviews
- Tag releases

### 4. CI/CD Integration

- Automate deployments with pipelines
- Use what-if/plan before applying
- Implement approval gates for production
- Run security scans on IaC

## Monitoring and Logging

### 1. Application Insights

- Enable Application Insights for all applications
- Configure smart detection
- Set up availability tests
- Create custom metrics and events

### 2. Diagnostic Settings

```hcl
resource "azurerm_monitor_diagnostic_setting" "main" {
  name               = "diag-${var.resource_name}"
  target_resource_id = azurerm_resource.main.id
  
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
  
  log {
    category = "AuditLogs"
    enabled  = true
  }
  
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
```

### 3. Alerting

- Configure alerts for critical metrics
- Use action groups for notifications
- Implement escalation procedures
- Test alert configurations

### 4. Log Analytics

- Centralize logs in Log Analytics workspace
- Create custom queries for insights
- Set up dashboards for visualization
- Implement log retention policies

## Disaster Recovery

### 1. Backup Strategy

- Regular automated backups
- Test restore procedures
- Document recovery procedures
- Define RPO and RTO

### 2. Business Continuity

- Implement geo-redundancy
- Use Azure Site Recovery where applicable
- Document failover procedures
- Conduct DR drills regularly

## Compliance and Governance

### 1. Azure Policy

- Implement organizational policies
- Use policy initiatives
- Monitor compliance
- Remediate non-compliant resources

### 2. Resource Organization

- Use management groups for hierarchy
- Organize with resource groups
- Apply consistent naming conventions
- Use tags for organization

### 3. Audit and Compliance

- Enable Azure Activity Log
- Use Azure Security Center
- Regular compliance assessments
- Document compliance requirements

## Development Workflow

### 1. Environment Strategy

```
Development → Staging → Production
```

- Separate subscriptions or resource groups per environment
- Use consistent naming with environment suffix
- Implement environment-specific configurations

### 2. Testing

- Validate templates before deployment
- Use what-if analysis (Bicep) or plan (Terraform)
- Test in non-production first
- Implement automated testing where possible

### 3. Documentation

- Document architecture decisions
- Maintain deployment runbooks
- Keep README files updated
- Document known issues and workarounds

## Resource Lifecycle

### 1. Provisioning

- Use IaC for all deployments
- Follow the principle of immutable infrastructure
- Automate provisioning through pipelines

### 2. Updates

- Use blue-green deployments for zero-downtime updates
- Implement canary releases for gradual rollout
- Always test updates in non-production first

### 3. Decommissioning

- Document decommissioning procedures
- Export and archive data before deletion
- Remove dependencies first
- Clean up orphaned resources

## Specific Service Best Practices

### Storage Accounts

- Enable soft delete for blobs
- Use lifecycle management for cost optimization
- Implement CORS only when necessary
- Use private endpoints in production

### Function Apps

- Use consumption plan for variable workloads
- Implement durable functions for orchestration
- Use managed identities for authentication
- Enable Application Insights

### Logic Apps

- Use managed connectors when available
- Implement retry policies
- Use run history for debugging
- Monitor and alert on failures

### SQL Database

- Use elastic pools for multiple databases
- Enable automatic tuning
- Implement geo-replication for DR
- Use Query Performance Insight

### Cosmos DB

- Choose appropriate consistency level
- Design partition keys carefully
- Monitor RU consumption
- Use Azure Synapse Link for analytics

## Security Checklist

- [ ] Enable Azure Security Center
- [ ] Implement network segmentation
- [ ] Use managed identities
- [ ] Store secrets in Key Vault
- [ ] Enable encryption at rest
- [ ] Configure TLS 1.2 minimum
- [ ] Enable diagnostic logging
- [ ] Configure firewall rules
- [ ] Implement RBAC
- [ ] Enable soft delete on Key Vault
- [ ] Regular security assessments
- [ ] Patch management strategy
- [ ] Enable Advanced Threat Protection
- [ ] Configure security alerts

## Performance Checklist

- [ ] Right-size resources
- [ ] Implement caching
- [ ] Use CDN for static content
- [ ] Configure auto-scaling
- [ ] Optimize database queries
- [ ] Use connection pooling
- [ ] Monitor performance metrics
- [ ] Implement load balancing

## References

- [Azure Well-Architected Framework](https://docs.microsoft.com/azure/architecture/framework/)
- [Azure Security Baseline](https://docs.microsoft.com/security/benchmark/azure/)
- [Azure Best Practices](https://docs.microsoft.com/azure/architecture/best-practices/)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Bicep Documentation](https://docs.microsoft.com/azure/azure-resource-manager/bicep/)
