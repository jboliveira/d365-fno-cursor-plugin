---
title: Set-Based Bulk Operations
impact: HIGH
impactDescription: Row-by-row loops cause N+1 database trips and poor performance
tags: data, performance, set-based
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/dev-ref/xpp-data/xpp-data-perf
---

## Set-Based Bulk Operations

Prefer update_recordset, delete_from, insert_recordset, RecordInsertList.

**Incorrect:**
```xpp
while select forUpdate custTable where custTable.CreditMax > 0
{
    custTable.CreditMax += 1000;
    custTable.update();
}
```

**Correct:**
```xpp
ttsBegin;
update_recordset custTable
    setting CreditMax = custTable.CreditMax + 1000
    where custTable.CreditMax > 0;
ttsCommit;
```
