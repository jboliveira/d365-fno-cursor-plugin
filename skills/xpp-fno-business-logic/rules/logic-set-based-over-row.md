---
title: Set-Based Over Row
impact: HIGH
impactDescription: Row-by-row processing does not scale in batch or services
tags: business-logic, performance, set-based
microsoftDocs: https://learn.microsoft.com/training/modules/apply-basic-performance-optimization-finance-operations/
---

## Set-Based Over Row

Prefer set-based SQL operations in business logic.

**Incorrect:**
```xpp
public void closeStaleOrders()
{
    SalesTable salesTable;
    while select salesTable
        where salesTable.SalesStatus == SalesStatus::Backorder
           && salesTable.CreatedDateTime < DateTimeUtil::addDays(DateTimeUtil::utcNow(), -90)
    {
        salesTable.SalesStatus = SalesStatus::Canceled;
        salesTable.update(); // Row-by-row in batch
    }
}
```

**Correct:**
```xpp
public void closeStaleOrders()
{
    SalesTable salesTable;
    ttsbegin;
    update_recordset salesTable
        setting SalesStatus = SalesStatus::Canceled
        where salesTable.SalesStatus == SalesStatus::Backorder
           && salesTable.CreatedDateTime < DateTimeUtil::addDays(DateTimeUtil::utcNow(), -90);
    ttscommit;
}
```
