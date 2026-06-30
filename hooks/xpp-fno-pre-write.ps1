# preToolUse — inject domain skill hint before Ax* writes (xpp-fno plugin)

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
if ($null -ne $hookPayload -and $hookPayload.tool_input) {
    if ($hookPayload.tool_input.path) { $filePath = [string]$hookPayload.tool_input.path }
    if ($hookPayload.tool_input.file_path) { $filePath = [string]$hookPayload.tool_input.file_path }
}
if ($null -eq $filePath -and $null -ne $hookPayload -and $hookPayload.file_path) {
    $filePath = [string]$hookPayload.file_path
}

if (-not (Test-XppFnoArtifactPath -Path $filePath)) {
    Write-HookJson -Payload @{}
    exit 0
}

$hint = Get-XppFnoDomainHint -Path $filePath
if ([string]::IsNullOrWhiteSpace($hint)) {
    Write-HookJson -Payload @{}
    exit 0
}

Write-HookJson -Payload @{
    additional_context = "X++ F&O pre-write ($filePath): apply $hint"
}
exit 0
