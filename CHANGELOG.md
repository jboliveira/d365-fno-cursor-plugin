# Changelog

All notable changes to the xpp-fno Cursor plugin.

## [1.1.0] - 2026-06-29

### Added

- Skills: `xpp-fno-debug`, `xpp-fno-verify`, `xpp-fno-plan`
- Agent: `xpp-fno-debugger` (readonly)
- Rule: `xpp-fno-debugging.mdc`
- Commands: plan, implement, review, code-review, debug, verify
- Hook: `preToolUse` domain hint injection (`xpp-fno-pre-write.ps1`)
- Scripts: `verify-plugin.ps1`, `smoke-test-hooks.ps1`
- Tests: `tests/verify-manifest.ps1`, `tests/hook-output.test.ps1`
- CI: `.github/workflows/verify-plugin.yml`
- Docs: `docs/debugging.md`, `docs/testing.md`
- `AGENTS.md` at plugin root
- Project template: `.cursor/hooks/` for Cloud Agents

### Changed

- Hub skill router updated with plan, debug, verify entries
- `hooks/hooks.json` now includes `preToolUse` event
- Version bump in plugin and marketplace manifests

## [1.0.0] - 2026-06-29

### Added

- Initial release: 9 skills, 9 rules, 3 agents, 3 hooks
- Documentation: README + 8 guides under `docs/`
- Sync script: `scripts/sync-from-user.ps1`
