---
title: No Overlayering
impact: CRITICAL
impactDescription: Overlayering blocks side-by-side extensions and breaks updatability since sealed models
tags: extensibility, overlayering, intrusive
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/intrusive-customizations
---

## No Overlayering

Use metadata and code extensions only. Product models are sealed since v8.0.

**Incorrect:**
```xpp
// Overlayering SalesTable.insert in same model layer
public void insert(boolean _dropInvent)
{
    // Replaces base implementation — blocks other ISVs
    super(_dropInvent);
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
