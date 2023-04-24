param location string
param serverFarmId string

resource webApplication 'Microsoft.Web/sites@2022-03-01' = {
  name: 'rjeffvalle-az'
  location: location
  properties: {
    serverFarmId: serverFarmId
    siteConfig: {
      alwaysOn: true
      netFrameworkVersion: 'v7.0'
      
    }
  }
  resource meta 'config@2022-03-01' = {
    name: 'metadata'
    kind: 'string'
    properties: {
      CURRENT_STACK: 'dotnet'
    }
  }
}
