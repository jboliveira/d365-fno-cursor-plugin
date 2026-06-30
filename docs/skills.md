# Skills

The xpp-fno plugin ships **12 skills** with **59+ atomic rules** under `skills/xpp-fno-*/rules/`.

## Concepts

- Skills follow the open **SKILL.md** standard (`name` + `description` in YAML frontmatter).
- At startup, Cursor loads only skill names and descriptions; full content is injected on invocation.
- **Hub-and-spoke model:** start at `xpp-fno-development`, route to domain skills.
- **Atomic rules** live under `skills/xpp-fno-*/rules/*.md` — granular BAD/GOOD examples.
- **References** live under `skills/xpp-fno-*/references/` — pattern guides and checklists.

## Skills vs rules

| | Skills | Rules |
|---|--------|-------|
| Format | `SKILL.md` + rules/ + references/ | `.mdc` with globs |
| Activation | Agent selects by description or manual invoke | Auto-attached when matching files in context |
| Depth | Full Microsoft-aligned guidance | Concise guardrails distilled from skills |

## Full skill catalog

| Skill | Invoke | When to use | Atomic rules | Key references |
|-------|--------|-------------|--------------|----------------|
| `xpp-fno-development` | Auto / mention | Hub router, extension decision tree, quality gates | — | `microsoft-docs-index.md` |
| `xpp-fno-extensibility` | Auto / mention | CoC, ExtensionOf, events, plugins, naming | 10 | `extensibility-patterns.md` |
| `xpp-fno-extensible-design` | Auto / mention | SOLID, clean code, method design | 8 | — |
| `xpp-fno-data` | Auto / mention | Tables, CRUD, TTS, entities, set-based ops | 12 | `data-access-patterns.md`, `data-model-patterns.md` |
| `xpp-fno-business-logic` | Auto / mention | Batch, SysOperation, performance, exceptions | 11 | `batch-sysoperation-patterns.md`, `performance-checklist.md` |
| `xpp-fno-forms-ui` | Auto / mention | Form patterns, extensions, labels | 6 | `form-patterns-guide.md` |
| `xpp-fno-security` | Auto / mention | RBAC, entry points, XDS, entities | 7 | `security-patterns.md` |
| `xpp-fno-testing` | Auto / mention | SysTest, ATL, isolation | 5 | `testing-patterns.md` |
| `xpp-fno-code-review` | `/xpp-fno-code-review` only | PR / pre-merge audit | — | `review-checklist.md`, `quality-gates.md`, `examples.md` |
| `xpp-fno-plan` | `/xpp-fno-plan` only | Structured in-chat planning | — | — |
| `xpp-fno-debug` | `/xpp-fno-debug` only | Systematic F&O debugging | — | `debug-checklist.md` |
| `xpp-fno-verify` | `/xpp-fno-verify` only | Evidence-based verification | — | `quality-gates.md` |

`xpp-fno-code-review`, `xpp-fno-plan`, `xpp-fno-debug`, and `xpp-fno-verify` have `disable-model-invocation: true` — invoke explicitly.

## Extension decision tree

From the hub skill — apply in order:

1. **Metadata extension only?** → Table/Form/EDT/Enum extension (naming guidelines, publisher prefix)
2. **CoC-wrappable method exists?** → Chain of Command via `[ExtensionOf]` class; call `next` at first level
3. **Framework Pre/Post event?** → Event handler (additive only; never unconditionally set `EventHandlerResult`)
4. **Plug-in or SysExtension point?** → Factory pattern; Liskov substitution
5. **None of the above?** → Log extensibility request in LCS — **never overlayer**

Prefer CoC over delegates when Microsoft exposes extracted methods (since PU 7.3).

## Component router

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
| Pre-implementation planning | `/xpp-fno-plan` |
| Runtime failure, Infolog, batch errors | `/xpp-fno-debug` |
| Compile/BP/SysTest evidence check | `/xpp-fno-verify` |

## Example invocations

**Add a field to CustTable**

The agent should load `xpp-fno-data` + `xpp-fno-extensibility`. Technique: table extension, not overlay.

**Review my CoC class**

Use `/xpp-fno-code-review` for a structured single-turn review, or `/xpp-fno-reviewer` for an isolated subagent with git diff access.

**Security for a new menu item**

Mention security or invoke implementer — loads `xpp-fno-security`. Follow privilege → duty → role pattern.

**Manual skill mention**

Reference a skill by name in chat (e.g. "follow xpp-fno-data rules") or use `@` mentions when supported.

## Universal non-negotiables (all skills)

- Extensions only — no overlayering
- Publisher prefix on new artifacts
- Labels (`@LabelId`) — no hardcoded user-facing strings
- Use `update()` / `insert()` / `delete()` — not `doUpdate()` / `doInsert()` / `doDelete()`
- Target zero BP deviations; run compatibility checker before release
- Unit-test before check-in (SysTest + ATL)

## Quality gates

Enforced in `/xpp-fno-code-review` and the reviewer agent:

1. Best practice check — zero deviations
2. Compatibility checker — metadata breaking changes
3. CAR — customization analysis
4. Trace Parser — runtime performance (when applicable)
5. Breaking changes awareness
6. Unit testing
7. LCS extensibility requests for missing extension points

## See also

- [How it works](how-it-works.md) — skills vs rules vs agents vs commands
- [Commands](commands.md) — slash command entry points
- [Rules](rules.md) — file-triggered guardrails
- [Agents](agents.md) — which skills each agent loads
- [Workflows](workflows.md) — end-to-end examples
