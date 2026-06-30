# Verify xpp-fno plugin structure and frontmatter

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$errors = @()

function Add-Error { param([string]$Message) $script:errors += $Message }

function Get-FrontmatterFields {
    param([string]$Content)
    if ($Content -notmatch '(?ms)^---\s*\r?\n(.*?)\r?\n---') {
        return $null
    }
    $fields = @{}
    foreach ($line in $Matches[1] -split '\r?\n') {
        if ($line -match '^\s*(\w[\w-]*)\s*:\s*(.+)$') {
            $fields[$Matches[1]] = $Matches[2].Trim()
        }
    }
    return $fields
}

function Test-SafeRelativePath {
    param([string]$PathValue)
    if ([string]::IsNullOrWhiteSpace($PathValue)) { return $false }
    if ($PathValue -match '^https?://') { return $true }
    if ([System.IO.Path]::IsPathRooted($PathValue)) { return $false }
    $normalized = ($PathValue -replace '\\', '/').TrimStart('./')
    return -not ($normalized -eq '..' -or $normalized.StartsWith('../'))
}

function Test-FrontmatterKeys {
    param(
        [string]$FilePath,
        [string[]]$RequiredKeys,
        [string]$Label
    )
    $content = Get-Content $FilePath -Raw
    $fields = Get-FrontmatterFields -Content $content
    if (-not $fields) {
        Add-Error "$Label missing YAML frontmatter: $FilePath"
        return
    }
    foreach ($key in $RequiredKeys) {
        if (-not $fields.ContainsKey($key) -or [string]::IsNullOrWhiteSpace($fields[$key])) {
            Add-Error "$Label missing '$key' in frontmatter: $FilePath"
        }
    }
}

# --- Inventory counts ---
$skillDirs = Get-ChildItem -Path (Join-Path $repoRoot 'skills') -Directory -ErrorAction SilentlyContinue
$ruleFiles = Get-ChildItem -Path (Join-Path $repoRoot 'rules') -Filter 'xpp-fno-*.mdc' -ErrorAction SilentlyContinue
$agentFiles = Get-ChildItem -Path (Join-Path $repoRoot 'agents') -Filter 'xpp-fno-*.md' -ErrorAction SilentlyContinue
$commandFiles = Get-ChildItem -Path (Join-Path $repoRoot 'commands') -Filter 'xpp-fno-*.md' -ErrorAction SilentlyContinue

Write-Host "Skills: $($skillDirs.Count) (expect >= 12)"
Write-Host "Rules: $($ruleFiles.Count) (expect >= 10)"
Write-Host "Agents: $($agentFiles.Count) (expect >= 4)"
Write-Host "Commands: $($commandFiles.Count) (expect >= 6)"

if ($skillDirs.Count -lt 12) { Add-Error "Expected at least 12 skill directories, found $($skillDirs.Count)" }
if ($ruleFiles.Count -lt 10) { Add-Error "Expected at least 10 rules, found $($ruleFiles.Count)" }
if ($agentFiles.Count -lt 4) { Add-Error "Expected at least 4 agents, found $($agentFiles.Count)" }
if ($commandFiles.Count -lt 6) { Add-Error "Expected at least 6 commands, found $($commandFiles.Count)" }

# --- plugin.json ---
$pluginJsonPath = Join-Path $repoRoot '.cursor-plugin\plugin.json'
if (-not (Test-Path $pluginJsonPath)) {
    Add-Error "Missing .cursor-plugin/plugin.json"
}
else {
    $manifest = Get-Content $pluginJsonPath -Raw | ConvertFrom-Json

    if ($manifest.name -notmatch '^[a-z0-9]([a-z0-9.-]*[a-z0-9])?$') {
        Add-Error "plugin.json name must be lowercase kebab-case: $($manifest.name)"
    }

    foreach ($field in @('skills', 'agents', 'rules', 'hooks', 'commands', 'logo')) {
        if ($manifest.PSObject.Properties.Name -contains $field) {
            $rel = $manifest.$field
            if (-not (Test-SafeRelativePath -PathValue $rel)) {
                Add-Error "plugin.json field '$field' has unsafe path: $rel"
                continue
            }
            if ($rel -match '^https?://') { continue }
            if ($rel -match '\.json$') { $relPath = $rel.TrimStart('./').Replace('/', '\') }
            else { $relPath = ($rel.TrimStart('./').Replace('/', '\')).TrimEnd('\') }
            $full = Join-Path $repoRoot $relPath
            if (-not (Test-Path $full)) { Add-Error "plugin.json field '$field' path missing: $rel" }
        }
    }
}

# --- SKILL.md frontmatter + name matches folder ---
foreach ($dir in $skillDirs) {
    $skillMd = Join-Path $dir.FullName 'SKILL.md'
    if (-not (Test-Path $skillMd)) {
        Add-Error "Missing SKILL.md in $($dir.Name)"
        continue
    }
    Test-FrontmatterKeys -FilePath $skillMd -RequiredKeys @('name', 'description') -Label 'Skill'
    $fields = Get-FrontmatterFields -Content (Get-Content $skillMd -Raw)
    if ($fields -and $fields['name'] -ne $dir.Name) {
        Add-Error "Skill name '$($fields['name'])' does not match folder '$($dir.Name)'"
    }
}

# --- .mdc frontmatter ---
foreach ($rule in $ruleFiles) {
    $content = Get-Content $rule.FullName -Raw
    if ($content -notmatch '(?ms)^---\s*\r?\n.*?description:\s*.+?\r?\n.*?alwaysApply:\s*(true|false)') {
        Add-Error "Invalid frontmatter in $($rule.Name) (need description + alwaysApply)"
    }
}

# --- agent frontmatter ---
foreach ($agent in $agentFiles) {
    Test-FrontmatterKeys -FilePath $agent.FullName -RequiredKeys @('name', 'description') -Label 'Agent'
}

# --- command frontmatter ---
foreach ($command in $commandFiles) {
    Test-FrontmatterKeys -FilePath $command.FullName -RequiredKeys @('name', 'description') -Label 'Command'
}

# --- hooks.json ---
$hooksJson = Join-Path $repoRoot 'hooks\hooks.json'
if (-not (Test-Path $hooksJson)) {
    Add-Error "Missing hooks/hooks.json"
}
else {
    $hooks = Get-Content $hooksJson -Raw | ConvertFrom-Json
    if ($hooks.version -ne 1) { Add-Error "hooks.json version must be 1" }
    $requiredEvents = @('sessionStart', 'preToolUse', 'postToolUse', 'subagentStop')
    foreach ($evt in $requiredEvents) {
        if (-not $hooks.hooks.PSObject.Properties.Name -contains $evt) {
            Add-Error "hooks.json missing event: $evt"
        }
    }
}

if ($errors.Count -gt 0) {
    Write-Host "`nFAILED with $($errors.Count) error(s):" -ForegroundColor Red
    $errors | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
    exit 1
}

Write-Host "`nAll checks passed." -ForegroundColor Green
exit 0
