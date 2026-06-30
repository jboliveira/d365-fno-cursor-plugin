# Delegates to scripts/verify-plugin.ps1 for CI and local runs

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
& (Join-Path $repoRoot 'scripts\verify-plugin.ps1')
exit $LASTEXITCODE
