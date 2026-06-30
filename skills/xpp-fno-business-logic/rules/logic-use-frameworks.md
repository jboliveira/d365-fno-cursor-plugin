---
title: Use Frameworks
impact: CRITICAL
impactDescription: Ad-hoc patterns bypass validation, security, and upgrade paths
tags: business-logic, frameworks, sysoperation
microsoftDocs: https://learn.microsoft.com/dynamics365/guidance/implementation-guide/extend-your-solution-guidance-product-fo#extending-the-app
---

## Use Frameworks

Use SysOperation and table `update()` business logic instead of ad-hoc SQL or `do*` methods.

**Incorrect:**
```xpp
public void updateCreditMax(AccountNum _accountNum, AmountCur _amount)
{
    CustTable custTable;
    select custTable where custTable.AccountNum == _accountNum;
    custTable.CreditMax = _amount;
    custTable.doUpdate(); // Bypasses validateWrite, events, and security
}
```

**Correct:**
```xpp
public void updateCreditMax(AccountNum _accountNum, AmountCur _amount)
{
    CustTable custTable;
    ttsbegin;
    select forupdate custTable where custTable.AccountNum == _accountNum;
    if (custTable.RecId)
    {
        custTable.CreditMax = _amount;
        custTable.update(); // Runs standard table business logic
    }
    ttscommit;
}
```
