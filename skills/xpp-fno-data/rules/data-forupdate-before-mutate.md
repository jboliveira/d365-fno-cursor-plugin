---
title: forUpdate Before Mutate
impact: CRITICAL
impactDescription: Updates without forUpdate violate transactional integrity checks
tags: data, forupdate, transaction
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/dev-ref/xpp-data/xpp-transaction
---

## forUpdate Before Mutate

Always `select forUpdate` before update or delete.

**Incorrect:**
```xpp
ttsBegin;
select custTable where custTable.AccountNum == _accountNum;
custTable.CreditMax = 5000;
custTable.update();
ttsCommit;
```

**Correct:**
```xpp
ttsBegin;
select forUpdate custTable where custTable.AccountNum == _accountNum;
if (custTable)
{
    custTable.CreditMax = 5000;
    custTable.update();
}
ttsCommit;
```
