---
title: Entry Point Permissions
impact: CRITICAL
impactDescription: Unsecured entry points expose functionality without authorization
tags: security, entry-point, menu-item
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/sysadmin/security-architecture
---

## Entry Point Permissions

Secure every new menu item and service operation via privilege permissions.

**Incorrect:**
```xpp
// Menu item MyPub_ExportOrders created with:
// - ObjectType: Class
// - Object: MyPub_ExportOrdersController
// - No SecurityPrivilege referencing this menu item
// Any authenticated user can invoke via direct menu URL
```

**Correct:**
```xpp
// SecurityPrivilege: MyPub_ExportOrdersMaintain
//   Entry Points > Menu item access > MyPub_ExportOrders > Read
// SecurityDuty: MyPub_OrderManagementDuty
//   Privileges > MyPub_ExportOrdersMaintain
// SecurityRole: MyPub_OrderClerkRole
//   Duties > MyPub_OrderManagementDuty
```
