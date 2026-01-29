@description('Name of the storage account (must be globally unique)')
param storageAccountName string

@description('Azure region for the storage account')
param location string = resourceGroup().location

@description('Storage account tier')
@allowed([
  'Standard'
  'Premium'
])
param accountTier string = 'Standard'

@description('Storage account replication type')
@allowed([
  'LRS'
  'GRS'
  'RAGRS'
  'ZRS'
])
param accountReplicationType string = 'LRS'

@description('Enable HTTPS traffic only')
param enableHttpsTrafficOnly bool = true

@description('Minimum TLS version')
@allowed([
  'TLS1_0'
  'TLS1_1'
  'TLS1_2'
])
param minTlsVersion string = 'TLS1_2'

@description('Tags to apply to the storage account')
param tags object = {}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: '${accountTier}_${accountReplicationType}'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: enableHttpsTrafficOnly
    minimumTlsVersion: minTlsVersion
    encryption: {
      services: {
        blob: {
          enabled: true
        }
        file: {
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
  }
  tags: tags
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageAccount
  name: 'default'
}

resource dataContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobService
  name: 'data'
  properties: {
    publicAccess: 'None'
  }
}

resource logsContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobService
  name: 'logs'
  properties: {
    publicAccess: 'None'
  }
}

@description('The ID of the storage account')
output storageAccountId string = storageAccount.id

@description('The name of the storage account')
output storageAccountName string = storageAccount.name

@description('The primary blob endpoint')
output primaryBlobEndpoint string = storageAccount.properties.primaryEndpoints.blob

@description('The primary access key for the storage account')
@secure()
output primaryAccessKey string = storageAccount.listKeys().keys[0].value
