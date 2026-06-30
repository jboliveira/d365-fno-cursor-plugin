---
title: Localized Form Labels
impact: HIGH
impactDescription: Hardcoded UI text breaks localization
tags: forms, labels, localization
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/user-interface/create-localizable-labels-client
---

## Localized Form Labels

Separate label files for UI; no hardcoded caption/text.

**Incorrect:**
```xpp
// Form control metadata
// Caption: "Customer account"  (hardcoded string in form design)
// HelpText: "Enter the customer account number"
```

**Correct:**
```xpp
// Form control metadata
// Caption: @MyPubLabel:CustomerAccount
// HelpText: @MyPubLabel:CustomerAccountHelp

public void init()
{
    next init();
    this.design().controlName(formControlStr(MyPub_OrderForm, MyPubStatus)).label("@MyPubLabel:OrderStatus");
}
```
