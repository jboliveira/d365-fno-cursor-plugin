---
title: Effective Date Framework
impact: MEDIUM
impactDescription: Temporal data should use F&O effective date patterns when applicable
tags: data, metadata, effective-dates
microsoftDocs: https://learn.microsoft.com/dynamics365/guidance/implementation-guide/extend-your-solution-guidance-product-fo#extending-the-app
---

## Effective Date Framework

Use effective date framework for valid-time state data.

**Incorrect:**
```xpp
// Custom ValidFrom/ValidTo without framework integration
table MyPub_PriceHistory
{
    ValidFromDate fromDate;
    ValidToDate toDate;
    // Manual overlap logic everywhere
}
```

**Correct:**
```xpp
// Use ValidTimeState tables or extend patterns from ApplicationSuite
// Apply ValidTimeStateUpdateMode on cursors where required
```
