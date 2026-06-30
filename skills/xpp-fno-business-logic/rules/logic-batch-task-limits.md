---
title: Batch Task Limits
impact: HIGH
impactDescription: More than 1000 tasks per job causes inefficiency
tags: business-logic, batch
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/sysadmin/create-batch-class
---

## Batch Task Limits

Decompose jobs with more than 1000 tasks.

**Incorrect:**
```xpp
public void scheduleTasks()
{
    BatchHeader batchHeader = BatchHeader::construct();
    batchHeader.parmCaption("@MyPubLabel:ProcessOrders");
    for (int i = 1; i <= 5000; i++)
    {
        BatchInfo batchInfo = batchHeader.addTask(new MyPub_ProcessOneOrderTask(i));
        batchInfo.parmGroupId('OrderProcessing');
    }
    batchHeader.save();
}
```

**Correct:**
```xpp
public void scheduleTasks()
{
    BatchHeader batchHeader = BatchHeader::construct();
    batchHeader.parmCaption("@MyPubLabel:ProcessOrders");
    int chunkSize = 500;
    for (int chunk = 0; chunk < 10; chunk++)
    {
        BatchInfo batchInfo = batchHeader.addTask(new MyPub_ProcessOrderChunkTask(chunk, chunkSize));
        batchInfo.parmGroupId('OrderProcessing');
    }
    batchHeader.save();
}
```
