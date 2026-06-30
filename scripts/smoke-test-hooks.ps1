# Smoke-test xpp-fno plugin hooks (stdin JSON)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$hooksDir = Join-Path $repoRoot 'hooks'
$failed = 0

function Invoke-HookTest {
    param(
        [string]$Name,
        [string]$Script,
        [string]$StdinJson,
        [scriptblock]$Assert
    )

    Write-Host "Testing $Name..."
    $env:XPP_FNO_WORKSPACE = '1'
    $output = $StdinJson | & powershell -NoProfile -ExecutionPolicy Bypass -File $Script 2>&1
    $exitCode = $LASTEXITCODE
    if ($exitCode -ne 0) {
        Write-Host "  FAIL: exit code $exitCode" -ForegroundColor Red
        Write-Host $output
        $script:failed++
        return
    }
    try {
        & $Assert $output
        Write-Host "  OK" -ForegroundColor Green
    }
    catch {
        Write-Host "  FAIL: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "  Output: $output"
        $script:failed++
    }
}

Invoke-HookTest -Name 'postToolUse (doUpdate warning)' `
    -Script (Join-Path $hooksDir 'xpp-fno-post-write.ps1') `
    -StdinJson '{"tool_input":{"path":"AxClass/MyTest.xpp","new_string":"t.doUpdate();"}}' `
    -Assert {
        param($out)
        if ($out -notmatch 'doUpdate') { throw 'Expected doUpdate warning in output' }
    }

Invoke-HookTest -Name 'subagentStop (reviewer chain)' `
    -Script (Join-Path $hooksDir 'xpp-fno-subagent-stop.ps1') `
    -StdinJson '{"status":"completed","modified_files":["AxClass/MyPublisher_Test.xpp"]}' `
    -Assert {
        param($out)
        if ($out -notmatch 'xpp-fno-reviewer') { throw 'Expected followup_message for reviewer' }
    }

Invoke-HookTest -Name 'preToolUse (domain hint)' `
    -Script (Join-Path $hooksDir 'xpp-fno-pre-write.ps1') `
    -StdinJson '{"tool_input":{"path":"AxTable/CustTable.MyPublisher.xpp","new_string":"field"}}' `
    -Assert {
        param($out)
        if ($out -notmatch 'xpp-fno-data') { throw 'Expected data skill hint for AxTable' }
    }

Invoke-HookTest -Name 'sessionStart (non-F&O repo)' `
    -Script (Join-Path $hooksDir 'xpp-fno-session-start.ps1') `
    -StdinJson '{"project_dir":"C:\\Windows\\Temp"}' `
    -Assert {
        param($out)
        if ($out.Trim() -ne '{}') { throw "Expected empty JSON for non-F&O path, got: $out" }
    }

if ($failed -gt 0) {
    Write-Host "`n$failed test(s) failed." -ForegroundColor Red
    exit 1
}

Write-Host "`nAll hook smoke tests passed." -ForegroundColor Green
exit 0
