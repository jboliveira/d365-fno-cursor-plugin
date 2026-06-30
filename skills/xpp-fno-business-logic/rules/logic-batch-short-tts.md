---
title: Batch Short TTS
impact: HIGH
impactDescription: Long transactions in batch cause locking and contention
tags: business-logic, batch, transaction
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/sysadmin/create-batch-class
---

## Batch Short TTS

Keep transactions short; use checkpoints; design idempotent retry-safe operations.

**Incorrect:**
```xpp
public void run()
{
    SalesLine salesLine;
    ttsbegin;
    while select forupdate salesLine where salesLine.RemainInventPhysical > 0
    {
        this.processLine(salesLine); // Single TTS around 100k records
    }
    ttscommit;
}
```

**Correct:**
```xpp
public void run()
{
    SalesLine salesLine;
    RecId lastProcessedRecId = this.getCheckpointRecId();
    while select forupdate salesLine
        where salesLine.RecId > lastProcessedRecId
           && salesLine.RemainInventPhysical > 0
    {
        ttsbegin;
        this.processLine(salesLine);
        this.setCheckpointRecId(salesLine.RecId);
        ttscommit;
    }
}
```
