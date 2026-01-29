@description('Name of the Cosmos DB account')
param cosmosAccountName string

@description('Name of the Cosmos DB database')
param databaseName string

@description('Name of the Cosmos DB container')
param containerName string

@description('Azure region for the Cosmos DB account')
param location string = resourceGroup().location

@description('Partition key path for the container')
param partitionKeyPath string = '/id'

@description('Throughput for the database')
param throughput int = 400

@description('Tags to apply to the resources')
param tags object = {}

resource cosmosAccount 'Microsoft.DocumentDB/databaseAccounts@2023-11-15' = {
  name: cosmosAccountName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    databaseAccountOfferType: 'Standard'
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    locations: [
      {
        locationName: location
        failoverPriority: 0
      }
    ]
  }
  tags: tags
}

resource database 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2023-11-15' = {
  parent: cosmosAccount
  name: databaseName
  properties: {
    resource: {
      id: databaseName
    }
    options: {
      throughput: throughput
    }
  }
}

resource container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2023-11-15' = {
  parent: database
  name: containerName
  properties: {
    resource: {
      id: containerName
      partitionKey: {
        paths: [
          partitionKeyPath
        ]
        kind: 'Hash'
      }
    }
  }
}

@description('The ID of the Cosmos DB account')
output cosmosAccountId string = cosmosAccount.id

@description('The endpoint of the Cosmos DB account')
output cosmosAccountEndpoint string = cosmosAccount.properties.documentEndpoint

@description('The primary key of the Cosmos DB account')
@secure()
output cosmosAccountPrimaryKey string = cosmosAccount.listKeys().primaryMasterKey

@description('The name of the Cosmos DB database')
output databaseName string = database.name
