---
title: Form CoC for Methods
impact: HIGH
impactDescription: Form logic belongs in extension classes with CoC on datasources/controls
tags: forms, coc, extension
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/method-wrapping-coc
---

## Form CoC for Methods

CoC for form/datasource/control methods; state in extension class.

**Incorrect:**
```xpp
// Inline duplicated logic in form control OnClicked without CoC structure
public void MyControl_OnClicked(FormControl _sender, FormControlEventArgs _e)
{
    if (CustTable::find(this.CustAccount).Blocked == CustVendorBlocked::All)
    {
        throw error("Customer is blocked"); // Hardcoded; no next chain
    }
}
```

**Correct:**
```xpp
[ExtensionOf(formStr(CustTable))]
final class MyPub_CustTableForm_Extension
{
    private boolean myPubCustomValidated;

    public void init()
    {
        next init();
        myPubCustomValidated = false;
    }
}

[ExtensionOf(formDataSourceStr(CustTable, CustTable))]
final class MyPub_CustTable_DS_Extension
{
    public boolean validateWrite()
    {
        boolean ret = next validateWrite();
        if (ret)
        {
            ret = MyPub_CustValidationService::validate(this);
        }
        return ret;
    }
}
```
