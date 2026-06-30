---
title: Dependency Inversion
impact: MEDIUM
impactDescription: Depend on abstractions so extenders can provide implementations
tags: design, solid, sysextension
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/writing-extensible-code
---

## Dependency Inversion

Depend on interfaces or SysExtension abstractions, not concrete classes.

**Incorrect:**
```xpp
MyPub_ConcreteValidator validator = new MyPub_ConcreteValidator();
validator.validate(_record);
```

**Correct:**
```xpp
MyPub_IOrderValidator validator = MyPub_ValidatorFactory::create(_orderType);
validator.validate(_record);
```
