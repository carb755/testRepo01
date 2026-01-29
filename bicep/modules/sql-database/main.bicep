@description('Name of the SQL server')
param serverName string

@description('Name of the SQL database')
param databaseName string

@description('Azure region for the SQL database')
param location string = resourceGroup().location

@description('Administrator login for the SQL server')
param administratorLogin string

@description('Administrator password for the SQL server')
@secure()
param administratorLoginPassword string

@description('SKU name for the database')
@allowed([
  'Basic'
  'S0'
  'S1'
  'S2'
  'P1'
  'P2'
])
param skuName string = 'S0'

@description('Maximum size of the database in GB')
param maxSizeGb int = 32

@description('Tags to apply to the resources')
param tags object = {}

resource sqlServer 'Microsoft.Sql/servers@2023-05-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    version: '12.0'
    minimalTlsVersion: '1.2'
  }
  tags: tags
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2023-05-01-preview' = {
  parent: sqlServer
  name: databaseName
  location: location
  sku: {
    name: skuName
  }
  properties: {
    maxSizeBytes: maxSizeGb * 1024 * 1024 * 1024
  }
  tags: tags
}

resource firewallRule 'Microsoft.Sql/servers/firewallRules@2023-05-01-preview' = {
  parent: sqlServer
  name: 'AllowAzureServices'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

@description('The ID of the SQL server')
output sqlServerId string = sqlServer.id

@description('The FQDN of the SQL server')
output sqlServerFqdn string = sqlServer.properties.fullyQualifiedDomainName

@description('The ID of the SQL database')
output databaseId string = sqlDatabase.id

@description('The name of the SQL database')
output databaseName string = sqlDatabase.name
