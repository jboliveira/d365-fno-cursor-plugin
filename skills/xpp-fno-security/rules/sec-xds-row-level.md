---
title: XDS Row-Level Security
impact: HIGH
impactDescription: XDS filters rows but impacts performance if misdesigned
tags: security, xds, row-level
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/sysadmin/extensible-data-security-policies
---

## XDS Row-Level Security

Use XDS policies for row-level filtering; test query performance.

**Incorrect:**
```xpp
// XDS policy query on CustTable joining 5 tables:
// CustTable join DirPartyTable join LogisticPostalAddress
//   join HcmWorker join UserInfo ...
// Applied on every CustTable read — severe performance impact
```

**Correct:**
```xpp
// Focused XDS policy:
// Constrained tables: CustTable only
// Query: CustTable where CustTable.CustGroup == curUserCustGroup()
// Validate with Trace Parser; provide bypass role for diagnostics only
```
