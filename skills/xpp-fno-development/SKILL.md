---
name: xpp-fno-development
description: Routes D365 Finance and Operations X++ development tasks to specialized skills. Use when writing, reviewing, extending, or refactoring X++ code, AOT metadata, tables, forms, classes, batch jobs, security, or tests in Dynamics 365 F&O.
metadata:
  version: "1.0.0"
  platform: "D365 Finance and Operations"
  sources: "Microsoft Learn F&O dev-itpro"
---

# D365 F&O X++ Development Hub

Entry point for Microsoft-aligned X++ development in Dynamics 365 Finance and Operations.

## When to Apply

- Writing or refactoring X++ business logic, metadata, or extensions
- Choosing an extension technique (CoC, events, metadata)
- Routing work to the correct domain skill
- Enforcing universal F&O quality pillars before check-in

## Component Router

| Task area | Skill |
|-----------|-------|
| Chain of Command, ExtensionOf, events, naming | `xpp-fno-extensibility` |
| SOLID, clean code, extensible methods/classes | `xpp-fno-extensible-design` |
| Tables, EDTs, enums, queries, entities, CRUD, TTS | `xpp-fno-data` |
| Classes, batch, SysOperation, performance, exceptions | `xpp-fno-business-logic` |
| Form patterns, form extensions, UI labels | `xpp-fno-forms-ui` |
| Roles, duties, privileges, XDS, entry points | `xpp-fno-security` |
| SysTest, ATL, test isolation | `xpp-fno-testing` |
| PR review, BP, CAR, compatibility checker | `/xpp-fno-code-review` |
| Pre-implementation planning | `/xpp-fno-plan` or `/xpp-fno-planner` |
| Systematic debugging | `/xpp-fno-debug` or `/xpp-fno-debugger` |
| Post-change verification | `/xpp-fno-verify` |

## Extension Decision Tree

1. **Metadata extension only?** → Table/Form/EDT/Enum extension (naming guidelines, publisher prefix)
2. **CoC-wrappable method exists?** → Chain of Command via `[ExtensionOf]` class; call `next` at first level
3. **Framework event or delegate?** → Event handler (additive only; never unconditionally set `EventHandlerResult`)
4. **Plug-in or SysExtension point?** → Factory pattern; Liskov substitution
5. **None of the above?** → Log extensibility request in LCS

**Never overlayer.** Product models are sealed; use extensions only.

**Prefer CoC over delegates** when Microsoft exposes extracted methods (since PU 7.3).

## Universal Non-Negotiables

- Extensions only — no overlayering
- Zero best-practice deviation target
- Labels for all user-facing text (`@LabelId`); no hardcoded strings
- Use `update()` / `insert()` / `delete()` — not `doUpdate()` / `doInsert()` / `doDelete()`
- Run compatibility checker before promoting packages
- Unit-test before check-in (SysTest + ATL)

## Quality Gates (Cross-Cutting)

Enforced in `/xpp-fno-code-review`:

1. Best practice check — zero deviations
2. Compatibility checker — metadata breaking changes
3. CAR — `xppbp.exe` customization analysis
4. Trace Parser — runtime performance
5. Breaking changes awareness
6. Unit testing
7. LCS extensibility requests for missing extension points

## Microsoft Documentation

See [references/microsoft-docs-index.md](references/microsoft-docs-index.md) for canonical Learn links.
