---
title: Appropriate Caching
impact: MEDIUM
impactDescription: Wrong cache strategy causes stale data or memory pressure
tags: business-logic, performance, caching
microsoftDocs: https://learn.microsoft.com/training/modules/apply-basic-performance-optimization-finance-operations/
---

## Appropriate Caching

Use table cache, temp tables, and minimal variable scope per Microsoft perf guidance.

**Incorrect:**
```xpp
class MyPub_CustCache
{
    private static Map custCacheMap; // Unbounded, session-spanning static cache

    public static CustTable find(AccountNum _accountNum)
    {
        if (!custCacheMap)
        {
            custCacheMap = new Map(Types::String, Types::Record);
        }
        if (!custCacheMap.exists(_accountNum))
        {
            custCacheMap.insert(_accountNum, CustTable::find(_accountNum));
        }
        return custCacheMap.lookup(_accountNum);
    }
}
```

**Correct:**
```xpp
class MyPub_OrderProcessor
{
    public void process(SalesId _salesId)
    {
        TmpCustTable tmpWorking; // Session-scoped temp table
        CustTable custTable = CustTable::find(SalesTable::find(_salesId).CustAccount);
        tmpWorking.setTmpData(custTable);
        this.applyRules(tmpWorking);
    }
}
```
