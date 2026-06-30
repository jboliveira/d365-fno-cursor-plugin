---
title: Data Entity Integration Mode
impact: MEDIUM
impactDescription: OData and Data Management require different permission integration modes
tags: security, data-entities, odata
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/data-entities/security-data-entities
---

## Data Entity Integration Mode

Set entity permission Integration Mode correctly (All, Data Services, Data Management).

**Incorrect:**
```xpp
// SecurityPrivilege on MyPub_CustomerEntity
// Data Entity Permissions > MyPub_CustomerEntity
// Integration Mode: All
// Entity only used for DMF import/export — over-exposes OData surface
```

**Correct:**
```xpp
// DMF-only entity:
// Integration Mode: DataManagement

// OData-only entity:
// Integration Mode: DataServices

// Both channels required:
// Integration Mode: All
```
