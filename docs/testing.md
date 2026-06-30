# Testing and verification

Two distinct workflows in the xpp-fno plugin.

## Authoring tests vs verifying quality

| | SysTest authoring | Verification |
|---|-------------------|--------------|
| Skill | `xpp-fno-testing` | `xpp-fno-verify` |
| Purpose | Write SysTestCase, ATL, isolation | Prove compile/BP/test/compatibility claims |
| Invoke | Auto or mention | `/xpp-fno-verify` only |
| Output | Test code | VERIFIED / NOT VERIFIED / INCONCLUSIVE |

## Quality gates (Microsoft citizen-developer)

Run before merge or release:

| Gate | Tool | Target |
|------|------|--------|
| Best practice | Visual Studio compile | Zero deviations |
| Compatibility | CompatibilityChecker.exe | No breaking changes vs baseline |
| CAR | xppbp.exe `-car` | Issues tab clean |
| Unit tests | SysTest runner | All tests pass |
| Performance (hot paths) | Trace Parser | Acceptable SQL/duration |

Command examples are in `skills/xpp-fno-code-review/references/quality-gates.md`.

## Recommended workflow

1. Implement feature → `/xpp-fno-implementer`
2. Add SysTest → `xpp-fno-testing` skill
3. Verify claims → `/xpp-fno-verify` ("compiles BP zero and SysTest X passes")
4. Qualitative audit → `/xpp-fno-reviewer`

## Plugin self-testing (maintainers)

For plugin repo validation (not F&O code):

```powershell
powershell -File scripts/verify-plugin.ps1
powershell -File scripts/smoke-test-hooks.ps1
```

See [Contributing](contributing.md) release checklist.

## See also

- [Skills — xpp-fno-testing](skills.md)
- [Skills — xpp-fno-verify](skills.md)
- [Workflows — SysTest example](workflows.md)
