# Argo Azure Migration — Assumptions and Risks

## 1. Purpose

This document records confirmed information, planning assumptions, project risks, and outstanding decisions for the Argo Azure migration.

No production infrastructure should be deployed until the relevant requirements, compatibility, security, licensing, and cost decisions have been validated and approved.

## 2. Confirmed Information

The following information was provided in the initial client discussions:

- The current MDS application uses Pervasive SQL v11 SP2, build 11.20.016.
- The current MDS server runs Windows Server 2012 R2 Standard.
- The existing MDS VM has 8 vCPUs, 28 GB RAM, and approximately 2 TB of allocated storage.
- The expected concurrent desktop user count is approximately 60–65.
- The broader application inventory contains approximately 112 users, with overlapping assignments still being reviewed.
- Shared file storage is estimated at 5–6 TB.
- Azure Virtual Desktop is being considered to replace TS5, TS6, and TSIH terminal servers.
- Some users require scanners, banking tools, and other peripherals.
- One user requires 32-bit Office for MDS purchase-order email functionality.
- Ivy Hill uses a separate MDS database.

These figures are initial inputs, not a final Azure design or approved capacity specification.

## 3. Planning Assumptions — Not Yet Approved

| ID | Planning assumption | Validation required |
|---|---|---|
| A-01 | Azure Virtual Desktop may be suitable for the terminal-server replacement. | Test application compatibility, user experience, and peripherals. |
| A-02 | Azure virtual machines may be required to host MDS and its database engine. | Confirm vendor-supported deployment architecture. |
| A-03 | Azure Files may be suitable for shared file storage. | Validate file protocols, permissions, performance, and application compatibility. |
| A-04 | FSLogix may be suitable for managing AVD user profiles. | Confirm identity, profile size, storage, and application requirements. |
| A-05 | Existing identity services may need to integrate with Azure. | Discover Active Directory, Microsoft Entra ID, DNS, and authentication dependencies. |
| A-06 | The existing server specifications may be a starting point for testing. | Collect actual CPU, memory, disk IOPS, latency, and utilization data. |
| A-07 | Infrastructure should be deployed through parameterized infrastructure as code. | Agree on the deployment tool, approved parameters, and validation rules. |

No assumption above should be treated as a confirmed client decision.

## 4. Risks and Mitigations

### R-01 — Legacy application compatibility

**Risk:** MDS or Pervasive SQL may not support the proposed Windows Server version, Azure VM configuration, or multi-session environment.

**Mitigation:** Obtain written vendor compatibility guidance. Build an isolated test environment and validate application and database behavior before migration.

### R-02 — Database integrity and migration

**Risk:** Incorrect migration, unsupported database placement, or incomplete backups could cause data loss or application failure.

**Mitigation:** Confirm vendor-supported backup and restore procedures, test recovery, validate data integrity, and obtain application-owner approval before cutover.

### R-03 — Incorrect capacity sizing

**Risk:** The current server's allocated resources may not reflect actual workload requirements. Approximately 60–65 concurrent users may have different CPU, memory, and storage needs from 112 assigned users.

**Mitigation:** Collect utilization and workload measurements, conduct representative load testing, and size the pilot based on evidence.

### R-04 — Storage scope and performance

**Risk:** The estimated 5–6 TB of shared files may exclude database files, user profiles, growth, backups, or temporary data.

**Mitigation:** Inventory each data category, measure capacity and access patterns, define growth assumptions, and validate storage performance and recovery requirements.

### R-05 — Identity and network dependencies

**Risk:** Missing information about Active Directory, DNS, authentication, remote access, or existing integrations could prevent users from signing in or applications from working.

**Mitigation:** Complete identity and network discovery before finalizing the network design. Approve access paths, DNS requirements, and security controls before deployment.

### R-06 — Peripheral and Office compatibility

**Risk:** Scanners, banking tools, Teams, Zoom, Bluebeam, Acrobat, and the 32-bit Office requirement may behave differently in an AVD environment.

**Mitigation:** Create an application compatibility matrix and test each required application and peripheral with representative users.

### R-07 — Availability and recovery

**Risk:** The design may not meet the business's recovery time, recovery point, or availability expectations.

**Mitigation:** Obtain approved RTO, RPO, backup retention, recovery testing, and availability requirements before choosing the production architecture.

### R-08 — Security and licensing

**Risk:** Incorrect permissions, exposed remote access, missing endpoint protection, or unverified software licensing could create security or compliance problems.

**Mitigation:** Review identity and access controls, network restrictions, endpoint protection, logging, software licensing, and Microsoft licensing requirements before production use.

### R-09 — Unexpected Azure cost

**Risk:** AVD sessions, virtual machines, disks, storage transactions, backups, networking, and monitoring may incur costs beyond initial estimates.

**Mitigation:** Prepare a region-specific cost estimate, review licensing and usage assumptions, configure budget alerts, and monitor actual charges. Budget alerts are not a guaranteed spending cap.

### R-10 — Unapproved production changes

**Risk:** Deploying or modifying infrastructure without authorization could affect business systems or create unplanned charges.

**Mitigation:** Use an approved change plan, separate development and production environments, review deployment changes, and obtain explicit authorization before production deployment.

## 5. Questions Requiring Client Confirmation

1. Which Windows Server versions and Azure hosting configurations are officially supported by the MDS and Pervasive SQL vendors?
2. What are the current CPU, memory, disk IOPS, latency, and capacity utilization measurements?
3. What are the final concurrent-user counts and application assignments?
4. Does the 5–6 TB estimate include MDS database files, user profiles, and backup data?
5. What identity platform is currently used? Are Active Directory, DNS, domain controllers, or hybrid authentication required?
6. What connectivity is required between offices, remote users, Azure, and any existing systems?
7. Which applications and peripherals must work in the AVD pilot?
8. What Microsoft 365, Windows, AVD, database, and third-party software licenses are available?
9. What are the required RTO, RPO, backup retention, availability, and disaster-recovery targets?
10. What is the approved Azure region, budget, and production change-approval process?
11. Does Ivy Hill require a separate VM, database instance, or another form of isolation?
12. Who will approve the pilot, migration, final testing, and production cutover?

## 6. Deployment Gate

Production deployment remains blocked until the following are completed:

- [ ] Vendor compatibility confirmed.
- [ ] Workload and user counts validated.
- [ ] Storage and database scope confirmed.
- [ ] Identity and network dependencies documented.
- [ ] Licensing reviewed.
- [ ] Security design reviewed.
- [ ] Cost estimate reviewed and approved.
- [ ] Backup and recovery objectives approved.
- [ ] Pilot acceptance criteria and change approvals agreed.

## 7. Current Project Status

**Status:** Discovery and documentation.

**Next planned activity:** Prepare the proposed architecture and document its design decisions, dependencies, and unresolved questions.

**Deployment status:** No Argo production infrastructure has been deployed through this project workflow.

