---
title: Prefer CoC Over Delegates
impact: HIGH
impactDescription: Microsoft recommends CoC when extracted methods are available since PU 7.3
tags: extensibility, coc, delegates
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/extensibility-changes-73
---

## Prefer CoC Over Delegates

Use Chain of Command when a wrappable method exists instead of delegate subscriptions.

**Incorrect:**
```xpp
// Subscribing to delegate when CoC method is available
public static void onInserting(Common _sender)
{
    // Harder to control scope; broadcast semantics
}
```

**Correct:**
```xpp
[ExtensionOf(tableStr(SalesTable))]
final class MyPub_SalesTable_Extension
{
    public void insert(boolean _dropInvent)
    {
        next insert(_dropInvent);
    }
}
```
