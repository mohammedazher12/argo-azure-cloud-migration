using './main.bicep'

// Non-production planning configuration only.
// These values do not authorize or deploy Azure resources.

param environmentName = 'dev'
param location = 'eastus'
param projectName = 'argo'
param ownerTag = 'pending-approval'
param costCenter = 'pending-approval'
param designApproved = false
