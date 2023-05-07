targetScope = 'subscription'

param subscriptionId string
param resourceGroupName string
param location string
param SQLUser string

@secure()
param SQLUserPassword string

module rg './resources/ResourceGroup.bicep' = {
  name: 'resourceGroup'
  params: {
    resourceGroupName: resourceGroupName
    location: location
  }
  scope: subscription(subscriptionId)
}

module appServicePlan './resources/AppServicePlan.bicep' = {
  name: 'appServicePlan'
  scope: resourceGroup(subscriptionId, resourceGroupName)
  params: {
    location: location
  }
  dependsOn: [
    rg
  ]
}

module SQLDatabase './resources/SQLDatabase.bicep' = {
  name: 'SQLDatabase'
  params: {
    location: location
    SQLUser: SQLUser
    SQLUserPassword: SQLUserPassword
  }
  scope: resourceGroup(subscriptionId, resourceGroupName)
  dependsOn: [
    rg
  ]
}

module appService './resources/AppService.bicep' = {
  name: 'appService'
  scope: resourceGroup(subscriptionId, resourceGroupName)
  params: {
    location: location
    serverFarmId: appServicePlan.outputs.id
    SQLUser: SQLUser
    SQLUserPassword: SQLUserPassword
    sqlServerName: SQLDatabase.outputs.sqlServerName
  }
  dependsOn: [
    appServicePlan
    SQLDatabase
  ]
}

module functionApp './resources/FunctionApp.bicep' = {
  name: 'functionApp'
  scope: resourceGroup(subscriptionId, resourceGroupName)
  params: {
    location: location
    sqlUser: SQLUser
    sqlServerName: SQLDatabase.outputs.sqlServerName
    sqlUserPassword: SQLUserPassword
    appInsightsLocation: location
    appName: 'marketplace-rjeffvalle'
  }
  dependsOn: [
    SQLDatabase
  ]
}
