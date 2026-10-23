# Azure Bicep Infrastructure

## Purpose

This directory will contain the Azure Bicep templates and validated parameter files for the Argo Azure migration project.

Bicep is the proposed infrastructure-as-code tool for defining and deploying Azure resources consistently.

## Planned Structure

- `main.bicep` — main infrastructure entry point.
- `main.bicepparam` — environment-specific parameter values.
- Additional modules may be added after the architecture and deployment scope are approved.

## Parameterization Principles

Environment-specific settings should be parameterized where appropriate, including:

- Azure region.
- Environment identifier.
- Resource naming inputs.
- Approved VM and storage configuration.
- Network address ranges.
- Resource tags.

Parameters must be validated. Security requirements must not be weakened or made optional simply to increase flexibility.

## Security

- Never commit passwords, tokens, private keys, connection strings, or other secrets.
- Do not commit confidential client data.
- Use approved identity-based authentication and least-privilege access.
- Review template changes before deployment.

## Deployment Safety

The templates are not approved for production deployment.

Before deploying any resources:

1. Confirm the client-approved scope and architecture.
2. Validate application and database vendor compatibility.
3. Review required Azure permissions and service availability.
4. Estimate costs and configure appropriate cost monitoring.
5. Review the deployment changes.
6. Obtain the required authorization.

A successful template validation does not, by itself, prove that an application is compatible or that a deployment is safe for production.
