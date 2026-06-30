# Getting started

First-time setup for the **xpp-fno** Cursor plugin (v1.1).

## Prerequisites

| Requirement | Notes |
|-------------|-------|
| Cursor IDE | Agent mode enabled |
| D365 F&O X++ project | Contains `AxClass/`, `AxTable/`, `AxForm/`, or similar AOT folders |
| PowerShell (Windows) | Required for hooks in local IDE sessions |
| Microsoft Learn MCP (optional) | Configure `user-microsoft-learn` for official F&O documentation lookups |

## Install

### From marketplace (after publish)

In Cursor Agent chat:

```text
/add-plugin xpp-fno
```

### From local clone

1. Clone this repository to your machine.
2. Install the plugin from the repo root using Cursor's plugin install flow.
3. Open or restart Cursor and start a new agent session.

### Test locally before publish (recommended)

Per [Cursor plugin docs](https://cursor.com/docs/plugins), load the plugin from a local folder before submitting to the marketplace:

**Windows (PowerShell):**

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.cursor\plugins\local"
New-Item -ItemType SymbolicLink -Force `
  -Path "$env:USERPROFILE\.cursor\plugins\local\xpp-fno" `
  -Target "C:\path\to\d365-fno-cursor-plugin"
```

**macOS / Linux:**

```bash
mkdir -p ~/.cursor/plugins/local
ln -sf /path/to/d365-fno-cursor-plugin ~/.cursor/plugins/local/xpp-fno
```

Then restart Cursor (or run **Developer: Reload Window**) and verify rules, skills, agents, and commands load in Customize.

For faster iteration, keep the symlink in place while you edit the repo.

### Verify install

Run the bundled verification script from the plugin repo:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/verify-plugin.ps1
```

Manual checks:

- Type `/` in Agent chat — you should see all **6 commands** (`/xpp-fno-plan`, `/xpp-fno-implement`, `/xpp-fno-review`, `/xpp-fno-code-review`, `/xpp-fno-debug`, `/xpp-fno-verify`) and **4 agents** (`/xpp-fno-planner`, `/xpp-fno-implementer`, `/xpp-fno-reviewer`, `/xpp-fno-debugger`).
- Open an F&O repo with `AxClass/` or `AxTable/` folders — the `sessionStart` hook sets `XPP_FNO_WORKSPACE=1` and injects F&O context.
- Edit an `AxClass/*.xpp` file — domain rules auto-attach; `preToolUse` injects a domain skill hint before writes.

## Project setup

Use any D365 F&O extension repository, or start from [d365-fno-cursor-template](../README.md#project-template).

Conventions:

- Use your **publisher prefix** on all new artifacts (classes, tables, forms, labels).
- Keep customizations in your ISV/custom model — never overlayer Microsoft sealed models.
- Organize metadata under standard AOT folders (`AxClass/`, `AxTable/`, etc.).

## First session

When you open a workspace containing F&O artifacts:

1. The `sessionStart` hook runs `xpp-fno-session-start.ps1`.
2. If `AxClass/`, `AxTable/`, `AxForm/`, `AxDataEntityView/`, `AxEnum/`, `AxEdt/`, or `AxQuery/` is detected, the hook:
   - Sets environment variable `XPP_FNO_WORKSPACE=1`
   - Injects an F&O context block via `additional_context`
3. Subsequent hooks (`preToolUse`, `postToolUse`, `subagentStop`) use this flag for faster workspace detection.

If your project uses non-standard folder layout, hooks may not activate until standard Ax* paths are present.

## Component layers

Five complementary layers — see [How it works](how-it-works.md) for the full architecture:

| Layer | When it applies | Depth |
|-------|-----------------|-------|
| **Rules** | Automatically when Ax* files are in context | Concise guardrails with BAD/GOOD examples |
| **Skills** | On invocation or when the agent selects by description | Deep Microsoft-aligned reference (59+ atomic rules) |
| **Agents** | Multi-step workflows via `/agent-name` | Isolated subagents with explore/bash access |
| **Commands** | Slash menu entry points (`/xpp-fno-*`) | Delegates to skills or agents for discoverability |
| **Hooks** | Lifecycle events (session start, pre/post write, subagent stop) | Automated context injection and workflow chaining |

**Rules** catch mistakes while you edit. **Skills** teach Microsoft patterns. **Agents** orchestrate planning, implementation, review, and debugging. **Commands** make workflows discoverable in the `/` menu. **Hooks** automate session setup, write hints, and post-implementer review.

## Choosing an entry point

| Situation | Start with |
|-----------|------------|
| Ad-hoc edit to an existing Ax* file | Rules auto-attach; hooks inject domain hints on write |
| New multi-artifact feature | `/xpp-fno-plan` or `/xpp-fno-planner` |
| Ready to implement from a plan | `/xpp-fno-implement` or `/xpp-fno-implementer` |
| Something broke at runtime | `/xpp-fno-debug` or `/xpp-fno-debugger` |
| Prove fix compiles and tests pass | `/xpp-fno-verify` |
| Pre-merge or PR review | `/xpp-fno-review`, `/xpp-fno-reviewer`, or `/xpp-fno-code-review` |
| Unclear which technique to use | Hub skill `xpp-fno-development` or rule `xpp-fno-scenario-router` |

## Coexistence / migration

If you previously installed xpp-fno assets at user level (`~/.cursor/`), remove duplicates after installing this plugin:

| User-level path | Action |
|-----------------|--------|
| `~/.cursor/skills/xpp-fno-*` | Remove directories (plugin provides copies) |
| `~/.cursor/rules/xpp-fno-*.mdc` | Remove files |
| `~/.cursor/agents/xpp-fno-*.md` | Remove files |
| `~/.cursor/hooks.json` (xpp-fno entries) | Remove xpp-fno hook blocks |

Keeping both causes double context injection, duplicate skills, and hooks firing twice.

## Next steps

- [How it works](how-it-works.md) — full component architecture
- [Commands](commands.md) — slash command reference
- [Skills guide](skills.md) — full catalog and extension decision tree
- [Agents guide](agents.md) — planner → implementer → reviewer → debugger
- [Workflows](workflows.md) — copy-paste examples for common scenarios
