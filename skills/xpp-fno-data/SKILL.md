---
name: xpp-fno-data
description: Applies D365 F&O data model and X++ data access best practices including transactions, forUpdate, set-based operations, indexes, and data entities. Use when designing tables, EDTs, enums, queries, data entities, or writing select/insert/update/delete in X++ finance and operations.
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

# D365 F&O Data

Metadata modeling and X++ data access following Microsoft guidance.

## When to Apply

- Designing tables, indexes, delete actions, EDTs, enums
- Writing select, insert, update, delete operations
- Bulk operations and transaction scope
- Data entity design for integration

## Rule Categories

| Area | Rules |
|------|-------|
| Metadata | data-normalize-no-redundancy, data-define-indexes, data-effective-date-framework, data-entity-purpose-fit, data-extensible-enums-edts |
| Access | data-forupdate-before-mutate, data-tts-same-scope, data-no-do-methods, data-set-based-bulk, data-join-over-n-plus-one, data-index-hint-caution, data-throw-aborts-transaction |

## Additional Resources

- [references/data-model-patterns.md](references/data-model-patterns.md)
- [references/data-access-patterns.md](references/data-access-patterns.md)
