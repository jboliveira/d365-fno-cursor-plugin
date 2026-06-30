---
title: Application Classes Not System
impact: MEDIUM
impactDescription: Kernel/system classes are not supported extension targets
tags: business-logic, classes, conventions
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/dev-ref/xpp-classes-methods
---

## Application Classes Not System

Use application classes (`ClassFactory`) not kernel classes (`xClassFactory`).

**Incorrect:**
```xpp
public void runProcess()
{
    // Direct kernel/system class usage — unsupported extension surface
    System.IO.File::WriteAllText(@"C:\Temp\export.txt", this.getPayload());
}
```

**Correct:**
```xpp
public void runProcess()
{
    MyPub_ExportService exportService = MyPub_ExportService::construct();
    exportService.exportToArchive(this.getPayload()); // Application-layer service
}
```
