# Debugging

Systematic debugging for D365 F&O X++ using the xpp-fno plugin.

## When to use what

| Situation | Start with |
|-----------|------------|
| Unknown failure, need root cause | `/xpp-fno-debug` or `/xpp-fno-debugger` |
| CoC not firing / wrong order | Debug skill — CoC chain phase |
| Batch job failed | Debug skill — BatchJobHistory phase |
| Slow after deploy | Trace Parser + debug skill |
| After platform upgrade | Compatibility checker + debug skill |

## Components

| Component | Purpose |
|-----------|---------|
| Skill `xpp-fno-debug` | Structured triage → investigate → root cause → optional fix |
| Agent `xpp-fno-debugger` | Isolated readonly subagent with explore/bash |
| Rule `xpp-fno-debugging.mdc` | Auto-attaches on AxClass edits during debug sessions |
| Command `/xpp-fno-debug` | Slash entry point to debug workflow |

## CoC chain debugging

Common causes when extensions "don't run":

1. `next` inside `if`/`while`/`for` instead of first method level
2. Signature mismatch with base method
3. Wrong `[ExtensionOf]` target class or table
4. Competing extension in another publisher model (order)

The `postToolUse` hook warns when written content may violate CoC `next` placement.

## Infolog and exceptions

- Read full Infolog text — first message is not always root cause
- CLRError and some exceptions require explicit Infolog surfacing
- See atomic rule `logic-infolog-messaging` in `xpp-fno-business-logic`

## Batch debugging

1. Find batch job in **Batch job history**
2. Open Infolog for failed execution
3. Verify SysOperation contract parameters
4. Check TTS scope — long transactions cause timeouts and blocking

## Performance debugging

1. Reproduce with Trace Parser (PerfSDK)
2. Look for N+1 queries, missing indexes, row-by-row updates
3. Cross-check `xpp-fno-data` set-based rules and `xpp-fno-business-logic` performance checklist

## Upgrade regressions

Run compatibility checker comparing baseline package to current metadata. Review breaking change report before blaming application logic.

## Handoff to implementer

When fix requires multiple artifacts (table + form + security + test), complete root-cause analysis then invoke `/xpp-fno-implementer` with findings.

## See also

- [Skills — xpp-fno-debug](skills.md)
- [Agents — xpp-fno-debugger](agents.md)
- [Workflows](workflows.md)
