---
name: xpp-fno-plan
description: Create structured D365 F&O X++ implementation plans before coding — artifacts, extension technique, quality gates, risks. Use when the user says plan this, create a plan, or before multi-artifact X++ work. Complements xpp-fno-planner agent for in-chat planning.
disable-model-invocation: true
metadata:
  version: "1.0.0"
  platform: "D365 Finance and Operations"
---

# D365 F&O X++ Plan

Structured pre-implementation planning for **Dynamics 365 Finance and Operations** (not AX 2012 or Business Central).

## When to Apply

Invoke via `/xpp-fno-plan` when:

- Starting multi-artifact work (table + form + security + test)
- Extension technique choice is unclear
- User wants a plan document before `/xpp-fno-implementer`

For isolated subagent planning with repo exploration, use `/xpp-fno-planner` instead.

## Planning workflow

1. Clarify requirement and affected standard artifacts.
2. Apply extension decision tree from `xpp-fno-development` hub skill.
3. Apply scenario router (`xpp-fno-scenario-router` rule).
4. Identify artifacts, technique per artifact, and quality gates.
5. List risks: breaking changes, missing extension points, security gaps.

## Extension technique (apply in order)

1. Metadata extension only? → Table/Form/EDT/Enum extension
2. CoC-wrappable method? → Chain of Command (`next` at first level)
3. Framework Pre/Post event? → Event handler (additive only)
4. Plug-in / SysExtension? → Factory pattern
5. None of the above? → LCS extensibility request — **never overlayer**

## Output format

```markdown
## Requirement summary
## Recommended artifacts
| Artifact | Type | Technique | Notes |
## Quality gates
- BP zero, compatibility checker, CAR (as applicable)
- Security: privilege → duty → role for new entry points
- SysTest for new business rules
## Risks (breaking changes, missing extension points, security)
## Next step
Invoke `/xpp-fno-implementer` with this plan.
```

## Rules

- **Planning only** — do not edit files in this skill workflow unless user explicitly asks to save plan to a file.
- Use repo-relative paths in artifact tables.
- Defer execution-time unknowns to implementer.

## References

- Hub: `xpp-fno-development`
- Scenario router: `xpp-fno-scenario-router`
- Agent alternative: `/xpp-fno-planner` (readonly subagent with explore)
