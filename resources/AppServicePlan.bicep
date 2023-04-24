param location string

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'rjeffvalle-az'
  location: location
  sku: {
    name: 'S1'
    capacity: 1
  }
}

output id string = appServicePlan.id
