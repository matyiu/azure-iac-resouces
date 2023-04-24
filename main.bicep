targetScope = 'subscription' 

param subscriptionId string
param resourceGroupName string
param location string

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

module appService './resources/AppService.bicep' = {
  name: 'appService'
  scope: resourceGroup(subscriptionId, resourceGroupName)
  params: {
    location: location
    serverFarmId: appServicePlan.outputs.id
  }
  dependsOn: [
    rg
    appServicePlan
  ]
}
