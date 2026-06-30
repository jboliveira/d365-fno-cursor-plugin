---
title: Normalize Data Model
impact: HIGH
impactDescription: Redundant tables/fields copy poor legacy modeling and hurt maintainability
tags: data, metadata, normalization
microsoftDocs: https://learn.microsoft.com/dynamics365/guidance/implementation-guide/extend-your-solution-guidance-product-fo#extending-the-app
---

## Normalize Data Model

Avoid redundant copies of legacy poor models.

**Incorrect:**
```xpp
// Duplicate customer address stored on custom table mirroring DirParty
table MyPub_CustomerAddressCopy { /* duplicates CustTable + LogisticsPostalAddress */ }
```

**Correct:**
```xpp
// Extend existing tables; reference DirParty/Logistics patterns
[ExtensionOf(tableStr(CustTable))]
final class MyPub_CustTable_Extension { }
```
