@description('Name of the function app')
param functionAppName string

@description('Azure region for the function app')
param location string = resourceGroup().location

@description('Name of the storage account for the function app')
param storageAccountName string

@description('ID of the app service plan')
param appServicePlanId string

@description('Runtime stack for the function app')
@allowed([
  'dotnet'
  'node'
  'python'
  'java'
])
param runtimeStack string = 'dotnet'

@description('Runtime version')
param runtimeVersion string = '6'

@description('Tags to apply to the function app')
param tags object = {}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' existing = {
  name: storageAccountName
}

resource functionApp 'Microsoft.Web/sites@2023-01-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp,linux'
  properties: {
    serverFarmId: appServicePlanId
    siteConfig: {
      linuxFxVersion: '${runtimeStack}|${runtimeVersion}'
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storageAccount.listKeys().keys[0].value}'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: runtimeStack
        }
      ]
    }
    httpsOnly: true
  }
  tags: tags
}

@description('The ID of the function app')
output functionAppId string = functionApp.id

@description('The name of the function app')
output functionAppName string = functionApp.name

@description('The default hostname of the function app')
output defaultHostname string = functionApp.properties.defaultHostName
