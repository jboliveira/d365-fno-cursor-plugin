---
title: CoC next at First Level
impact: CRITICAL
impactDescription: Conditional or nested next breaks chain integrity per Microsoft CoC rules
tags: extensibility, coc, chain-of-command
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/method-wrapping-coc
---

## CoC next at First Level

Wrapper methods must call `next` unconditionally at the first level of the method body.

**Incorrect:**
```xpp
public void validateWrite()
{
    boolean ret;
    if (this.MyField)
    {
        ret = next validateWrite();
    }
    return ret;
}
```

**Correct:**
```xpp
public boolean validateWrite()
{
    boolean ret = next validateWrite();
    if (this.MyField && !ret)
    {
        ret = checkCustomRule();
    }
    return ret;
}
```
