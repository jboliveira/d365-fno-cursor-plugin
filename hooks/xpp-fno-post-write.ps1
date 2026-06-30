# postToolUse — warn on do* methods in F&O artifact writes (xpp-fno plugin)

$ErrorActionPreference = 'Stop'
. "$PSScriptRoot/lib/xpp-fno-common.ps1"

$hookPayload = Read-HookStdinJson
$projectDir = Get-ProjectDirFromHook

$isFnoWorkspace = ($env:XPP_FNO_WORKSPACE -eq '1') -or (Test-XppFnoWorkspace -ProjectDir $projectDir)
if (-not $isFnoWorkspace) {
    Write-HookJson -Payload @{}
    exit 0
}

$filePath = $null
$contentToScan = ''

if ($null -ne $hookPayload) {
    if ($hookPayload.tool_input) {
        if ($hookPayload.tool_input.path) { $filePath = [string]$hookPayload.tool_input.path }
        if ($hookPayload.tool_input.file_path) { $filePath = [string]$hookPayload.tool_input.file_path }
        if ($hookPayload.tool_input.contents) { $contentToScan += [string]$hookPayload.tool_input.contents }
        if ($hookPayload.tool_input.new_string) { $contentToScan += [string]$hookPayload.tool_input.new_string }
        if ($hookPayload.tool_input.newString) { $contentToScan += [string]$hookPayload.tool_input.newString }
    }
    if ($hookPayload.file_path) { $filePath = [string]$hookPayload.file_path }
}

if ($null -ne $hookPayload.tool_output) {
    $contentToScan += [string]$hookPayload.tool_output
}

if (-not (Test-XppFnoArtifactPath -Path $filePath)) {
    Write-HookJson -Payload @{}
    exit 0
}

$warnings = @()

if ($contentToScan -match '\bdoUpdate\s*\(') { $warnings += 'doUpdate()' }
if ($contentToScan -match '\bdoInsert\s*\(') { $warnings += 'doInsert()' }
if ($contentToScan -match '\bdoDelete\s*\(') { $warnings += 'doDelete()' }

if ($contentToScan -match '\bnext\b' -and $contentToScan -match '\b(if|while|for)\s*\(') {
    $warnings += 'CoC: verify next is at first level (not inside if/while/for)'
}

if ($warnings.Count -eq 0) {
    Write-HookJson -Payload @{}
    exit 0
}

$listed = ($warnings | Select-Object -Unique) -join ', '
Write-HookJson -Payload @{
    additional_context = "X++ F&O hook ($filePath): detected $listed. do* methods bypass CoC, events, and validation (see ./rules/xpp-fno-core.mdc and ./skills/xpp-fno-data/rules/data-no-do-methods.md). Use update()/insert()/delete()."
}
exit 0
