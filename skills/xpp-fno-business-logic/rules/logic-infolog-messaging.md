---
title: Infolog Messaging
impact: HIGH
impactDescription: CLRError and some exceptions are not shown unless surfaced to Infolog
tags: business-logic, infolog, exception
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/dev-ref/xpp-exceptions
---
## Infolog Messaging
Throw via Global::error/warning/info; surface CLRError to Infolog.
**Incorrect:**
```xpp
catch (Exception::CLRError)
{
    throw Exception::Error; // Message lost
}
```
**Correct:**
```xpp
catch (Exception::CLRError)
{
    System.Exception ex = CLRInterop::getLastException();
    throw error(ex.Message);
}
```
