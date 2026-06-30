---
title: Labels Not Literals
impact: CRITICAL
impactDescription: Hardcoded strings break localization and label change compatibility
tags: business-logic, labels, localization
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/user-interface/create-localizable-labels-client
---

## Labels Not Literals

All user-facing messages via label files.

**Incorrect:**
```xpp
public void confirmOrder(SalesId _salesId)
{
    if (SalesTable::find(_salesId).RecId)
    {
        info("Order confirmed successfully"); // Hardcoded literal
    }
}
```

**Correct:**
```xpp
public void confirmOrder(SalesId _salesId)
{
    if (SalesTable::find(_salesId).RecId)
    {
        info("@MyPubLabel:OrderConfirmed");
    }
}
```
