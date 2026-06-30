---
title: Additive Event Handlers
impact: HIGH
impactDescription: Unconditional EventHandlerResult breaks side-by-side extensions
tags: extensibility, events, intrusive
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/intrusive-customizations
---

## Additive Event Handlers

Never unconditionally set results in event handler result classes.

**Incorrect:**
```xpp
[PostHandlerFor(classStr(SalesTable), methodStr(SalesTable, insert))]
public static void SalesTable_Post_insert(XppPrePostArgs _args)
{
    _args.setReturnValue(false); // Always blocks base behavior
}
```

**Correct:**
```xpp
[PostHandlerFor(classStr(SalesTable), methodStr(SalesTable, insert))]
public static void SalesTable_Post_insert(XppPrePostArgs _args)
{
    SalesTable salesTable = _args.getThis() as SalesTable;
    if (salesTable && salesTable.MyPubRequiresHold())
    {
        _args.setReturnValue(false);
    }
}
```
