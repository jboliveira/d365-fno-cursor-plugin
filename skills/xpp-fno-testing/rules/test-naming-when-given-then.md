---
title: When Given Then Naming
impact: MEDIUM
impactDescription: Consistent naming improves test discoverability and intent
tags: testing, naming, conventions
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/perf-test/public-application-tests
---

## When Given Then Naming

Use `when_given_then` method names; never run tests on production.

**Incorrect:**
```xpp
class MyPub_OrderTest extends SysTestCase
{
    [SysTestMethod]
    public void test1() // Non-descriptive name; run on production environment
    {
        this.assertTrue(true);
    }
}
```

**Correct:**
```xpp
class MyPub_OrderTest extends SysTestCase
{
    [SysTestMethod]
    public void reservingItem_noOnhand_throwsException()
    {
        // Dev/test environment only; SysTest isolation with AutoRollback
        var item = items.default().setOnHand(0);
        this.parmExceptionExpected(true);
        MyPub_ReservationService::reserve(item.ItemId, 1);
    }
}
```
