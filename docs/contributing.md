# Contributing

How to maintain and release the xpp-fno Cursor plugin.

## Development workflow

The canonical source for day-to-day edits may live at user level (`~/.cursor/`) during active development. Before each release, sync into the plugin repo:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/sync-from-user.ps1
```

Run from the repo root. The script copies:

- `~/.cursor/skills/xpp-fno-*` → `skills/`
- `~/.cursor/rules/xpp-fno-*.mdc` → `rules/`
- `~/.cursor/agents/xpp-fno-*.md` → `agents/`
- `~/.cursor/hooks/xpp-fno-*.ps1` + `hooks/lib/xpp-fno-common.ps1` → `hooks/`

## After sync: re-apply plugin-specific files

The sync script overwrites hook scripts and agents. Re-verify these plugin-only artifacts:

| File | Plugin-specific setting |
|------|-------------------------|
| `hooks/hooks.json` | Uses `${CURSOR_PLUGIN_ROOT}` paths — do not overwrite with user `~/.cursor/hooks.json` |
| `agents/*.md` | Location comment should say "plugin `agents/` folder" |
| `hooks/*.ps1` | Header comments should say "(xpp-fno plugin)" |
| `.cursor-plugin/plugin.json` | Version bump on release |

## Version bump

Update version in both:

- `.cursor-plugin/plugin.json` → `"version"`
- `.cursor-plugin/marketplace.json` → `metadata.version`

Follow semver: patch for fixes, minor for new skills/rules, major for breaking renames.

## Release checklist

Before tagging a release:

- [ ] Run `scripts/verify-plugin.ps1` — must exit 0 (structure, frontmatter, logo path, path safety)
- [ ] Run `scripts/smoke-test-hooks.ps1` — must exit 0
- [ ] Test locally via `~/.cursor/plugins/local/xpp-fno` symlink (see [Getting started — Test locally](getting-started.md#test-locally-before-publish-recommended))
- [ ] Confirm `plugin.json` logo points to `assets/logo-padded.svg` (marketplace tile padding)
- [ ] Confirm `plugin.json` paths exist: `./skills/`, `./agents/`, `./rules/`, `./commands/`, `./hooks/hooks.json`
- [ ] Update README, CHANGELOG, and docs if new components were added
- [ ] Commit and tag (e.g. `v1.1.0`)

The verify script checks:

- Inventory counts (12 skills, 10 rules, 4 agents, 6 commands)
- `plugin.json` name (kebab-case) and relative paths (no `..` or absolute paths)
- Logo file exists at manifest path
- Skill `name` matches folder name; skill/agent/command frontmatter
- Rule `.mdc` frontmatter (`description`, `alwaysApply`)
- `hooks/hooks.json` version and required events

## Inventory verification

Quick counts from repo root:

```powershell
(Get-ChildItem skills -Directory).Count           # expect 12
(Get-ChildItem rules -Filter 'xpp-fno-*.mdc').Count  # expect 10
(Get-ChildItem agents -Filter 'xpp-fno-*.md').Count  # expect 4
(Get-ChildItem commands -Filter 'xpp-fno-*.md').Count # expect 6
powershell -File scripts/verify-plugin.ps1
powershell -File scripts/smoke-test-hooks.ps1
```

Atomic rules count:

```powershell
(Get-ChildItem skills -Recurse -Filter '*.md' |
  Where-Object { $_.DirectoryName -match '\\rules$' }).Count  # expect 59
```

## Adding a new skill

1. Create skill under `~/.cursor/skills/xpp-fno-<domain>/` with `SKILL.md`, optional `rules/` and `references/`.
2. Add routing entry in `xpp-fno-development` hub skill.
3. Create matching `.mdc` rule in `~/.cursor/rules/` if file-triggered guardrails are needed.
4. Update implementer agent domain table if the skill maps to artifact types.
5. Sync, update docs (`docs/skills.md`, `docs/rules.md`), bump version.

## Adding a new agent

1. Create agent markdown in `agents/` with frontmatter (`name`, `description`, `model`, `readonly`).
2. Use `../skills/` and `../rules/` for relative paths.
3. Register in `plugin.json` (automatic when file is in `agents/` folder).
4. Update `docs/agents.md` and README invoke table.

## Adding a new hook

1. Add script under `hooks/`.
2. Wire in `hooks/hooks.json` with `${CURSOR_PLUGIN_ROOT}` path.
3. Add shared helpers to `hooks/lib/xpp-fno-common.ps1` if needed.
4. Document in `docs/hooks.md`; smoke-test with piped JSON.
5. Sync to [d365-fno-cursor-template](https://github.com/jboliveira/d365-fno-cursor-template): run `scripts/sync-hooks-from-plugin.ps1` in the template repo (sibling plugin path by default).

## Cursor marketplace publish

Official reference: [Plugins reference — Submitting a plugin](https://cursor.com/docs/reference/plugins#submitting-a-plugin)

### Pre-submit validation

From repo root:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/verify-plugin.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/smoke-test-hooks.ps1
```

Test the plugin locally via symlink — see [Getting started — Test locally before publish](getting-started.md#test-locally-before-publish-recommended).

### Submission checklist

- [ ] Valid [`.cursor-plugin/plugin.json`](../.cursor-plugin/plugin.json) with unique kebab-case `name`
- [ ] Clear `description` in manifest
- [ ] All rules, skills, agents, and commands have proper YAML frontmatter (verified by `verify-plugin.ps1`)
- [ ] Logo committed at `assets/logo-padded.svg` and referenced in `plugin.json`
- [ ] [`README.md`](../README.md) documents usage and configuration
- [ ] All manifest paths are relative (no `..`, no absolute paths)
- [ ] Plugin tested locally in Cursor via `~/.cursor/plugins/local/`
- [ ] Repository is public and open source ([`LICENSE`](../LICENSE))

### Submit

1. Push repo to GitHub.
2. Submit at [cursor.com/marketplace/publish](https://cursor.com/marketplace/publish).
3. Optional listing assets: `assets/banner.png` (1200×630), `assets/avatar.png` (512×512).
4. After approval, users install with `/add-plugin xpp-fno`.

### Optional MCP setup

The plugin does not bundle MCP servers. See [MCP setup](mcp-setup.md) and copy [`mcp.template.json`](../mcp.template.json) for recommended **microsoft-learn** configuration.

## License

Contributions are licensed under MIT — see [LICENSE](../LICENSE).
