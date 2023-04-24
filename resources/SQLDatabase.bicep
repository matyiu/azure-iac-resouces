param location string
param SQLUser string

@secure()
param SQLUserPassword string

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: 'rjeffvalle-sql-server'
  location: location
  properties: {
    administratorLogin: SQLUser
    administratorLoginPassword: SQLUserPassword
    publicNetworkAccess: 'Enabled'
  }
}

resource allowAzureIps 'Microsoft.Sql/servers/firewallRules@2022-05-01-preview' = {
  name: 'allow-azure-ips'
  parent: sqlServer
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  parent: sqlServer
  name: 'appdb'
  location: location
}

output sqlServerName string = sqlServer.name
