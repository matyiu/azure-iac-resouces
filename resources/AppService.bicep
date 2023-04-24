param location string
param serverFarmId string

param sqlServerName string
param SQLUser string

@secure()
param SQLUserPassword string

param DBConnectionString string = 'Server=tcp:${sqlServerName}${environment().suffixes.sqlServerHostname},1433;Initial Catalog=appdb;Persist Security Info=False;User ID=${SQLUser};Password=${SQLUserPassword};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'

resource webApplication 'Microsoft.Web/sites@2022-03-01' = {
  name: 'rjeffvalle-az'
  location: location
  properties: {
    serverFarmId: serverFarmId
    siteConfig: {
      alwaysOn: true
      netFrameworkVersion: 'v7.0'
      connectionStrings: [
        {
          type: 'SQLAzure'
          name: 'DBConnection'
          connectionString: DBConnectionString
        }
      ]
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
