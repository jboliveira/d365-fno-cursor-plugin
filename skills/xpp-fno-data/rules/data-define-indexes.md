---
title: Define Indexes and Delete Actions
impact: HIGH
impactDescription: Missing indexes cause performance issues; delete actions protect referential integrity
tags: data, metadata, indexes
microsoftDocs: https://learn.microsoft.com/dynamics365/guidance/implementation-guide/extend-your-solution-guidance-product-fo#extending-the-app
---

## Define Indexes and Delete Actions

Apply indexes for query paths; define delete actions on relations.

**Incorrect:**
```xpp
// Table with foreign key fields but no index on join columns
// No delete action on child table referencing parent
```

**Correct:**
```xpp
// Index: AccountNumIdx on AccountNum
// Relation + DeleteAction = Restricted/Cascade as appropriate
```
