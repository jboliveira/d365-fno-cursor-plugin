---
name: xpp-fno-verify
description: Verify D365 F&O X++ claims with evidence — compile clean, BP zero, SysTest pass, compatibility clean. Use when the user asks verify this, prove it works, did this fix it, or before merge validation.
disable-model-invocation: true
metadata:
  version: "1.0.0"
  platform: "D365 Finance and Operations"
---

# D365 F&O X++ Verify

Prove or disprove specific claims about F&O customizations with repeatable evidence.

## When to Apply

Invoke via `/xpp-fno-verify` when:

- User asks to verify a fix, feature, or quality gate
- Pre-merge validation beyond code review checklist
- Comparing behavior before and after a change

Do not use for vague claims ("code is cleaner"). Require a **falsifiable claim**.

## Workflow

1. **Restate claim** in falsifiable form: condition, metric, threshold.
   - Example: "CustTable extension compiles with zero BP deviations"
   - Example: "SalesTable CoC SysTest passes in CI"
2. **Pick smallest surface** that can disprove the claim.
3. **Capture baseline** (if before/after): parent commit, failing test, or pre-change repro.
4. **Capture treatment**: same command/environment on changed state.
5. **Compare artifacts**: build output, BP log, test results, compatibility report.
6. **Return exactly one verdict**: `VERIFIED`, `NOT VERIFIED`, or `INCONCLUSIVE`.

## F&O verification surfaces

| Claim type | Verification method |
|------------|---------------------|
| Compiles clean | Visual Studio build / MSBuild output |
| BP zero | Best practice check in compile output or BP pane |
| CAR clean | `xppbp.exe` with `-car` output — Issues tab empty |
| No breaking metadata | CompatibilityChecker.exe report |
| SysTest pass | Run test class in dev environment / CI |
| Performance acceptable | Trace Parser comparison (same scenario) |

See [quality-gates.md](../xpp-fno-code-review/references/quality-gates.md) for tool commands.

## Output Format

```markdown
## Claim (falsifiable)
## Baseline evidence
## Treatment evidence
## Comparison
## Verdict: VERIFIED | NOT VERIFIED | INCONCLUSIVE
## Next steps (if NOT VERIFIED)
```

## Related

- `/xpp-fno-reviewer` — qualitative 12-step audit on diff
- `/xpp-fno-code-review` — structured PR review skill
- `xpp-fno-testing` — authoring SysTests (not running them)
