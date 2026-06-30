---
title: Final ExtensionOf Classes
impact: CRITICAL
impactDescription: Extension classes must be final with ExtensionOf attribute per class extension model
tags: extensibility, extensionof, class
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/class-extensions
---

## Final ExtensionOf Classes

Extension classes are `final`, use `[ExtensionOf]`, and end with `_Extension`.

**Incorrect:**
```xpp
class MyPub_CustTable_Extension
{
    public void myMethod() { }
}
```

**Correct:**
```xpp
[ExtensionOf(classStr(CustTable))]
final class MyPub_CustTable_Extension
{
    private void new() { }

    public void myMethod() { }
}
```
