/*
  Argo Azure Migration
  Initial Bicep entry point — planning stage only.

  This template intentionally creates no Azure resources.
  Resource deployment will be designed only after the client requirements,
  vendor compatibility, security, and cost assumptions have been reviewed.
*/

targetScope = 'resourceGroup'

@description('Short environment identifier, such as dev, test, or prod.')
@minLength(2)
@maxLength(10)
param environmentName string

@description('Azure region selected after service availability and client requirements are reviewed.')
param location string = resourceGroup().location

@description('Project identifier used for resource naming and tags.')
@minLength(2)
@maxLength(20)
param projectName string = 'argo'

@description('Owner or team responsible for the deployment.')
param ownerTag string = 'pending-approval'

@description('Cost center or budget identifier, if provided by the organization.')
param costCenter string = 'pending-approval'

@description('Indicates whether this configuration has passed the required design reviews. No resources are created by this template.')
param designApproved bool = false

var commonTags = {
  project: projectName
  environment: environmentName
  owner: ownerTag
  costCenter: costCenter
  managedBy: 'Bicep'
  designApproved: string(designApproved)
}

output deploymentScope string = 'resourceGroup'
output selectedLocation string = location
output project string = projectName
output environment string = environmentName
output tagsForFutureResources object = commonTags
output resourcesCreated int = 0
