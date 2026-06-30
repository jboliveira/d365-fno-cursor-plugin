---
title: Data Agnostic Tests
impact: HIGH
impactDescription: Tests depending on demo data fail across environments
tags: testing, data-agnostic
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/get-started/recommendation-data-agnostic-testing-rsat
---

## Data Agnostic Tests

Tests must set up and tear down their own data; depend only on input provided.

**Incorrect:**
```xpp
[SysTestMethod]
public void reserveItem_validQty_reserves()
{
    // Assumes demo data AccountNum "US-001" and item "A0001" exist
    SalesTable salesTable = SalesTable::find("SO-001");
    InventTable inventTable = InventTable::find("A0001");
    this.assertTrue(salesTable.RecId != 0);
}
```

**Correct:**
```xpp
[SysTestMethod]
public void reserveItem_validQty_reserves()
{
    var item = items.default();
    var salesOrder = data.sales().salesOrders().createDefault().save();
    salesOrder.addLine().setItem(item).setQuantity(10).save();
    MyPub_ReservationService::reserve(salesOrder.parmSalesId(), item.ItemId, 10);
    this.assertExpectedReservation(salesOrder.parmSalesId(), item.ItemId, 10);
}
```
