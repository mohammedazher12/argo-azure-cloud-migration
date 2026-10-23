# Argo Azure Migration — Architecture Decision Records

## Purpose

This document records important technical decisions, their rationale, current status, and the evidence needed to finalize them.

A proposed technology is not an approved production decision until the required validation and client approval are complete.

## ADR-001 — Infrastructure as Code

**Status:** Proposed

**Decision:** Evaluate Azure Bicep as the primary infrastructure-as-code tool.

**Reasoning:**
- It is designed for deploying Azure resources.
- It supports reusable templates and parameters.
- It can help standardize deployments across development, pilot, and production environments.

**Validation required:**
- Confirm team familiarity and deployment permissions.
- Define naming, tagging, parameter validation, and security standards.
- Review deployment changes before applying them.

## ADR-002 — Desktop Delivery

**Status:** Proposed, pending compatibility testing

**Decision:** Evaluate Azure Virtual Desktop as the replacement for TS5, TS6, and TSIH.

**Reasoning:** The client has requested a replacement for the existing terminal-server environment.

**Validation required:**
- Application compatibility.
- User concurrency and performance.
- Peripheral and scanner support.
- Microsoft licensing.
- Sign-in, networking, security, and recovery requirements.

## ADR-003 — MDS and Pervasive SQL Hosting

**Status:** Open — vendor confirmation required

**Decision:** Do not finalize the hosting architecture until supported operating systems and database configurations have been confirmed.

**Reasoning:** MDS currently uses a legacy Windows Server and Pervasive SQL version. An unsupported hosting or upgrade path could affect application availability and data integrity.

**Validation required:**
- Vendor support statement.
- Database backup and restore test.
- Application compatibility test.
- Performance and recovery requirements.

**Restriction:** Do not replace the existing database engine with another database platform without an approved migration strategy and verified application compatibility.

## ADR-004 — Shared File Storage

**Status:** Proposed, pending validation

**Decision:** Evaluate Azure Files for shared business files.

**Reasoning:** The client estimates approximately 5–6 TB of shared storage.

**Validation required:**
- Required file protocol and permissions.
- Performance, capacity, and expected growth.
- Identity integration and connectivity.
- Backup, retention, and recovery.
- Confirmation of whether database files and user profiles are included in the estimate.

## ADR-005 — User Profile Management

**Status:** Proposed, pending validation

**Decision:** Evaluate FSLogix profile containers for Azure Virtual Desktop, with a compatible storage and identity design.

**Validation required:**
- Profile size and growth.
- Concurrent access and storage performance.
- Application compatibility.
- Permissions, backup, and recovery.

## ADR-006 — Configuration and Parameterization

**Status:** Proposed

**Decision:** Use validated parameters for appropriate environment-specific infrastructure settings.

Examples include:
- Environment name.
- Azure region.
- Resource naming inputs.
- VM sizes.
- Storage configuration.
- Network address ranges.
- Approved tags.

**Security principle:** Parameterization must not expose secrets or make required security controls optional. Credentials and secrets must not be committed to GitHub.

## ADR-007 — Deployment Environments

**Status:** Proposed

**Decision:** Separate discovery, non-production testing, pilot, and production activities.

**Reasoning:** Compatibility and operational risks should be tested before production migration.

**Validation required:**
- Environment access controls.
- Deployment approvals.
- Resource isolation.
- Cost allocation and cleanup procedures.
- Migration and rollback plans.

## ADR-008 — Security and Recovery

**Status:** Open — business requirements pending

**Decision:** Finalize security, backup, monitoring, and disaster-recovery controls after the current environment and business requirements have been assessed.

**Validation required:**
- Identity and administrative access.
- Network restrictions.
- Endpoint protection and monitoring.
- Approved RTO and RPO.
- Backup retention and recovery tests.
- Licensing and compliance requirements.

## Decision Review Rules

1. Record the evidence supporting each final decision.
2. Identify assumptions and outstanding dependencies.
3. Obtain client or authorized technical approval where required.
4. Update this document when a decision changes.
5. Do not treat a proposed option as approved merely because it appears in the architecture diagram.

## Current Status

Architecture planning and discovery are in progress. Production technology choices and deployment approval remain pending validation.

## Portfolio Demonstration Boundary

This repository is being developed as an architecture and infrastructure-as-code demonstration using the available Argo migration requirements.

- Proposed designs and assumptions are for demonstration purposes and are not client-approved production decisions.
- Local template validation may be performed without deploying Azure resources.
- Any billable Azure deployment requires explicit authorization, a reviewed design, and cost and security checks.
- Production implementation remains subject to application-vendor compatibility, licensing, workload testing, and approval by the authorized stakeholders.