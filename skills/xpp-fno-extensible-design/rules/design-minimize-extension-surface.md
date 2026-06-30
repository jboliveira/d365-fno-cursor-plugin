---
title: Minimize Extension Surface
impact: CRITICAL
impactDescription: Unnecessary public/protected members become permanent extension contracts
tags: design, solid, open-closed
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/extensible-classes
---

## Minimize Extension Surface

Prefer private > internal > protected > public. Expose only what extenders need.

**Incorrect:**
```xpp
public class OrderService
{
    public void internalCalc() { }
    public void helperStep1() { }
    public void helperStep2() { }
}
```

**Correct:**
```xpp
public class OrderService
{
    public void process(SalesTable _salesTable)
    {
        this.runProcess(_salesTable);
    }

    private void runProcess(SalesTable _salesTable) { }
}
```
