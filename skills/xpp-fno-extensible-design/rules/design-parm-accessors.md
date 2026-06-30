---
title: Parm Accessors and Parameters
impact: MEDIUM
impactDescription: Standard X++ conventions improve readability and maintainability
tags: design, conventions, parm
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/dev-ref/xpp-classes-methods
---

## Parm Accessors and Parameters

Use `parm*` accessors and underscore-prefixed parameters.

**Incorrect:**
```xpp
public void updateOrder(SalesTable salesTable, boolean dropInvent)
{
    salesTable.doUpdate();
}
```

**Correct:**
```xpp
public SalesTable parmSalesTable(SalesTable _salesTable = salesTable)
{
    salesTable = _salesTable;
    return salesTable;
}

public void updateOrder(SalesTable _salesTable, boolean _dropInvent)
{
    _salesTable.selectForUpdate(true);
    _salesTable.update();
}
```
