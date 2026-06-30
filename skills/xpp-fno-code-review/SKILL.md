---
name: xpp-fno-code-review
description: Reviews D365 F&O X++ and metadata changes against Microsoft best practices, BP zero-deviation, CAR, compatibility checker, security, and SysTest coverage. Use when reviewing pull requests, pre-merge validation, or auditing X++ finance and operations customizations.
disable-model-invocation: true
metadata:
  version: "1.0.0"
  platform: "D365 Finance and Operations"
  sources: "Microsoft Learn F&O dev-itpro"
---

# D365 F&O Code Review

Structured review workflow for X++ and metadata changes.

## When to Apply

Invoke via `/xpp-fno-code-review` for PR reviews, pre-merge checks, or audit requests.

## Review Workflow (12 Steps)

Copy this checklist and track progress:

```
Review Progress:
- [ ] 1. Extension model — extensions only; CoC > events > plugins
- [ ] 2. CoC correctness — next, signatures, form nested classes
- [ ] 3. Extensible design — SOLID, method length, DRY, extension surface
- [ ] 4. Data integrity — forUpdate, TTS scope, no do-methods
- [ ] 5. Data model — indexes, delete actions, no redundancy
- [ ] 6. Performance — set-based ops, joins, batch idempotency
- [ ] 7. Forms — pattern applied; responsive layout
- [ ] 8. Labels — no hardcoded user-facing literals
- [ ] 9. Security — entry-point permissions; least-privilege; XDS
- [ ] 10. Testing — SysTest coverage; isolation; data-agnostic
- [ ] 11. Breaking changes — compatibility checker categories
- [ ] 12. Quality gates — zero BP deviations; CAR clean; trace hot paths
```

## Output Format

Structure feedback as:

**Critical** — Must fix before merge (overlayering, missing forUpdate, unsecured entry points, doUpdate usage)

**Suggestion** — Should improve (method length, missing tests, suboptimal pattern choice)

**Nice to have** — Optional enhancement (naming polish, additional trace validation)

## Domain Skill References

| Area | Skill / rules |
|------|---------------|
| Extensibility | `xpp-fno-extensibility/rules/` |
| Design | `xpp-fno-extensible-design/rules/` |
| Data | `xpp-fno-data/rules/` |
| Business logic | `xpp-fno-business-logic/rules/` |
| Forms | `xpp-fno-forms-ui/rules/` |
| Security | `xpp-fno-security/rules/` |
| Testing | `xpp-fno-testing/rules/` |

## Additional Resources

- [references/review-checklist.md](references/review-checklist.md)
- [references/quality-gates.md](references/quality-gates.md)
- [examples.md](examples.md)
