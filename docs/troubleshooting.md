# Troubleshooting

Common problems when using the xpp-fno plugin and how to fix them.

## Skills or rules not appearing

| Cause | Fix |
|-------|-----|
| Plugin not installed | Install via `/add-plugin xpp-fno` or local path; restart Cursor |
| Duplicate user-level copies conflicting | Remove `~/.cursor/skills/xpp-fno-*`, `~/.cursor/rules/xpp-fno-*.mdc` |
| Wrong file not in context | Open or mention the Ax* file so globs match |
| Working outside Ax* paths | Manually mention skill or `@xpp-fno-core` rule |

## Hooks not firing

| Cause | Fix |
|-------|-----|
| PowerShell blocked or unavailable | Verify PowerShell runs; check execution policy |
| Cloud Agent session | Plugin hooks are local IDE only — copy hooks to project `.cursor/hooks.json` for cloud |
| Non-standard repo layout | Ensure `AxClass/`, `AxTable/`, etc. exist (direct or within depth 4) |
| Plugin not loaded | Reinstall plugin; verify `hooks/hooks.json` exists in plugin root |

## Double context injection or duplicate warnings

| Cause | Fix |
|-------|-----|
| User hooks + plugin hooks both active | Remove xpp-fno entries from `~/.cursor/hooks.json` |
| User skills + plugin skills both installed | Remove `~/.cursor/skills/xpp-fno-*` directories |

Symptoms: F&O context appears twice in session; `doUpdate` warnings repeat after every write; domain hints appear twice before each write.

## preToolUse domain hints missing or wrong

| Cause | Fix |
|-------|-----|
| `XPP_FNO_WORKSPACE` not set | Open F&O repo; restart agent session so `sessionStart` runs |
| Non-Ax* file path | Hook only fires for Ax* artifact paths — verify folder names |
| Wrong domain hint (e.g. AxTable matched as AxClass) | Update plugin — path regex uses `(^|/)AxTable/` anchors |
| Hook not running (Cloud Agent) | Copy hooks to project `.cursor/hooks.json` |

Smoke-test preToolUse — see [Hooks](hooks.md#debugging).

## Plugin verification fails

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/verify-plugin.ps1
```

| Error | Fix |
|-------|-----|
| Missing skill/rule/agent/command | Re-clone repo; ensure v1.1 checkout |
| Hook script not found | Verify `hooks/` folder and `${CURSOR_PLUGIN_ROOT}` in `hooks.json` |
| Smoke test failure | Run `scripts/smoke-test-hooks.ps1` for detailed hook errors |

## Agent paths broken

| Cause | Fix |
|-------|-----|
| Project template agents use absolute paths | Install plugin; update project agents to reference plugin or use relative paths |
| Plugin not installed but project agents reference plugin paths | Install plugin or copy agents/skills/rules into project `.cursor/` |

Plugin agents use `../skills/` and `../rules/` relative to the plugin `agents/` folder — these resolve correctly when the plugin is installed.

## Reviewer not auto-chaining after implementer

| Cause | Fix |
|-------|-----|
| Implementer did not modify Ax* files | Manually invoke `/xpp-fno-reviewer` |
| Implementer status was not `completed` | Check subagent completed successfully |
| `loop_limit: 1` already consumed | Manually invoke `/xpp-fno-reviewer` |
| Hook not running (Cloud Agent) | Use local IDE or project-level hooks |

## Wrong platform guidance (AX 2012 / Business Central)

The xpp-fno plugin scope is **D365 Finance and Operations only**.

Restate in your prompt:

```text
This is D365 F&O (not AX 2012 or Business Central). Follow xpp-fno F&O extension patterns.
```

## postToolUse warnings on legitimate code

The hook warns on any `doUpdate(`, `doInsert(`, `doDelete(` in written content — including comments or string literals.

If the warning is a false positive, verify the actual code uses `update()` / `insert()` / `delete()` and ignore the warning, or rephrase comments to avoid matching the pattern.

## Microsoft Learn MCP not available

The plugin recommends but does not bundle the Microsoft Learn MCP server.

1. Configure `user-microsoft-learn` in Cursor MCP settings.
2. Agents will use it when Microsoft guidance is unclear.
3. Without MCP, agents rely on skill reference docs and embedded Microsoft doc links.

## Sync script fails

```powershell
powershell -File scripts/sync-from-user.ps1
```

| Error | Fix |
|-------|-----|
| User Cursor directory not found | Ensure `~/.cursor/` exists with xpp-fno assets |
| Permission denied | Run from repo root; close files locked by other processes |
| Missing source skill | Verify skill exists under `~/.cursor/skills/` |

After sync, re-apply plugin-specific changes: `hooks/hooks.json` uses `${CURSOR_PLUGIN_ROOT}`; agent comments reference plugin `agents/` folder.

## Getting help

1. Check [Getting started](getting-started.md) for install verification steps.
2. Check [Hooks](hooks.md) for smoke-test commands.
3. Open an issue on the plugin GitHub repository with Cursor version, OS, and hook/agent command used.
