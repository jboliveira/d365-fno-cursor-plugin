# xpp-fno Cursor Plugin — Component inventory

D365 Finance and Operations X++ plugin for Cursor (v1.1.0).

## Agents (4)

| Agent | Command | Mode | Purpose |
|-------|---------|------|---------|
| xpp-fno-planner | `/xpp-fno-planner` | readonly | Pre-implementation plan with explore |
| xpp-fno-implementer | `/xpp-fno-implementer` | read/write | Build extensions |
| xpp-fno-reviewer | `/xpp-fno-reviewer` | readonly | 12-step pre-merge audit |
| xpp-fno-debugger | `/xpp-fno-debugger` | readonly | Systematic F&O debugging |

## Commands (6)

| Command | Delegates to | Purpose |
|---------|--------------|---------|
| `/xpp-fno-plan` | xpp-fno-plan skill | In-chat planning |
| `/xpp-fno-implement` | xpp-fno-implementer agent | Build extensions |
| `/xpp-fno-review` | xpp-fno-reviewer agent | Pre-merge audit |
| `/xpp-fno-code-review` | xpp-fno-code-review skill | PR review checklist |
| `/xpp-fno-debug` | xpp-fno-debug skill (or debugger agent) | Debug workflow |
| `/xpp-fno-verify` | xpp-fno-verify skill | Evidence-based verification |

## Skills (12)

### Manual invoke (`disable-model-invocation: true`)

| Skill | Command |
|-------|---------|
| xpp-fno-plan | `/xpp-fno-plan` |
| xpp-fno-code-review | `/xpp-fno-code-review` |
| xpp-fno-debug | `/xpp-fno-debug` |
| xpp-fno-verify | `/xpp-fno-verify` |

### Auto / domain

`xpp-fno-development` (hub), `xpp-fno-extensibility`, `xpp-fno-extensible-design`, `xpp-fno-data`, `xpp-fno-business-logic`, `xpp-fno-forms-ui`, `xpp-fno-security`, `xpp-fno-testing`

## Rules (10)

`xpp-fno-core`, `xpp-fno-scenario-router`, `xpp-fno-extensibility`, `xpp-fno-extensible-design`, `xpp-fno-data-access`, `xpp-fno-batch-logic`, `xpp-fno-forms-ui`, `xpp-fno-security`, `xpp-fno-testing`, `xpp-fno-debugging`

## Hooks (4 events)

| Event | Script |
|-------|--------|
| sessionStart | xpp-fno-session-start.ps1 |
| preToolUse | xpp-fno-pre-write.ps1 |
| postToolUse | xpp-fno-post-write.ps1 |
| subagentStop | xpp-fno-subagent-stop.ps1 |

## Orchestration

1. `/xpp-fno-plan` or `/xpp-fno-planner` → plan
2. `/xpp-fno-implement` or `/xpp-fno-implementer` → build
3. `subagentStop` hook → chains `/xpp-fno-reviewer`
4. `/xpp-fno-debug` or `/xpp-fno-debugger` → investigate failures
5. `/xpp-fno-verify` → optional evidence check

## Documentation

See [README.md](README.md), [CHANGELOG.md](CHANGELOG.md), [docs/how-it-works.md](docs/how-it-works.md), and [docs/](docs/).

## Maintainer scripts

| Script | Purpose |
|--------|---------|
| `scripts/verify-plugin.ps1` | Validate manifest, counts, and structure |
| `scripts/smoke-test-hooks.ps1` | Smoke-test all 4 hook scripts |
| `scripts/sync-from-user.ps1` | Sync from `~/.cursor/` before release |
