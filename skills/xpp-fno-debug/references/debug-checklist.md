# F&O Debug Checklist

Copy and track during investigation:

```
Debug Progress:
- [ ] 1. Symptom documented (expected vs actual)
- [ ] 2. Reproduced in sandbox (not production)
- [ ] 3. Infolog / exception message captured
- [ ] 4. CoC chain verified (ExtensionOf, next at first level, signature)
- [ ] 5. forUpdate / TTS / do* methods ruled out or confirmed
- [ ] 6. Batch job history reviewed (if batch-related)
- [ ] 7. Compatibility checker run (if post-upgrade)
- [ ] 8. Trace Parser captured (if performance-related)
- [ ] 9. Root cause stated as causal chain
- [ ] 10. Fix verified with SysTest or manual repro
```

## CoC quick checks

- `next` must be first executable statement at method level (not inside if/while/for)
- `[ExtensionOf(classStr(...))] final class` naming and publisher prefix
- Method signature must match base exactly
- Form CoC: nested class pattern for form methods

## Batch quick checks

- SysOperation contract parameters passed correctly
- Short TTS scopes — no long transactions across many rows
- Idempotent reruns — safe to retry batch chunk
- Check `BatchJobHistory` status and Infolog tab

## Upgrade regression

```console
CompatibilityChecker.exe -BaselineDirectory="<baseline>" -CurrentDirectory="<current>" -ModuleName="<module>" -OutputFile="<output.xml>"
```

Review breaking change categories: signatures, table fields, form controls, enum values.

## Trace Parser

- Capture trace during slow scenario in UI
- Analyze SQL statement count, duration, call tree
- Compare before/after extension deploy
