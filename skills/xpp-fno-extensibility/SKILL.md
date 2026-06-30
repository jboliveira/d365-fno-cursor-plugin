---
name: xpp-fno-extensibility
description: Applies D365 F&O extension patterns including Chain of Command, ExtensionOf class augmentation, event handlers, naming guidelines, and breaking-change avoidance. Use when extending classes, tables, forms, data entities, delegates, or customizing via CoC, metadata extensions, or plug-ins in X++ finance and operations.
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

# D365 F&O Extensibility

Microsoft-aligned guidance for extending Finance and Operations without overlayering.

## When to Apply

- Implementing Chain of Command (CoC) wrappers
- Creating class, table, form, or data entity extensions
- Subscribing to framework events or delegates
- Naming new extension artifacts
- Avoiding breaking changes for downstream extenders

## Technique Priority

1. Metadata extensions
2. Chain of Command
3. Class augmentation (`[ExtensionOf]`)
4. Static extension methods (utility only)
5. Event handlers / delegates
6. Plug-ins / SysExtension

See `xpp-fno-development` hub for the full decision tree.

## Rule Categories

| Impact | Rules |
|--------|-------|
| CRITICAL | `ext-no-overlayering`, `ext-coc-next-first-level`, `ext-coc-signature-match`, `ext-class-final-extensionof` |
| HIGH | `ext-coc-form-nested-classes`, `ext-naming-publisher-prefix`, `ext-eventhandler-additive`, `ext-prefer-coc-over-delegate`, `ext-breaking-change-awareness` |
| MEDIUM | `ext-static-extension-utility-only` |

## Quick Reference

Read individual rule files in `rules/` for incorrect/correct X++ examples:

```
rules/ext-no-overlayering.md
rules/ext-coc-next-first-level.md
```

## Additional Resources

- [references/extensibility-patterns.md](references/extensibility-patterns.md) — CoC templates, Replaceable/Wrappable, LCS requests
