---
title: Throw Aborts Transaction
impact: HIGH
impactDescription: throw auto-aborts TTS; UpdateConflict requires explicit catch and retry
tags: data, exception, transaction
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/dev-ref/xpp-exceptions
---

## Throw Aborts Transaction

Prefer throw over ttsAbort; handle UpdateConflict with explicit type and retry.

**Incorrect:**
```xpp
ttsBegin;
if (!this.validate())
{
    ttsAbort;
    return;
}
custTable.update();
ttsCommit;
```

**Correct:**
```xpp
try
{
    ttsbegin;
    if (!this.validate())
        throw error("@MyPubLabel:ValidationFailed");
    custTable.update();
    ttscommit;
}
catch (Exception::UpdateConflict)
{
    if (appl.ttsLevel() == 0) retry;
    else throw Exception::UpdateConflictNotRecovered;
}
```
