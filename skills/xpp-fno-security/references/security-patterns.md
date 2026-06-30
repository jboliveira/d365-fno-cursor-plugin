# Security Patterns

## RBAC Modeling

1. Create privilege with permissions on entry points (menu items, services)
2. Group privileges into duties (business process parts)
3. Assign duties to roles (not raw privileges)
4. Assign roles to users

## Entry Points

Every new menu item, service operation, or data entity needs privilege/permission mapping.

## XDS Policies

- Policy contains query filter + constrained tables
- Decreases access (permissions increase access)
- Test performance impact; avoid over-broad filters
- XDSDataAccessPolicyBypassRole for diagnostics only

## Standard Roles

Duplicate standard roles before modifying. Do not edit standard artifacts in place.

Sources: [Role-based security](https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/sysadmin/role-based-security), [Extensible data security policies](https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/sysadmin/extensible-data-security-policies)
