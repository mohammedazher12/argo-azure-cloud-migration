# Argo Azure Cloud Migration

## Project Overview

This repository documents the planning, proposed architecture, validation, and implementation approach for migrating a legacy business application environment to Microsoft Azure.

**Project stage:** Discovery and architecture planning  
**Deployment status:** No Argo-specific Azure infrastructure has been deployed through this project  
**Infrastructure approach:** Infrastructure as Code (IaC), with parameterized configuration and documented validation

> This is a learning and portfolio project based on the supplied requirements. It is not evidence of an approved, completed, or production deployment. Obtain the client's authorization before publishing client-specific information.

## 1. Business Problem

The existing environment uses terminal servers to provide access to MDS, which depends on Pervasive SQL.

The proposed migration must investigate how to provide:

- Cloud desktops for approximately 60–65 concurrent users.
- Access to MDS and its database with verified compatibility.
- Shared file storage for an estimated 5–6 TB of data.
- Secure access for office and remote users.
- User profiles and application delivery.
- Appropriate identity, networking, monitoring, backup, and recovery.
- Support for Office, Teams, Zoom, Acrobat, Bluebeam, CrowdStrike, scanners, and banking tools where compatible.

The current application inventory reportedly contains approximately 112 user assignments across eight application groups. These figures require reconciliation and workload validation before sizing.

## 2. Existing Environment — Supplied Requirements

| Component | Current information |
|---|---|
| Application | MDS |
| Database engine | Pervasive SQL v11 SP2, build 11.20.016 |
| Existing operating system | Windows Server 2012 R2 Standard |
| Existing MDS VM | 8 vCPUs, 28 GB RAM, 2 TB allocated storage |
| Existing terminal servers | TS5, TS6, TSIH |
| Expected concurrency | Approximately 60–65 users |
| Application inventory | Approximately 112 assignments |
| Shared file capacity | Estimated 5–6 TB |
| Special compatibility requirement | One user needs 32-bit Office for MDS purchase-order emails |
| Separate application environment | Ivy Hill uses a separate MDS database |

The existing VM specifications are reference information only. Actual utilization, storage consumption, workload characteristics, and vendor-supported target versions must be established before selecting Azure SKUs.

## 3. Proposed Azure Architecture

The following services are candidates for evaluation, not a final approved design:

- **Azure Virtual Desktop:** Desktop delivery and session management.
- **Azure virtual machines:** Application or database hosting where required by vendor compatibility.
- **Azure Files:** Shared files and potentially user-profile storage, subject to performance and identity requirements.
- **Microsoft Entra ID and/or Active Directory:** Identity integration based on the existing environment.
- **Azure networking:** Virtual network, subnets, DNS, routing, and appropriate network security controls.
- **Monitoring and recovery:** Azure Monitor, logging, backup, and tested restoration procedures.
- **Infrastructure as Code:** Azure Bicep for repeatable deployment of supported resources.

Final service selection, sizing, and licensing remain subject to discovery, vendor confirmation, cost estimation, and client approval.

## 4. Critical Design Principles

1. Preserve MDS functionality and database integrity.
2. Do not replace Pervasive SQL with Azure SQL or PostgreSQL without explicit vendor support.
3. Validate the supported operating system and database versions before production deployment.
4. Size desktop capacity using measured concurrent workloads rather than assigned user counts alone.
5. Confirm whether shared-file capacity excludes database, profile, application, and backup storage.
6. Apply least-privilege access and secure remote connectivity.
7. Establish agreed Recovery Time Objective (RTO) and Recovery Point Objective (RPO).
8. Use parameterized infrastructure configuration rather than scattering environment-specific values throughout scripts.
9. Keep credentials, client data, private keys, and sensitive configuration out of source control.
10. Verify actual deployment and testing results before claiming a component is complete.

## 5. Open Questions and Dependencies

- Which Windows Server and Pervasive SQL versions are supported by the MDS vendor?
- What are the existing Active Directory, DNS, sign-in, and network dependencies?
- Are the 60–65 concurrent users representative of peak usage?
- Which applications require persistent desktops, specialized peripherals, or elevated permissions?
- What licensing is required for Windows, AVD, Office, MDS, and Pervasive SQL?
- Does the 5–6 TB file estimate include database and profile storage?
- What are the required availability, RTO, RPO, backup retention, and support hours?
- What is the confirmed Azure budget and approved target region?
- What connectivity and migration approach will be approved for the existing environment?

## 6. Delivery Roadmap

1. Subscription, permissions, cost controls, and discovery.
2. Requirements, assumptions, risks, and architecture.
3. GitHub documentation and project tracking.
4. Azure foundation and naming conventions.
5. Identity, network, DNS, and access controls.
6. MDS and Pervasive SQL compatibility assessment.
7. Azure Virtual Desktop pilot.
8. Application installation, user profiles, and peripheral testing.
9. Shared storage, permissions, and recovery validation.
10. Security, monitoring, and backup testing.
11. Infrastructure automation and repeatability tests.
12. Performance validation, cost review, and handover documentation.

## 7. Repository Structure

```text
argo-azure-cloud-migration/
├── README.md
├── docs/
│   ├── requirements.md
│   ├── architecture.md
│   ├── assumptions-and-risks.md
│   └── decisions.md
├── infra/
│   └── bicep/
├── scripts/
├── tests/
└── cost/
    └── sizing-assumptions.md
```

Additional directories and files will be introduced when their contents are ready for review.

## 8. Cost and Security Controls

No Argo-specific Azure resources should be deployed until the proposed design, permissions, licensing, and cost estimate have been reviewed.

- Review subscription charges and existing resource usage.
- Confirm the subscription's actual billing protections.
- Estimate resource costs before deployment.
- Apply resource tags and naming conventions.
- Avoid storing secrets or credentials in GitHub.
- Use approved identities and least-privilege access.
- Validate cleanup and recovery procedures.
- Record material design decisions and test evidence.

## 9. Definition of Done

The project will be ready for client handover only when the approved architecture and deployment scope are documented, required resources have been validated, application and database compatibility has been demonstrated, security and recovery tests have passed, costs have been reviewed, and operational documentation has been delivered.

A successful infrastructure deployment alone does not establish that the complete business application is production-ready.

## 10. Documentation References

- Microsoft Azure documentation: https://learn.microsoft.com/azure/
- Azure Virtual Desktop: https://learn.microsoft.com/azure/virtual-desktop/
- Azure Files: https://learn.microsoft.com/azure/storage/files/
- Azure Bicep: https://learn.microsoft.com/azure/azure-resource-manager/bicep/
- Azure pricing: https://azure.microsoft.com/pricing/calculator/

