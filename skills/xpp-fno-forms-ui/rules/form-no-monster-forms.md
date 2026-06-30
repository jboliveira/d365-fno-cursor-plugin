---
title: No Monster Forms
impact: HIGH
impactDescription: All-in-one forms hurt performance and maintainability
tags: forms, ui, patterns
microsoftDocs: https://learn.microsoft.com/dynamics365/guidance/implementation-guide/extend-your-solution-guidance-product-fo#extending-the-app
---

## No Monster Forms

Do not build all-in-one forms copying legacy UX.

**Incorrect:**
```xpp
// Single form MyPub_MegaOrderHub with:
// - 15 tabs (Sales, Inventory, WHS, AP, AR, Projects, ...)
// - 8 unrelated grids on one tab
// - Cross-module logic in form init()
```

**Correct:**
```xpp
// Separate forms per process:
// - MyPub_OrderEntry (SimpleListDetails)
// - MyPub_OrderInquiry (DetailsFormTransaction)
// - MyPub_OrderWorkspace (Operational Workspace with form parts)
// Navigation via menu items and workspace tiles
```
