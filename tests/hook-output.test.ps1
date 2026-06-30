# Delegates to scripts/smoke-test-hooks.ps1 for CI and local runs

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
& (Join-Path $repoRoot 'scripts\smoke-test-hooks.ps1')
exit $LASTEXITCODE
