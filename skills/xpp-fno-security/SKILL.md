---
name: xpp-fno-security
description: Applies D365 F&O role-based security including duties, privileges, entry point permissions, Table Permissions Framework, and XDS policies. Use when creating security roles, duties, privileges, menu item permissions, data entity security, or extensible data security in finance and operations.
paths:
  - "**/AxSecurityRole/**"
  - "**/AxSecurityDuty/**"
  - "**/AxSecurityPrivilege/**"
  - "**/AxMenuItemAction/**"
  - "**/AxMenuItemDisplay/**"
  - "**/AxDataEntityView/**"
  - "**/*.xpp"
metadata:
  version: "1.0.0"
  platform: "D365 Finance and Operations"
  sources: "Microsoft Learn F&O dev-itpro"
---

# D365 F&O Security

Role-based security and extensible data security (XDS).

## Hierarchy

Roles → Duties → Privileges → Permissions → Securable objects

## Rules

- sec-rbac-least-privilege — minimum access; full hierarchy
- sec-assign-duties-to-roles — duties to roles; segregate duties
- sec-entry-point-permissions — secure every new entry point
- sec-table-permissions-framework — TPF for sensitive tables/fields
- sec-xds-row-level — XDS for row-level filtering; mind performance
- sec-extend-not-modify-standard — duplicate/extend standard roles
- sec-data-entity-integration-mode — OData vs Data Management permissions

## Additional Resources

- [references/security-patterns.md](references/security-patterns.md)
