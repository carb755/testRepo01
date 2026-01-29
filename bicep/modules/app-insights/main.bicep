@description('Name of the Application Insights')
param appInsightsName string

@description('Azure region for the Application Insights')
param location string = resourceGroup().location

@description('Type of application being monitored')
@allowed([
  'web'
  'other'
])
param applicationType string = 'web'

@description('Tags to apply to the Application Insights')
param tags object = {}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: applicationType
  }
  tags: tags
}

@description('The ID of the Application Insights')
output appInsightsId string = appInsights.id

@description('The instrumentation key of the Application Insights')
@secure()
output instrumentationKey string = appInsights.properties.InstrumentationKey

@description('The connection string of the Application Insights')
@secure()
output connectionString string = appInsights.properties.ConnectionString

@description('The app ID of the Application Insights')
output appId string = appInsights.properties.AppId
