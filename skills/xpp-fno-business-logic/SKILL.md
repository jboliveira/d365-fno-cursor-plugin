---
name: xpp-fno-business-logic
description: Applies D365 F&O business logic patterns including SysOperation, batch jobs, performance optimization, exception handling, and label usage. Use when writing classes, services, batch classes, RunBaseBatch, SysOperationServiceController, caching, or Infolog messaging in X++ finance and operations.
paths:
  - "**/*.xpp"
  - "**/AxClass/**"
  - "**/AxTable/**"
  - "**/AxForm/**"
  - "**/AxDataEntityView/**"
  - "**/AxEnum/**"
  - "**/AxEdt/**"
  - "**/AxQuery/**"
metadata:
  version: "1.0.0"
  platform: "D365 Finance and Operations"
  sources: "Microsoft Learn F&O dev-itpro"
---

# D365 F&O Business Logic

Runtime patterns for classes, services, batch, and performance.

## When to Apply

- Creating batch jobs or SysOperation services
- Writing business service classes
- Optimizing performance (caching, set-based ops)
- Exception handling and Infolog messaging

## Rules

| Impact | Rules |
|--------|-------|
| CRITICAL | logic-use-frameworks, logic-sysoperation-new-code, logic-exception-handling, logic-labels-not-literals |
| HIGH | logic-batch-short-tts, logic-batch-task-limits, logic-set-based-over-row, logic-infolog-messaging |
| MEDIUM | logic-batch-parameter-versioning, logic-caching-appropriate, logic-application-classes-not-system |

## Additional Resources

- [references/batch-sysoperation-patterns.md](references/batch-sysoperation-patterns.md)
- [references/performance-checklist.md](references/performance-checklist.md)
