---
title: Test Isolation AutoRollback
impact: CRITICAL
impactDescription: Without isolation tests leak data and become unreliable
tags: testing, isolation, autorollback
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/perf-test/testing-validation
---
## Test Isolation AutoRollback
Use AutoRollback (default) so no test data persists.
**Incorrect:**
```xpp
[SysTestTransaction(TestTransactionMode::None)]
class MyTest extends SysTestCase { }
```
**Correct:**
```xpp
[SysTestTransaction(TestTransactionMode::AutoRollback)]
class MyPub_OrderTest extends SysTestCase { }
```
