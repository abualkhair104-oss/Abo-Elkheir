$ErrorActionPreference = 'SilentlyContinue'
$siteUrl = 'http://localhost:3000'
$root = $PSScriptRoot

$listener = Get-NetTCPConnection -State Listen -LocalPort 3000 -ErrorAction SilentlyContinue
if (-not $listener) {
    Start-Process -FilePath $env:ComSpec `
        -ArgumentList @('/c', 'npm run dev') `
        -WorkingDirectory $root `
        -WindowStyle Minimized
}

$ready = $false
for ($attempt = 0; $attempt -lt 60; $attempt++) {
    try {
        $response = Invoke-WebRequest -Uri $siteUrl -UseBasicParsing -TimeoutSec 2
        if ($response.StatusCode -ge 200 -and $response.StatusCode -lt 500) {
            $ready = $true
            break
        }
    } catch { }
    Start-Sleep -Seconds 1
}

if ($ready) {
    Start-Process $siteUrl
    Write-Host 'Store started. Keep the minimized server window open.'
} else {
    Write-Host 'The store server did not start. Check Node.js and npm installation.'
    Write-Host "Project folder: $root"
}
Read-Host 'Press Enter to close this window'
