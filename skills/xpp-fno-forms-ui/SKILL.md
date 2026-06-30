---
name: xpp-fno-forms-ui
description: Applies D365 F&O form patterns, form extensions, workspace design, and UI localization. Use when creating or extending forms, applying form patterns, building workspaces, or localizing UI labels in finance and operations X++.
paths:
  - "**/*.xpp"
  - "**/AxForm/**"
  - "**/AxClass/**"
metadata:
  version: "1.0.0"
  platform: "D365 Finance and Operations"
  sources: "Microsoft Learn F&O dev-itpro"
---

# D365 F&O Forms and UI

Form patterns and UI extension guidance.

## When to Apply

- Creating or extending forms
- Selecting form patterns (SimpleListDetails, Operational Workspace, etc.)
- Form code-behind extensions and CoC
- UI label localization

## Rules

- orm-apply-standard-pattern — use standard patterns; avoid Custom unless required
- orm-no-monster-forms — no all-in-one legacy UX forms
- orm-extension-over-overlay — form extensions + code-behind classes
- orm-operational-workspace — Operational Workspace over legacy Workspace
- orm-coc-for-methods — CoC for form/datasource/control methods
- orm-labels-localized — label files; no hardcoded UI text

## Additional Resources

- [references/form-patterns-guide.md](references/form-patterns-guide.md)
