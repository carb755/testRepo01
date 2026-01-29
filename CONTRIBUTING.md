# Contributing to Azure Infrastructure Library

Thank you for your interest in contributing to this Azure Infrastructure as Code library!

## How to Contribute

### Reporting Issues

- Use the issue tracker to report bugs or request features
- Provide detailed information about the issue
- Include steps to reproduce for bugs
- Specify which IaC tool (Terraform/Bicep) is affected

### Submitting Changes

1. **Fork the Repository**
   ```bash
   git clone https://github.com/yourusername/testRepo01.git
   cd testRepo01
   ```

2. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Your Changes**
   - Follow the existing code structure
   - Maintain consistency with current patterns
   - Update documentation as needed

4. **Test Your Changes**
   - Validate Terraform: `terraform validate`
   - Validate Bicep: `az bicep build --file main.bicep`
   - Test deployments in a development environment

5. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "Add feature: description of changes"
   ```

6. **Push to Your Fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create Pull Request**
   - Provide clear description of changes
   - Reference any related issues
   - Include testing evidence if applicable

## Code Standards

### Terraform

- Use consistent formatting: `terraform fmt`
- Include variable descriptions
- Add outputs for important values
- Use sensitive flag for secrets
- Follow naming conventions

Example:
```hcl
variable "storage_account_name" {
  description = "Name of the storage account (must be globally unique)"
  type        = string
  validation {
    condition     = length(var.storage_account_name) >= 3 && length(var.storage_account_name) <= 24
    error_message = "Storage account name must be between 3 and 24 characters."
  }
}
```

### Bicep

- Use clear parameter descriptions with `@description()`
- Leverage `@allowed()` for restricted values
- Add `@secure()` for sensitive parameters
- Use consistent indentation
- Follow naming conventions

Example:
```bicep
@description('Name of the storage account')
@minLength(3)
@maxLength(24)
param storageAccountName string

@description('Storage account SKU')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
param skuName string = 'Standard_LRS'
```

## Documentation

- Update README files when adding new features
- Document all module parameters
- Provide usage examples
- Keep best practices documentation current
- Add inline comments for complex logic

## Module Guidelines

### Creating New Modules

1. **Module Structure**
   ```
   modules/new-resource/
   ├── main.tf (or main.bicep)
   ├── variables.tf
   ├── outputs.tf
   └── README.md
   ```

2. **Module Requirements**
   - Clear, descriptive naming
   - Comprehensive variable validation
   - Useful outputs
   - Sensible defaults
   - Documentation

3. **Module Documentation**
   Include in module README:
   - Purpose and description
   - Prerequisites
   - Input parameters
   - Outputs
   - Usage examples
   - Known limitations

### Updating Existing Modules

- Maintain backward compatibility when possible
- Document breaking changes clearly
- Update version numbers appropriately
- Test with existing implementations

## Testing

### Before Submitting

- [ ] Code follows style guidelines
- [ ] Terraform/Bicep validates successfully
- [ ] Documentation is updated
- [ ] Examples are provided
- [ ] Tested in development environment
- [ ] No hardcoded values or secrets
- [ ] Follows naming conventions

### Validation Commands

**Terraform:**
```bash
terraform fmt -check
terraform validate
terraform plan
```

**Bicep:**
```bash
az bicep build --file main.bicep
az deployment group validate --template-file main.bicep
```

## Review Process

1. Automated checks run on pull requests
2. Maintainers review code and documentation
3. Address any feedback or requested changes
4. Changes are merged once approved

## Questions or Help

- Open an issue for questions
- Check existing documentation
- Review example implementations

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Help others learn and grow
- Follow community guidelines

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (MIT License).

## Recognition

Contributors will be recognized in the project documentation.

Thank you for contributing to making this Azure Infrastructure library better!
