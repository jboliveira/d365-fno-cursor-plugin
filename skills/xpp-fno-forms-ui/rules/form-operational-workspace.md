---
title: Operational Workspace Pattern
impact: HIGH
impactDescription: Legacy Workspace pattern is deprecated; Operational Workspace is preferred
tags: forms, workspace, patterns
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/user-interface/select-form-pattern
---

## Operational Workspace Pattern

Use Operational Workspace, not legacy Workspace.

**Incorrect:**
```xpp
// New workspace form design
// Pattern: Workspace (legacy — marked for removal)
// Uses deprecated workspace sections without performance subpatterns
```

**Correct:**
```xpp
// New workspace form design
// Pattern: Operational Workspace
// Performance-enhanced sections, tabbed list, summary tiles per Microsoft catalog
// Right-click form root > Apply pattern > Operational Workspace
```
