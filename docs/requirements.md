# Argo Azure Migration — Requirements and Discovery

## 1. Purpose

This document records the supplied business and technical requirements for the proposed Argo migration to Microsoft Azure.

It distinguishes confirmed client statements from proposed implementation choices and outstanding questions. No production design should be finalized until critical compatibility, security, licensing, sizing, and recovery questions are resolved.

## 2. Business Requirements

| ID | Requirement | Status |
|---|---|---|
| BR-01 | Replace the existing TS5, TS6, and TSIH terminal-server environment with an Azure Virtual Desktop solution | Confirmed requirement |
| BR-02 | Provide cloud desktop access for users who require MDS | Confirmed requirement |
| BR-03 | Support approximately 60–65 simultaneous users | Client-reported estimate; validate |
| BR-04 | Reconcile an application inventory of approximately 112 user assignments | Pending validation |
| BR-05 | Provide approximately 5–6 TB of shared file storage | Estimate; validate scope |
| BR-06 | Support secure office and remote access | Confirmed requirement |
| BR-07 | Support the separate Ivy Hill MDS database | Confirmed requirement |
| BR-08 | Establish backup, recovery, monitoring, and operational support requirements | Design requirement; details pending |

## 3. Existing Environment

| Component | Supplied information |
|---|---|
| MDS operating system | Windows Server 2012 R2 Standard |
| Database engine | Pervasive SQL v11 SP2 |
| Database build | 11.20.016 |
| Existing VM | 8 vCPUs, 28 GB RAM, 2 TB allocated storage |
| Terminal servers | TS5, TS6, TSIH |
| User concurrency | Approximately 60–65 |
| Application assignments | Approximately 112 |
| Shared files | Estimated 5–6 TB |

The existing VM configuration is a reference point, not a validated Azure sizing recommendation. Current CPU, memory, disk IOPS, throughput, database utilization, and peak-session measurements are required.

## 4. Application and Peripheral Requirements

Applications reported in the inventory include:

- Microsoft Office
- Microsoft Teams
- Zoom
- Adobe Acrobat
- Bluebeam
- CrowdStrike
- Scanners and banking tools for some users

One user requires 32-bit Office for MDS purchase-order emails.

### Validation requirements

1. Confirm supported operating systems for MDS and Pervasive SQL.
2. Test application installation and licensing on the proposed desktop OS.
3. Validate the 32-bit Office requirement and any coexistence limitations.
4. Test scanner redirection, banking tools, printing, email workflows, and other required peripherals.
5. Verify CrowdStrike compatibility with the selected OS and AVD configuration.
6. Determine which applications are required by each user group.

## 5. Identity and Connectivity

The existing Active Directory, DNS, sign-in, and other system dependencies have not yet been confirmed.

The design must establish:

- Existing directory and domain arrangements.
- Identity synchronization or hybrid-identity requirements, if applicable.
- DNS resolution and domain connectivity.
- Office and remote-user network paths.
- Administrative access and approved remote-management methods.
- Firewall rules, private connectivity, and outbound access requirements.
- User group membership and least-privilege access.
- Multifactor authentication and applicable Conditional Access policies.

Microsoft Entra ID alone must not be assumed sufficient for every legacy application or domain-join requirement.

## 6. Storage and Data Protection

The expected shared-file volume is 5–6 TB. It remains unconfirmed whether this includes database files, application files, user profiles, snapshots, or backups.

Before selecting a storage service, determine:

- Current used capacity and annual growth.
- File sizes, file counts, access patterns, and concurrent access.
- SMB and NTFS permission requirements.
- Identity-based access requirements.
- Performance and availability needs.
- Backup retention, recovery testing, and data residency requirements.
- Whether user profiles will use FSLogix and a supported storage configuration.

Azure Files is a candidate for shared storage, subject to compatibility, performance, security, and cost validation.

## 7. Database and Application Compatibility

The current application depends on Pervasive SQL v11 SP2, build 11.20.016.

The vendor must confirm:

1. Supported target Windows Server versions.
2. Supported database engine versions and upgrade paths.
3. Licensing and installation requirements.
4. Whether MDS and the database may be hosted separately.
5. Database backup and restore procedures.
6. Required ports, services, file locations, and permissions.
7. Multi-user access, locking, transaction integrity, and performance expectations.
8. The migration approach for the separate Ivy Hill database.

Do not substitute Azure SQL Database, SQL Server, or PostgreSQL for Pervasive SQL without explicit application-vendor support and a validated migration plan.

## 8. Capacity and Availability

The initial desktop capacity assessment must use actual concurrent workload measurements.

Required evidence includes:

- Peak simultaneous sessions and session duration.
- CPU and memory consumption per workload.
- Disk performance and profile-loading behavior.
- Application mix across the eight reported groups.
- Persistent versus pooled desktop requirements.
- Login storms, printing, conferencing, and peripheral workload impact.
- Expected growth and acceptable performance thresholds.

The number of application groups does not directly determine the number of virtual machines.

## 9. Security, Licensing, and Cost

Before production deployment, confirm:

- Azure subscription and billing scope.
- Approved region and data residency requirements.
- Azure service, Windows, Office, AVD, MDS, database, and endpoint-security licensing.
- Administrative role assignments and privileged-access procedures.
- Security monitoring and incident response.
- Backup protection and recovery access.
- Resource tagging and cost allocation.
- Budget approval and cost-estimation assumptions.

A cost estimate must be reviewed before deploying billable infrastructure. Budget alerts must not be treated as automatic spending caps.

## 10. Recovery and Service Levels

The business owner must define:

- Recovery Time Objective (RTO).
- Recovery Point Objective (RPO).
- Target service availability.
- Backup frequency and retention.
- Restore-testing frequency.
- Support hours and escalation procedures.
- Acceptable maintenance windows and migration downtime.

These values must be agreed with the client rather than invented by the implementation team.

## 11. Outstanding Questions for Tito

| ID | Question | Priority |
|---|---|---|
| Q-01 | Which MDS and Pervasive SQL versions are supported on the intended target OS? | Critical |
| Q-02 | What directory, DNS, domain-join, and authentication dependencies exist? | Critical |
| Q-03 | What are the peak workloads and resource utilization of the existing environment? | High |
| Q-04 | Does 5–6 TB include database, application, profile, and backup storage? | High |
| Q-05 | What are the required licensing arrangements for users and applications? | High |
| Q-06 | Which user groups need persistent desktops, scanners, or special software? | High |
| Q-07 | What are the approved RTO, RPO, availability target, and backup retention? | High |
| Q-08 | What budget, region, and connectivity constraints apply? | High |
| Q-09 | How is the separate Ivy Hill database backed up and accessed? | High |
| Q-10 | What migration window and rollback procedure are acceptable? | High |

## 12. Acceptance Criteria

Requirements discovery is complete when:

- User counts and application assignments have been reconciled.
- Legacy application and database compatibility is documented.
- Identity, DNS, and network dependencies are known.
- Storage capacity and performance requirements are validated.
- Licensing and budget assumptions are reviewed.
- Recovery objectives and operational responsibilities are agreed.
- Critical questions have documented answers or approved mitigation plans.

## 13. Current Status

**Stage:** Discovery and requirements documentation.

**Not yet completed:** Vendor compatibility validation, workload sizing, final architecture approval, cost approval, and deployment testing.

No production-readiness claim should be made until the applicable acceptance criteria have been met.
