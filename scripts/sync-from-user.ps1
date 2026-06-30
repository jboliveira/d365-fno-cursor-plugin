# Sync xpp-fno plugin assets from user-level ~/.cursor/ into this repo.
# Run from repo root: powershell -File scripts/sync-from-user.ps1

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$userCursor = Join-Path $env:USERPROFILE '.cursor'
if (-not (Test-Path $userCursor)) {
    throw "User Cursor directory not found: $userCursor"
}

function Copy-Tree {
    param(
        [string]$Source,
        [string]$Destination
    )

    if (-not (Test-Path $Source)) {
        Write-Warning "Skipping missing source: $Source"
        return
    }

    if (Test-Path $Destination) {
        Remove-Item -LiteralPath $Destination -Recurse -Force
    }

    Copy-Item -LiteralPath $Source -Destination $Destination -Recurse -Force
    Write-Host "Copied $Source -> $Destination"
}

$skillNames = @(
    'xpp-fno-development',
    'xpp-fno-extensibility',
    'xpp-fno-extensible-design',
    'xpp-fno-data',
    'xpp-fno-business-logic',
    'xpp-fno-forms-ui',
    'xpp-fno-security',
    'xpp-fno-testing',
    'xpp-fno-code-review'
)

$skillsDest = Join-Path $repoRoot 'skills'
if (-not (Test-Path $skillsDest)) {
    New-Item -ItemType Directory -Path $skillsDest | Out-Null
}

Get-ChildItem -Path $skillsDest -Directory -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -like 'xpp-fno-*' } |
    Remove-Item -Recurse -Force

foreach ($name in $skillNames) {
    Copy-Tree `
        -Source (Join-Path $userCursor "skills\$name") `
        -Destination (Join-Path $skillsDest $name)
}

$rulesDest = Join-Path $repoRoot 'rules'
if (-not (Test-Path $rulesDest)) {
    New-Item -ItemType Directory -Path $rulesDest | Out-Null
}

Get-ChildItem -Path (Join-Path $userCursor 'rules') -Filter 'xpp-fno-*.mdc' |
    ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination (Join-Path $rulesDest $_.Name) -Force
        Write-Host "Copied rule $($_.Name)"
    }

$agentsDest = Join-Path $repoRoot 'agents'
if (-not (Test-Path $agentsDest)) {
    New-Item -ItemType Directory -Path $agentsDest | Out-Null
}

Get-ChildItem -Path (Join-Path $userCursor 'agents') -Filter 'xpp-fno-*.md' |
    ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination (Join-Path $agentsDest $_.Name) -Force
        Write-Host "Copied agent $($_.Name)"
    }

$hooksDest = Join-Path $repoRoot 'hooks'
$libDest = Join-Path $hooksDest 'lib'
if (-not (Test-Path $libDest)) {
    New-Item -ItemType Directory -Path $libDest -Force | Out-Null
}

$hookScripts = @(
    'xpp-fno-session-start.ps1',
    'xpp-fno-post-write.ps1',
    'xpp-fno-subagent-stop.ps1'
)

foreach ($script in $hookScripts) {
    Copy-Item `
        -LiteralPath (Join-Path $userCursor "hooks\$script") `
        -Destination (Join-Path $hooksDest $script) `
        -Force
    Write-Host "Copied hook $script"
}

Copy-Item `
    -LiteralPath (Join-Path $userCursor 'hooks\lib\xpp-fno-common.ps1') `
    -Destination (Join-Path $libDest 'xpp-fno-common.ps1') `
    -Force
Write-Host 'Copied hook lib/xpp-fno-common.ps1'

Write-Host 'Sync complete. Review plugin-specific files (hooks/hooks.json, agent comments) before commit.'
