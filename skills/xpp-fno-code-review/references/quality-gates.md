# Quality Gates

Microsoft citizen-developer tools for F&O extensions.

## Best Practice Check

- Built into Visual Studio compile
- Target: **zero deviations** (errors, warnings, informational)
- Block check-in on BP errors in CI where possible

Source: [Author best practice rules](https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/dev-tools/author-best-practice-rules)

## Compatibility Checker

Detects metadata breaking changes against baseline:

```console
CompatibilityChecker.exe -BaselineDirectory="<baseline>" -CurrentDirectory="<current>" -ModuleName="<module>" -OutputFile="<output.xml>"
```

Breaking change categories: class member access, method signatures, table fields, form controls, labels, enum properties.

Source: [Compatibility checker tool](https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/compatibility-checker-tool)

## Customization Analysis Report (CAR)

```console
xppbp.exe -metadata=<packages> -all -model=<ModelName> -xmlLog=C:\BPCheckLog.xml -module=<PackageName> -car=C:\CAReport.xlsx
```

Resolve all Issues tab warnings/errors before release.

Source: [Customization Analysis Report](https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/dev-tools/customization-analysis-report)

## Trace Parser

- Take trace from UI during scenario execution
- Analyze call tree, SQL statements, method duration
- Use for performance validation of hot paths

Location: PerfSDK folder in development environment.

## Unit Testing Gate

- SysTest + ATL before check-in
- Developer is first line of defense
- Never execute tests on production

## Extensibility Requests

Log missing extension points in LCS early when standard extension techniques cannot satisfy requirements.
