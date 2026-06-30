---
title: Extensible Enums and EDTs
impact: MEDIUM
impactDescription: Breaking IsExtensible or Extends properties blocks downstream extensions
tags: data, enums, edt
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/extensible-enums
---

## Extensible Enums and EDTs

Extend base enums/EDTs; do not break extensibility properties.

**Incorrect:**
```xpp
// Sealing or renaming enum values consumers depend on
// Changing Extends on published EDT
```

**Correct:**
```xpp
// Extend extensible base enum with publisher-prefixed values
// Extend EDT via extension model; add new values additively
```
