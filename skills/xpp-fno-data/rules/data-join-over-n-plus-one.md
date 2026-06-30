---
title: Join Over N Plus One
impact: HIGH
impactDescription: Nested while-select causes excessive database round trips
tags: data, select, join, performance
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/dev-ref/xpp-data/xpp-select-statement
---

## Join Over N Plus One

Use joins instead of nested while-select loops.

**Incorrect:**
```xpp
while select custGroup
{
    while select custTable where custTable.CustGroup == custGroup.CustGroup
    {
        totalCredit += custTable.CreditMax;
    }
}
```

**Correct:**
```xpp
while select custGroup
    join custTable
    where custTable.CustGroup == custGroup.CustGroup
{
    totalCredit += custTable.CreditMax;
}
```
