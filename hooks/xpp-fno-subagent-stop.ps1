# subagentStop — chain xpp-fno-implementer to xpp-fno-reviewer (xpp-fno plugin)

$ErrorActionPreference = 'Stop'
. "$PSScriptRoot/lib/xpp-fno-common.ps1"

$hookPayload = Read-HookStdinJson

if ($null -eq $hookPayload) {
    Write-HookJson -Payload @{}
    exit 0
}

$status = [string]$hookPayload.status
if ($status -ne 'completed') {
    Write-HookJson -Payload @{}
    exit 0
}

$modifiedFiles = @()
if ($hookPayload.modified_files) {
    $modifiedFiles = @($hookPayload.modified_files)
}

$hasFnoArtifact = $false
foreach ($file in $modifiedFiles) {
    if (Test-XppFnoArtifactPath -Path ([string]$file)) {
        $hasFnoArtifact = $true
        break
    }
}

if (-not $hasFnoArtifact) {
    Write-HookJson -Payload @{}
    exit 0
}

Write-HookJson -Payload @{
    followup_message = '/xpp-fno-reviewer Review the X++ changes against the 12-step checklist. Focus on CoC, forUpdate, security entry points, and SysTest coverage.'
}
exit 0
