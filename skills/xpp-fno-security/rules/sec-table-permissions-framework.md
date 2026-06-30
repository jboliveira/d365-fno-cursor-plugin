---
title: Table Permissions Framework
impact: HIGH
impactDescription: TPF enforces field/table access for sensitive data at AOS level
tags: security, tpf, table-permissions
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/sysadmin/security-architecture
---

## Table Permissions Framework

Use Table Permissions Framework for sensitive tables and fields.

**Incorrect:**
```xpp
// Form-only protection: hide HcmWorker.PayRate control via Visible = No
// OData, reports, and other forms still expose PayRate field
public void init()
{
    next init();
    PayRate.visible(false); // UI hiding only — not AOS enforcement
}
```

**Correct:**
```xpp
// Table Permissions Framework policy on HcmWorker
// Field permission: PayRate > NoAccess for roles without compensation duty
// Enforced at AOS for all access paths (forms, entities, reports)
```
