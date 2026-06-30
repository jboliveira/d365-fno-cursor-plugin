---
title: Extract While and If Blocks
impact: HIGH
impactDescription: Inline while/if blocks in middle of methods are hard to extend
tags: design, extensible-methods
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/extensible-methods
---

## Extract While and If Blocks

Move while/if logic to separate extensible methods.

**Incorrect:**
```xpp
public void run()
{
    while select salesLine where salesLine.SalesId == _salesId
    {
        // Complex per-line logic inline
        salesLine.update();
    }
}
```

**Correct:**
```xpp
public void run()
{
    while select salesLine where salesLine.SalesId == _salesId
    {
        this.processLine(salesLine);
    }
}

protected void processLine(SalesLine _salesLine)
{
    this.validateLine(_salesLine);
    _salesLine.update();
}
```
