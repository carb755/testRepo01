@description('Name of the logic app')
param logicAppName string

@description('Azure region for the logic app')
param location string = resourceGroup().location

@description('Tags to apply to the logic app')
param tags object = {}

resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: logicAppName
  location: location
  properties: {
    state: 'Enabled'
    definition: {
      '$schema': 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'
      contentVersion: '1.0.0.0'
      parameters: {}
      triggers: {}
      actions: {}
      outputs: {}
    }
  }
  tags: tags
}

@description('The ID of the logic app')
output logicAppId string = logicApp.id

@description('The name of the logic app')
output logicAppName string = logicApp.name

@description('The access endpoint for the logic app')
output accessEndpoint string = logicApp.properties.accessEndpoint
