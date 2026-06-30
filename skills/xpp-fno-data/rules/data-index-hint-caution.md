---
title: Index Hint Caution
impact: MEDIUM
impactDescription: Wrong index hints can degrade performance; use only when verified
tags: data, select, index-hint
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/dev-ref/xpp-data/xpp-select-statement
---

## Index Hint Caution

Use index hint only after trace verification.

**Incorrect:**
```xpp
custTable.allowIndexHint(true);
while select forUpdate custTable index hint AccountIdx { }
// Applied without verifying query plan
```

**Correct:**
```xpp
// Verify with Trace Parser first
custTable.allowIndexHint(true);
while select forUpdate custTable
    index hint AccountIdx
    where custTable.AccountNum == _accountNum
{
}
```
