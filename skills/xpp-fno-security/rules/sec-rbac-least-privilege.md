---
title: RBAC Least Privilege
impact: CRITICAL
impactDescription: Excessive permissions violate SOX/compliance and increase risk
tags: security, rbac, least-privilege
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/sysadmin/role-based-security
---

## RBAC Least Privilege

Model Roles → Duties → Privileges → Permissions; grant minimum required.

**Incorrect:**
```xpp
// SecurityRole: MyPub_APClerkRole
// Duties: System administrator (full platform access for routine AP tasks)
```

**Correct:**
```xpp
// SecurityRole: MyPub_APClerkRole
// Duties:
//   - MyPub_VendInvoiceEntryDuty (invoice entry menu items only)
//   - MyPub_VendInquiryDuty (read-only vendor inquiry)
// No access to user management, batch admin, or unrelated modules
```
