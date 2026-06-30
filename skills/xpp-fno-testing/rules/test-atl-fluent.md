---
title: ATL Fluent API
impact: HIGH
impactDescription: ATL improves readability and discoverability of test data setup
tags: testing, atl, fluent
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/perf-test/atl-best-practices
---
## ATL Fluent API
Use ATL with var and inline declarations.
**Incorrect:**
```xpp
InventTable item;
AtlEntitySalesOrder salesOrder;
item = InventTable::find("A0001");
salesOrder = AtlEntitySalesOrder::construct();
```
**Correct:**
```xpp
var item = items.default();
var salesOrder = data.sales().salesOrders().createDefault();
var salesLine = salesOrder.addLine().setItem(item).setQuantity(10).save();
```
