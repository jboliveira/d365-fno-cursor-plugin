---
title: Apply Standard Form Pattern
impact: CRITICAL
impactDescription: Patterns ensure performance, responsiveness, and consistency
tags: forms, patterns, ui
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/user-interface/form-styles-patterns
---

## Apply Standard Form Pattern

Apply pattern via metadata/designer; avoid Custom unless required.

**Incorrect:**
```xpp
// Form design metadata (anti-pattern)
// Pattern: Custom
// Manual grid + tab layout without responsive subpatterns
// No pattern validation; fights platform defaults
```

**Correct:**
```xpp
// Form design metadata
// Pattern: SimpleListDetails (or DetailsFormTransaction, Operational Workspace)
// Apply pattern from catalog via designer Right-click > Apply pattern
// Subpatterns auto-generated for responsive layout
```
