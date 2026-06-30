# sessionStart — inject F&O stack context when Ax* workspace detected (xpp-fno plugin)

$ErrorActionPreference = 'Stop'
. "$PSScriptRoot/lib/xpp-fno-common.ps1"

$null = Read-HookStdinJson
$projectDir = Get-ProjectDirFromHook

if (-not (Test-XppFnoWorkspace -ProjectDir $projectDir)) {
    Write-HookJson -Payload @{}
    exit 0
}

Write-HookJson -Payload @{
    env = @{ XPP_FNO_WORKSPACE = '1' }
    additional_context = Get-XppFnoContextBlock
}
exit 0
