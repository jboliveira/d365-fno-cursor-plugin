---
title: Extend Not Modify Standard Security
impact: HIGH
impactDescription: Modifying standard roles breaks on platform updates
tags: security, roles, standard
microsoftDocs: https://learn.microsoft.com/dynamics365/guidance/implementation-guide/security-strategy-product-oa
---

## Extend Not Modify Standard Security

Duplicate standard roles before customizing; do not modify standard artifacts.

**Incorrect:**
```xpp
// Directly editing standard SecurityRole: Accounts receivable clerk
// Adding custom duty MyPub_CustomCreditCheckDuty to standard role artifact
// Overwritten or lost on platform update/merge
```

**Correct:**
```xpp
// Duplicate standard role to: MyPub_AccountsReceivableClerk
// Add MyPub_CustomCreditCheckDuty to the copy only
// Assign users to MyPub_AccountsReceivableClerk, not modified standard role
```
