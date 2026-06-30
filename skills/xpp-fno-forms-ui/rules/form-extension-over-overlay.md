---
title: Form Extension Over Overlay
impact: HIGH
impactDescription: Form extensions preserve side-by-side customization
tags: forms, extension
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/customization-overlayering-extensions
---

## Form Extension Over Overlay

Use form extensions and code-behind extension classes.

**Incorrect:**
```xpp
// Overlayering: modifying CustTable form design in same model/layer as base
// Adding MyPubCustomField directly to base form artifact (not extension)
```

**Correct:**
```xpp
// Form extension artifact: CustTable.MyPublisherExtension
// Adds MyPubCustomField control via extension metadata

[ExtensionOf(formStr(CustTable))]
final class MyPub_CustTableForm_Extension
{
    public void init()
    {
        next init();
        this.design().controlName(formControlStr(CustTable, MyPubCustomField)).visible(true);
    }
}
```
