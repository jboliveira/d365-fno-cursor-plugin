---
title: Form Nested CoC Classes
impact: HIGH
impactDescription: Each form datasource/field/control requires its own extension class
tags: extensibility, coc, forms
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/method-wrapping-coc
---

## Form Nested CoC Classes

Use separate extension classes per form datasource, field, or control.

**Incorrect:**
```xpp
[ExtensionOf(formStr(SalesTable))]
final class SalesTable_Form_Extension
{
    // Cannot wrap datasource init from form extension class
}
```

**Correct:**
```xpp
[ExtensionOf(formDataSourceStr(SalesTable, SalesTable))]
final class MyPub_SalesTableDS_Extension
{
    public void init()
    {
        next init();
    }
}
```
