---
title: SysOperation for New Code
impact: CRITICAL
impactDescription: SysOperationServiceController is Microsoft recommended over RunBaseBatch for new services
tags: business-logic, sysoperation, batch
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/process-automation/run-process
---

## SysOperation for New Code

Prefer `SysOperationServiceController` over `RunBaseBatch` for new batch/services.

**Incorrect:**
```xpp
class MyPub_ExportOrdersBatch extends RunBaseBatch
{
    public void run()
    {
        // Legacy pattern for new integration export service
    }
}
```

**Correct:**
```xpp
class MyPub_ExportOrdersController extends SysOperationServiceController
{
    public static void main(Args _args)
    {
        MyPub_ExportOrdersController controller = new MyPub_ExportOrdersController();
        controller.startOperation();
    }
}

class MyPub_ExportOrdersService extends SysOperationServiceBase
{
    public void exportOrders(MyPub_ExportOrdersContract _contract)
    {
        // Service logic with contract/data contract classes
    }
}
```
