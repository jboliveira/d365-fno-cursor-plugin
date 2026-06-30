# Hooks

The xpp-fno plugin ships **4 lifecycle hooks** wired in `hooks/hooks.json`.

## Concepts

- Hooks run on agent lifecycle events and exchange JSON via stdin/stdout.
- Plugin hooks use `${CURSOR_PLUGIN_ROOT}` for script paths.
- **PowerShell** is required on Windows.
- Hooks are **local IDE only** — they do not run in Cloud Agents.
- Default behavior is **fail-open**: hook errors do not block the agent unless `failClosed: true` is set.

## Hook reference

| Event | Script | Matcher | Behavior |
|-------|--------|---------|----------|
| `sessionStart` | `xpp-fno-session-start.ps1` | — | If Ax* folders detected: set `XPP_FNO_WORKSPACE=1`, inject F&O context via `additional_context` |
| `preToolUse` | `xpp-fno-pre-write.ps1` | `Write\|StrReplace` | If F&O workspace + Ax* path: inject domain skill/rule hint before write |
| `postToolUse` | `xpp-fno-post-write.ps1` | `Write\|StrReplace` | If F&O workspace + Ax* path written: warn on `doUpdate()`, `doInsert()`, `doDelete()` |
| `subagentStop` | `xpp-fno-subagent-stop.ps1` | `xpp-fno-implementer` | If implementer completed and modified Ax* files: emit `followup_message` chaining to `/xpp-fno-reviewer` (`loop_limit: 1`) |

## sessionStart

**Script:** `hooks/xpp-fno-session-start.ps1`

1. Reads hook payload from stdin.
2. Detects F&O workspace via `Test-XppFnoWorkspace`.
3. If not an F&O project, exits silently (empty JSON response).
4. If detected:
   - Sets `env.XPP_FNO_WORKSPACE = '1'` for subsequent hooks in the session.
   - Returns `additional_context` with F&O stack guidance from `Get-XppFnoContextBlock`.

## preToolUse

**Script:** `hooks/xpp-fno-pre-write.ps1`

**Matcher:** `Write|StrReplace`

When F&O workspace and Ax* artifact path detected, returns `additional_context` with domain skill hint (e.g. AxTable → `xpp-fno-data`, AxClass CoC → `xpp-fno-extensibility`).

## postToolUse

**Script:** `hooks/xpp-fno-post-write.ps1`

**Matcher:** `Write|StrReplace` — only runs after file write tool calls.

1. Checks F&O workspace flag or re-detects workspace.
2. Validates the written file path matches Ax* patterns via `Test-XppFnoArtifactPath`.
3. Scans written content for `doUpdate(`, `doInsert(`, `doDelete(`.
4. If found, returns a warning in the hook response so the agent can correct before continuing.

This complements the `xpp-fno-core` rule and `xpp-fno-data` skill atomic rule `data-no-do-methods`.

## subagentStop

**Script:** `hooks/xpp-fno-subagent-stop.ps1`

**Matcher:** `xpp-fno-implementer` — only runs when the implementer subagent stops.

1. Checks subagent status is `completed`.
2. Inspects `modified_files` for Ax* artifact paths.
3. If F&O files were modified, returns:

```json
{
  "followup_message": "/xpp-fno-reviewer Review the X++ changes against the 12-step checklist..."
}
```

**`loop_limit: 1`** prevents infinite planner → implementer → reviewer loops.

## Shared library

**File:** `hooks/lib/xpp-fno-common.ps1`

| Function | Purpose |
|----------|---------|
| `Test-XppFnoWorkspace` | Detects `AxClass`, `AxTable`, `AxForm`, `AxDataEntityView`, `AxEnum`, `AxEdt`, `AxQuery` (direct or recursive depth 4) |
| `Test-XppFnoArtifactPath` | Matches `.xpp` files and Ax* folder paths |
| `Get-XppFnoContextBlock` | Builds session context text for F&O sessions |
| `Get-XppFnoDomainHint` | Maps Ax* path to domain skill/rule hint (used by preToolUse) |
| `Read-HookStdinJson` | Parses hook JSON from stdin |
| `Write-HookJson` | Writes hook JSON response to stdout |
| `Get-ProjectDirFromHook` | Extracts project directory from hook payload |

## Workspace detection

The hook checks for these folder names:

- `AxClass`
- `AxTable`
- `AxForm`
- `AxDataEntityView`
- `AxEnum`
- `AxEdt`
- `AxQuery`

Also matches `.xpp` file paths regardless of folder structure.

## Disabling hooks

- Uninstall the plugin, or
- Edit `hooks/hooks.json` in the installed plugin cache, or
- Remove duplicate user-level xpp-fno entries from `~/.cursor/hooks.json`

Do **not** run both plugin hooks and user-level xpp-fno hooks — this causes double context injection and duplicate warnings.

## Cloud Agents workaround

Plugin hooks do not run in Cloud Agents. For cloud sessions, copy hooks to your F&O project's `.cursor/hooks.json` and adjust paths to be project-relative. See [Troubleshooting](troubleshooting.md).

## Debugging

### Check workspace flag

In a PowerShell terminal during an agent session:

```powershell
$env:XPP_FNO_WORKSPACE
```

Should be `1` when sessionStart detected an F&O workspace.

### Smoke-test sessionStart

```powershell
'{"project_dir":"C:\\path\\to\\your\\fno\\repo"}' |
  powershell -NoProfile -ExecutionPolicy Bypass -File hooks/xpp-fno-session-start.ps1
```

Expect JSON with `additional_context` when the repo contains Ax* folders.

### Smoke-test postWrite

```powershell
'{"tool_input":{"path":"AxClass/MyClass.xpp","new_string":"t.doUpdate();"}}' |
  powershell -NoProfile -ExecutionPolicy Bypass -File hooks/xpp-fno-post-write.ps1
```

Expect a warning about `doUpdate()` when `XPP_FNO_WORKSPACE=1` or workspace is detected.

### Smoke-test preToolUse

```powershell
$env:XPP_FNO_WORKSPACE = '1'
'{"tool_input":{"path":"AxTable/CustTable.MyPublisher.xpp","new_string":"// test"}}' |
  powershell -NoProfile -ExecutionPolicy Bypass -File hooks/xpp-fno-pre-write.ps1
```

Expect JSON with `additional_context` containing a domain hint (e.g. `xpp-fno-data` for AxTable paths).

Run the full hook smoke suite:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/smoke-test-hooks.ps1
```

### Execution policy

If hooks fail silently, verify PowerShell allows script execution:

```powershell
Get-ExecutionPolicy -Scope CurrentUser
```

The hook command uses `-ExecutionPolicy Bypass` for the script invocation, but the shell must be able to launch PowerShell.

## See also

- [Agents](agents.md) — implementer → reviewer chaining
- [Troubleshooting](troubleshooting.md) — hooks not firing
- [Getting started](getting-started.md) — first session behavior
