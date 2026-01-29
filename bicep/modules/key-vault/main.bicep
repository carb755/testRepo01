@description('Name of the Key Vault')
param keyVaultName string

@description('Azure region for the Key Vault')
param location string = resourceGroup().location

@description('Azure AD tenant ID')
param tenantId string

@description('SKU name for the Key Vault')
@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

@description('Enable Key Vault for disk encryption')
param enabledForDiskEncryption bool = true

@description('Soft delete retention days')
@minValue(7)
@maxValue(90)
param softDeleteRetentionDays int = 7

@description('Enable purge protection')
param purgeProtectionEnabled bool = false

@description('Tags to apply to the Key Vault')
param tags object = {}

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    tenantId: tenantId
    sku: {
      family: 'A'
      name: skuName
    }
    enabledForDiskEncryption: enabledForDiskEncryption
    softDeleteRetentionInDays: softDeleteRetentionDays
    enablePurgeProtection: purgeProtectionEnabled ? true : null
    accessPolicies: []
  }
  tags: tags
}

@description('The ID of the Key Vault')
output keyVaultId string = keyVault.id

@description('The URI of the Key Vault')
output keyVaultUri string = keyVault.properties.vaultUri

@description('The name of the Key Vault')
output keyVaultName string = keyVault.name
