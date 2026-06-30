---
title: DRY Across Extension Points
impact: CRITICAL
impactDescription: Partial extension of duplicated logic leaves solution broken
tags: design, dry
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/writing-extensible-code
---

## DRY Across Extension Points

Centralize shared logic; do not duplicate across methods extenders may override individually.

**Incorrect:**
```xpp
public boolean validateWrite() { /* duplicate checks */ return true; }
public boolean insert() { /* same duplicate checks */ return super(); }
```

**Correct:**
```xpp
public boolean validateWrite()
{
    return this.validateCommonRules() && next validateWrite();
}

protected boolean validateCommonRules()
{
    return this.checkCreditLimit() && this.checkHoldStatus();
}
```
