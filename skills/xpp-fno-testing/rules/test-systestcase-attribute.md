---
title: SysTestCase and SysTestMethod
impact: CRITICAL
impactDescription: SysTest framework enables automated unit testing in Visual Studio
tags: testing, systest, unit-test
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/perf-test/testing-support
---
## SysTestCase and SysTestMethod
Extend SysTestCase; mark test methods with SysTestMethod attribute.
**Incorrect:**
```xpp
class MyTest { public void testSomething() { } }
```
**Correct:**
```xpp
class MyPub_OrderTest extends SysTestCase
{
    [SysTestMethod]
    public void createOrder_validInput_succeeds() { }
}
```
