---
title: Single Responsibility Methods
impact: CRITICAL
impactDescription: Every public/protected method is an extension point; long methods create fragile extension surfaces
tags: design, solid, clean-code
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/writing-extensible-code
---

## Single Responsibility Methods

Keep methods 5–10 lines, ≤2 parameters, single-line conditions/blocks.

**Incorrect:**
```xpp
public void processOrder(SalesTable _salesTable)
{
    // 80 lines: validation, pricing, inventory, posting inline
}
```

**Correct:**
```xpp
public void processOrder(SalesTable _salesTable)
{
    if (this.validateOrder(_salesTable))
        this.confirmOrder(_salesTable);
    else
        this.rejectOrder(_salesTable);
}
```
