---
title: Publisher Prefix Naming
impact: HIGH
impactDescription: Consistent naming prevents collisions in multi-vendor environments
tags: extensibility, naming
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/naming-guidelines-extensions
---

## Publisher Prefix Naming

Prefix all new artifacts with publisher identifier (3–5 characters).

**Incorrect:**
```xpp
// Ambiguous in shared environment
class OrderValidator { }
table CustomerExtension { }
```

**Correct:**
```xpp
class MyPub_OrderValidator { }
table MyPub_CustomerExtension { }
final class MyPub_SalesTable_Extension { }
class MyPub_SalesTable_PostEventHandler { }
```
