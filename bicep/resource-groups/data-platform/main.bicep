@description('Environment name (dev, staging, prod)')
param environment string = 'dev'

@description('Azure region for resources')
param location string = 'eastus'

@description('Project name for resource naming')
param projectName string = 'dataplatform'

@description('Common tags for all resources')
param tags object = {
  Environment: 'dev'
  ManagedBy: 'Bicep'
  Project: 'DataPlatform'
}

targetScope = 'subscription'

// Resource Group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'rg-${projectName}-${environment}'
  location: location
  tags: tags
}

// Storage Account
module storageAccount '../../modules/storage-account/main.bicep' = {
  name: 'storageAccountDeployment'
  scope: resourceGroup
  params: {
    storageAccountName: 'st${projectName}${environment}'
    location: location
    tags: tags
  }
}

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: 'asp-${projectName}-${environment}'
  location: location
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
  }
  kind: 'functionapp'
  properties: {
    reserved: true
  }
  tags: tags
}

// Function App
module functionApp '../../modules/function-app/main.bicep' = {
  name: 'functionAppDeployment'
  scope: resourceGroup
  params: {
    functionAppName: 'func-${projectName}-${environment}'
    location: location
    storageAccountName: storageAccount.outputs.storageAccountName
    appServicePlanId: appServicePlan.id
    tags: tags
  }
}

// Logic App
module logicApp '../../modules/logic-app/main.bicep' = {
  name: 'logicAppDeployment'
  scope: resourceGroup
  params: {
    logicAppName: 'logic-${projectName}-${environment}'
    location: location
    tags: tags
  }
}

// Application Insights
module appInsights '../../modules/app-insights/main.bicep' = {
  name: 'appInsightsDeployment'
  scope: resourceGroup
  params: {
    appInsightsName: 'appi-${projectName}-${environment}'
    location: location
    applicationType: 'web'
    tags: tags
  }
}

// Outputs
@description('The name of the resource group')
output resourceGroupName string = resourceGroup.name

@description('The name of the storage account')
output storageAccountName string = storageAccount.outputs.storageAccountName

@description('The name of the function app')
output functionAppName string = functionApp.outputs.functionAppName

@description('The URL of the function app')
output functionAppUrl string = 'https://${functionApp.outputs.defaultHostname}'

@description('The name of the logic app')
output logicAppName string = logicApp.outputs.logicAppName

@description('The Application Insights instrumentation key')
@secure()
output appInsightsInstrumentationKey string = appInsights.outputs.instrumentationKey
