---
title: No doUpdate doInsert doDelete
impact: CRITICAL
impactDescription: do* methods skip CoC, events, validation, and business logic
tags: data, doupdate, validation
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/dev-ref/xpp-data/xpp-update
---

## No doUpdate doInsert doDelete

Never bypass table methods with do* unless documented exception.

**Incorrect:**
```xpp
select forUpdate custTable where custTable.AccountNum == _accountNum;
custTable.CreditMax = 5000;
custTable.doUpdate();
```

**Correct:**
```xpp
select forUpdate custTable where custTable.AccountNum == _accountNum;
custTable.CreditMax = 5000;
custTable.update();
```
