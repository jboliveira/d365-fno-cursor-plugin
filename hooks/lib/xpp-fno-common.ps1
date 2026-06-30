# Shared helpers for D365 F&O X++ Cursor hooks (xpp-fno plugin)

$script:XppFnoAxFolderNames = @(
    'AxClass', 'AxTable', 'AxForm', 'AxDataEntityView',
    'AxEnum', 'AxEdt', 'AxQuery'
)

function Test-XppFnoWorkspace {
    param([string]$ProjectDir)

    if ([string]::IsNullOrWhiteSpace($ProjectDir) -or -not (Test-Path -LiteralPath $ProjectDir)) {
        return $false
    }

    foreach ($folder in $script:XppFnoAxFolderNames) {
        $pattern = Join-Path $ProjectDir (Join-Path $folder '*')
        if (Get-ChildItem -Path $pattern -ErrorAction SilentlyContinue | Select-Object -First 1) {
            return $true
        }
        $direct = Join-Path $ProjectDir $folder
        if (Test-Path -LiteralPath $direct) {
            return $true
        }
    }

    try {
        $found = Get-ChildItem -Path $ProjectDir -Directory -Recurse -Depth 4 -ErrorAction SilentlyContinue |
            Where-Object { $script:XppFnoAxFolderNames -contains $_.Name } |
            Select-Object -First 1
        return $null -ne $found
    }
    catch {
        return $false
    }
}

function Test-XppFnoArtifactPath {
    param([string]$Path)

    if ([string]::IsNullOrWhiteSpace($Path)) {
        return $false
    }

    $normalized = $Path -replace '\\', '/'

    if ($normalized -match '\.xpp$') {
        return $true
    }

    foreach ($folder in $script:XppFnoAxFolderNames) {
        if ($normalized -match "/$folder/") {
            return $true
        }
    }

    if ($normalized -match '/AxSecurity[^/]*/' -or $normalized -match '/AxMenuItem[^/]*/') {
        return $true
    }

    return $false
}

function Get-XppFnoContextBlock {
    @"
## D365 Finance and Operations (X++) stack

Platform: **D365 F&O only** (not AX 2012 / Business Central).

Install the **xpp-fno plugin** (`/add-plugin xpp-fno`) for skills, rules, agents, and commands.
Project hooks supplement Cloud Agents when plugin hooks are unavailable locally.

**Agents** (orchestration):
1. `/xpp-fno-planner` - readonly plan before multi-artifact work
2. `/xpp-fno-implementer` - build extensions per Microsoft standards
3. `/xpp-fno-reviewer` - readonly pre-merge audit (12-step checklist)
4. `/xpp-fno-debugger` - readonly systematic debugging

**Skills / commands** (workflows):
- `/xpp-fno-plan`, `/xpp-fno-debug`, `/xpp-fno-verify`, `/xpp-fno-code-review`
- Hub skill: `xpp-fno-development`; domain skills: `xpp-fno-*`

Extension hierarchy: metadata -> CoC -> events -> plugins -> LCS request. Never overlayer.
"@
}

function Read-HookStdinJson {
    $raw = [Console]::In.ReadToEnd()
    if ([string]::IsNullOrWhiteSpace($raw)) {
        return $null
    }
    try {
        return $raw | ConvertFrom-Json
    }
    catch {
        return $null
    }
}

function Write-HookJson {
    param([hashtable]$Payload)

    if ($null -eq $Payload -or $Payload.Count -eq 0) {
        Write-Output '{}'
        return
    }

    $Payload | ConvertTo-Json -Compress -Depth 10
}

function Get-ProjectDirFromHook {
    param($HookInput)

    if ($null -ne $HookInput) {
        $fromInput = [string]$HookInput.project_dir
        if (-not [string]::IsNullOrWhiteSpace($fromInput)) {
            return $fromInput
        }
    }

    if (-not [string]::IsNullOrWhiteSpace($env:CURSOR_PROJECT_DIR)) {
        return $env:CURSOR_PROJECT_DIR
    }
    return (Get-Location).Path
}

function Get-XppFnoDomainHint {
    param([string]$Path)

    if ([string]::IsNullOrWhiteSpace($Path)) {
        return $null
    }

    $normalized = $Path -replace '\\', '/'

    if ($normalized -match '(^|/)AxTable/' -or $normalized -match '(^|/)AxDataEntityView/' -or $normalized -match '(^|/)AxQuery/') {
        return 'xpp-fno-data skill + xpp-fno-data-access rule (forUpdate, TTS, set-based)'
    }
    if ($normalized -match '(^|/)AxForm/') {
        return 'xpp-fno-forms-ui skill + xpp-fno-forms-ui rule (patterns, extensions, labels)'
    }
    if ($normalized -match '(^|/)AxSecurity' -or $normalized -match '(^|/)AxMenuItem') {
        return 'xpp-fno-security skill (privilege -> duty -> role)'
    }
    if ($normalized -match '(^|/)AxClass/' -or $normalized -match '\.xpp$') {
        if ($normalized -match 'Test\.xpp$' -or $normalized -match 'SysTest') {
            return 'xpp-fno-testing skill (SysTestCase, ATL, AutoRollback)'
        }
        if ($normalized -match 'Batch|SysOperation|Controller|Service|Contract') {
            return 'xpp-fno-business-logic skill + xpp-fno-batch-logic rule'
        }
        return 'xpp-fno-extensibility skill + xpp-fno-extensibility rule (CoC, ExtensionOf, next at first level)'
    }

    return 'xpp-fno-core rule (extensions only, labels, no do* methods)'
}
