---
title: Exception Handling
impact: CRITICAL
impactDescription: Poor exception handling hides errors and breaks transaction integrity
tags: business-logic, exception, try-catch
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/dev-ref/xpp-exceptions
---
## Exception Handling
Outermost try + unqualified catch; retry UpdateConflict/Deadlock; never throw Exception enum directly.
**Incorrect:**
```xpp
throw Exception::Error;
```
**Correct:**
```xpp
try
{
    ttsbegin;
    this.process();
    ttscommit;
}
catch (Exception::UpdateConflict)
{
    if (appl.ttsLevel() == 0) retry;
    else throw Exception::UpdateConflictNotRecovered;
}
catch
{
    error("@MyPubLabel:ProcessFailed");
    throw;
}
```
