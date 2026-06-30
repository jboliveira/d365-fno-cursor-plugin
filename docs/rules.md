# Rules

The xpp-fno plugin ships **10 Cursor rules** (`.mdc` files) in the `rules/` folder.

## Concepts

- Rules are Markdown files with `.mdc` extension and YAML frontmatter: `description`, `globs`, `alwaysApply`.
- All xpp-fno rules use `alwaysApply: false` → **Auto Attached** when matching files are in the agent's context.
- Globs target F&O artifact paths: `**/AxClass/**`, `**/AxTable/**`, `**/AxForm/**`, `**/*.xpp`, etc.
- Rule precedence: Team Rules > Project Rules > User Rules > Plugin rules.

## Activation types

| Type | xpp-fno configuration | Behavior |
|------|-------------------------|----------|
| Auto Attached | `alwaysApply: false` + globs set | Included when matching files are in context |
| Manual | Mention `@xpp-fno-core` etc. | Force-include when working outside Ax* paths |

## Full rule catalog

| Rule file | Triggers on | Purpose |
|-----------|-------------|---------|
| `xpp-fno-core.mdc` | All Ax* globs | Non-negotiables: extensions only, labels, no do*, BP zero |
| `xpp-fno-scenario-router.mdc` | Ax* + security/menu | Scenario → technique → skill mapping table |
| `xpp-fno-extensibility.mdc` | AxClass, AxForm | CoC, ExtensionOf, events, naming |
| `xpp-fno-extensible-design.mdc` | AxClass | SOLID, method length, DRY |
| `xpp-fno-data-access.mdc` | AxTable, AxQuery, entities | forUpdate, TTS, set-based, no do-methods |
| `xpp-fno-batch-logic.mdc` | AxClass (batch/SysOp) | SysOperation, short TTS, idempotency |
| `xpp-fno-forms-ui.mdc` | AxForm | Patterns, extensions, labels |
| `xpp-fno-security.mdc` | AxSecurity*, menu items | Privilege → duty → role, XDS |
| `xpp-fno-testing.mdc` | AxClass (tests) | SysTestCase, ATL, AutoRollback |
| `xpp-fno-debugging.mdc` | AxClass | Debug discipline — reproduce before fix, minimal change, verify evidence |

## Scenario examples

From `xpp-fno-scenario-router.mdc`:

| Scenario | Recommended approach | Avoid |
|----------|---------------------|-------|
| Add field/index to standard table | Table extension + indexes in extension | Overlayering base table |
| Validate before save | CoC on `validateWrite` / `validateInsert` | Logic only in form with no CoC |
| Run logic after save | CoC on `insert`/`update`; else Pre/Post event | `doInsert`/`doUpdate`; unconditional `EventHandlerResult` |
| Replace calculation/strategy | `[Replaceable]` + CoC, or SysExtension plug-in | Copy-paste entire standard method |
| Show field on standard form | Form extension + label | Overlayer base form; hardcoded caption |
| New periodic export/process | SysOperationServiceController + contract/service | New `RunBaseBatch` for greenfield code |
| Bulk update many rows | `update_recordset` / chunked TTS | Row-by-row `while select` + `update()` in one TTS |
| Expose data to integration | Built-in entity if sufficient; custom entity for high volume | Many one-off OData endpoints |
| New menu item / action | Privilege → duty → role (least privilege) | Unsecured menu item |
| Unit test new logic | `SysTestCase` + ATL + AutoRollback | Tests on production; demo data dependency |
| Pre-release / PR | BP zero, compatibility checker, CAR, SysTest | Shipping without entry-point security |
| No extension point exists | Log LCS extensibility request early | Overlayering; fork standard code |

## Extension technique decision (quick)

1. Metadata only (field, control, property)? → **Extension artifact**
2. Wrappable method exists? → **CoC** (`next` at first level)
3. Framework Pre/Post event? → **Event handler** (additive)
4. Factory / SysExtension? → **Plug-in** (Liskov-safe)
5. None? → **LCS request** — do not overlay

## Manual invocation

When working on F&O tasks outside standard Ax* file paths (e.g. documentation, planning), mention a rule explicitly:

```text
@xpp-fno-core Apply F&O non-negotiables to this design.
```

## Rules vs skills

- **Rules** = short, file-triggered guardrails that activate while you edit Ax* files.
- **Skills** = deep reference with atomic rules, pattern guides, and Microsoft doc links.

When a rule and skill cover the same topic, the rule provides the quick check; the skill provides full BAD/GOOD examples and edge cases.

## See also

- [How it works](how-it-works.md) — component architecture
- [Skills](skills.md) — full domain reference
- [Scenario router source](../rules/xpp-fno-scenario-router.mdc) — complete scenario table
- [Workflows](workflows.md) — which rules apply per scenario
