---
title: Static Extension Methods for Utility
impact: MEDIUM
impactDescription: Static _Extension classes add utility methods without state; not for business logic replacement
tags: extensibility, static-extension
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/dev-ref/xpp-data-composite
---

## Static Extension Methods for Utility

Use static extension classes for helper methods only.

**Incorrect:**
```xpp
[ExtensionOf(classStr(SalesTable))]
final class MyPub_SalesTable_Extension
{
    public static void replaceInsertLogic(SalesTable _salesTable)
    {
        // Business logic replacement via static helper
    }
}
```

**Correct:**
```xpp
final class MyPub_StrUtil_Extension
{
    public static str formatOrderId(SalesId _salesId)
    {
        return strFmt('ORD-%1', _salesId);
    }
}
```
