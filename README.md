# AZ 204 IaC Resources
List of resources I'm using to prepare myself for the AZ 204 exam

## How to run
1. Copy `main.devParameters.json` file to `main.parameters.json` filling the variables
2. Run the following command
```
az deployment sub create -f main.bicep -p @main.parameters.json --name deploymentName --location westeurope
```