---
title: Data Entity Purpose Fit
impact: HIGH
impactDescription: Wrong entity choice causes integration latency or data proliferation
tags: data, data-entities, integration
microsoftDocs: https://learn.microsoft.com/dynamics365/guidance/implementation-guide/extend-your-solution-guidance-product-fo#extending-the-app
---

## Data Entity Purpose Fit

Built-in entities for general use; custom entities for high-volume/low-latency.

**Incorrect:**
```xpp
// Custom entity duplicating standard CustCustomerV3 for simple OData read
dataentity MyPub_CustomerCopyEntity { /* mirrors built-in */ }
```

**Correct:**
```xpp
// Extend or use built-in CustCustomerV3
// Create custom entity only for high-volume staging with specific performance features
```
