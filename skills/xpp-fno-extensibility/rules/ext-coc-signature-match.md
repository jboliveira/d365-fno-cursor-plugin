---
title: CoC Signature Match
impact: CRITICAL
impactDescription: Signature mismatch prevents compile or runtime chain invocation
tags: extensibility, coc, signature
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/method-wrapping-coc
---

## CoC Signature Match

Wrapper signature must match base method. Omit default parameter values in wrapper.

**Incorrect:**
```xpp
// Base: public void salute(str message = "Hi")

public void salute(str message = "Hi")
{
    next salute(message);
}
```

**Correct:**
```xpp
public void salute(str message)
{
    next salute(message);
}
```
