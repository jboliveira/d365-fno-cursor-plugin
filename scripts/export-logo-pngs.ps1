# Export SVG logo assets to PNG for marketplace and README.
$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $PSScriptRoot
$Assets = Join-Path $Root 'assets'

function Export-Png {
    param(
        [string]$InputSvg,
        [string]$OutputPng,
        [int]$Width,
        [int]$Height = 0
    )
    if ($Height -eq 0) { $Height = $Width }
    $inPath = Join-Path $Assets $InputSvg
    $outPath = Join-Path $Assets $OutputPng
    if (-not (Test-Path $inPath)) {
        throw "Missing SVG: $inPath"
    }
    Write-Host "Exporting $OutputPng (${Width}x${Height})..."
    if ($Width -eq $Height) {
        npx --yes @resvg/resvg-js-cli $inPath $outPath --fit-width $Width
    }
    else {
        npx --yes @resvg/resvg-js-cli $inPath $outPath --fit-width $Width --fit-height $Height
    }
    if (-not (Test-Path $outPath)) {
        throw "Failed to create $outPath"
    }
}

Push-Location $Root
try {
    Export-Png -InputSvg 'logo-padded.svg' -OutputPng 'avatar.png' -Width 512
    Export-Png -InputSvg 'logo-padded.svg' -OutputPng 'logo-512.png' -Width 512
    Export-Png -InputSvg 'logo-padded.svg' -OutputPng 'logo-256.png' -Width 256
    Export-Png -InputSvg 'logo-padded.svg' -OutputPng 'logo-128.png' -Width 128
    Export-Png -InputSvg 'banner.svg' -OutputPng 'banner.png' -Width 1200 -Height 630
    Write-Host 'Done.'
}
finally {
    Pop-Location
}
