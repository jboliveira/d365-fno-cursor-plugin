---
name: xpp-fno-extensible-design
description: Applies SOLID principles, clean code, and DRY patterns for extensible X++ in D365 F&O. Use when designing classes, methods, forms, tables, EDTs, enums, or delegates for extension; refactoring switch/while/if blocks; or minimizing extension surface in finance and operations.
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

# D365 F&O Extensible Design

Write code that extenders can safely customize following Microsoft SOLID guidance.

## When to Apply

- Designing new classes, methods, or extension points
- Refactoring long methods, switch blocks, or nested if/while
- Applying SOLID, clean code, or DRY in X++
- Reviewing extension surface (public vs protected vs private)

## Rule Categories

| Impact | Rules |
|--------|-------|
| CRITICAL | design-single-responsibility, design-minimize-extension-surface, design-dry-no-duplicate-logic |
| HIGH | design-liskov-replaceable, design-extract-switch-default, design-extract-while-if-blocks |
| MEDIUM | design-dependency-inversion, design-parm-accessors |

## Additional Resources

- [references/solid-xpp-mapping.md](references/solid-xpp-mapping.md)
- [references/artifact-extensibility-guides.md](references/artifact-extensibility-guides.md)
