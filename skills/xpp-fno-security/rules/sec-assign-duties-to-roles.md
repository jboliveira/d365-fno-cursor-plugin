---
title: Assign Duties to Roles
impact: HIGH
impactDescription: Duties enable segregation of duties and maintainable security model
tags: security, duties, sod
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/sysadmin/role-based-security
---

## Assign Duties to Roles

Assign duties (not raw privileges) to roles; segregate conflicting duties.

**Incorrect:**
```xpp
// SecurityRole: MyPub_APClerkRole
// Privileges (40 unrelated privileges attached directly):
//   - VendInvoiceJournalPost
//   - VendPaymentCreate
//   - BankAccountMaintain
//   - ... (no duty grouping, no SOD review)
```

**Correct:**
```xpp
// SecurityRole: MyPub_APClerkRole
// Duties:
//   - MyPub_APInvoiceEntryDuty (3 privileges)
//   - MyPub_APInquiryDuty (2 privileges)
// Conflicting duty MyPub_VendPaymentApprovalDuty assigned to separate approver role
```
