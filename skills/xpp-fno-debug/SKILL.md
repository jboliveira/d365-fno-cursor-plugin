---
name: xpp-fno-debug
description: Systematically debug D365 F&O X++ issues — Infolog errors, CoC chain breaks, batch failures, upgrade regressions, and performance. Use when debugging errors, investigating test failures, tracing batch jobs, or when the user says debug this, why is this failing, or pastes F&O stack traces.
disable-model-invocation: true
metadata:
  version: "1.0.0"
  platform: "D365 Finance and Operations"
---

# D365 F&O X++ Debug

Systematic root-cause investigation for Dynamics 365 Finance and Operations X++ (not AX 2012 or Business Central).

## When to Apply

Invoke via `/xpp-fno-debug` or `/xpp-fno-debugger` when:

- Infolog shows unexpected errors during save, post, or batch
- CoC extension does not run or runs in wrong order
- Batch or SysOperation job fails or hangs
- Behavior changed after platform update or package deploy
- Performance regression (slow form, batch, or query)

## Core Principles

1. **Investigate before fixing** — explain the causal chain from trigger to symptom.
2. **One hypothesis at a time** — change one thing, re-test.
3. **Reproduce in sandbox** — never debug on production.
4. **Defer multi-artifact fixes** to `/xpp-fno-implementer` after root cause is confirmed.

## Workflow

### Phase 0 — Triage

Extract from user input:

- Symptom (what fails, when)
- Expected vs actual behavior
- Environment (PU version, model, batch job ID if applicable)
- Recent changes (deploy, upgrade, new extension)

Classify symptom:

| Symptom type | First check |
|--------------|-------------|
| Save/validate error | Infolog + CoC on validateWrite/validateInsert |
| Extension not firing | CoC `next` placement, ExtensionOf target, method wrappable |
| Batch failure | Batch job history, Infolog, TTS scope |
| Post-upgrade regression | Compatibility checker vs baseline |
| Slow operation | Trace Parser, set-based vs row-by-row |

### Phase 1 — Investigate

1. **Infolog** — Read full message; surface CLRError via `Global::error` patterns (see `xpp-fno-business-logic` Infolog rule).
2. **CoC chain** — Verify `[ExtensionOf]` target, signature match, unconditional `next` at first method level. Search for competing extensions in same model.
3. **Batch** — Inspect `BatchJobHistory`, job status, batch log, parameter contract values.
4. **Data** — Check `forUpdate` before mutate, TTS scope, `doUpdate`/`doInsert` bypassing chain.
5. **Repo** — Use explore to find related extensions, event handlers, and standard method being wrapped.

### Phase 2 — Root Cause

Form hypotheses and test each:

- Missing or conditional `next` in CoC
- Wrong table buffer (no `forUpdate`)
- Event handler unconditionally sets `EventHandlerResult`
- Metadata breaking change after upgrade
- Long TTS or row-by-row loop in batch

Use **compatibility checker** when upgrade is suspected. Use **Trace Parser** for SQL/performance.

### Phase 3 — Fix (optional)

Only if user requests a fix:

1. Propose minimal change aligned with `xpp-fno-extensibility` and `xpp-fno-data` rules.
2. Add or update SysTest to prevent regression (`xpp-fno-testing`).
3. For multi-file changes, hand off to `/xpp-fno-implementer` with root-cause summary.

## Output Format

```markdown
## Symptom
## Reproduction steps
## Investigation findings
## Root cause (causal chain)
## Recommended fix
## Verification steps
```

## References

- [references/debug-checklist.md](references/debug-checklist.md)
- Domain skills: `xpp-fno-extensibility`, `xpp-fno-data`, `xpp-fno-business-logic`
- Quality gates: `xpp-fno-code-review/references/quality-gates.md` (Trace Parser, compatibility checker)
