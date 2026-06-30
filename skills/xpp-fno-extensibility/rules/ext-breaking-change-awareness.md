---
title: Breaking Change Awareness
impact: HIGH
impactDescription: Changing protected/public APIs breaks downstream extenders and compatibility
tags: extensibility, breaking-changes, compatibility
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/compatibility-checker-tool
---

## Breaking Change Awareness

Do not change protected/public signatures, delete table fields, or modify existing labels.

**Incorrect:**
```xpp
// Was protected, now private — breaks extenders
private void validateCustom() { }

// Renamed public method
public void validateWriteExtended() { } // was validateWrite
```

**Correct:**
```xpp
// Add new method; keep existing extension points stable
protected boolean validateCustomRule()
{
    return true;
}

// Add new labels instead of changing existing
// @MyPubLabelNewMessage instead of editing @SYS12345
```
