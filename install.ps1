Write-Host "===================================" -ForegroundColor Cyan
Write-Host "   Installing MyTool CLI..." -ForegroundColor Green
Write-Host "==================================="

# Installationspfad
$installPath = "$env:LOCALAPPDATA\MyTool"
New-Item -ItemType Directory -Force -Path $installPath | Out-Null

# --- TOOL SCRIPT (das später ausgeführt wird) ---
$toolScript = @'
param([string]$arg)

if (-not $arg) {
    Write-Host ""
    Write-Host " MyTool CLI v1.0 " -ForegroundColor Cyan
    Write-Host "-------------------"
    Write-Host "commands:"
    Write-Host "  hello   -> greeting"
    Write-Host "  info    -> system info"
    Write-Host ""
    return
}

switch ($arg) {
    "hello" {
        Write-Host "Hello 👋 welcome to MyTool!" -ForegroundColor Green
    }

    "info" {
        Write-Host "System Info:" -ForegroundColor Yellow
        Write-Host "User: $env:USERNAME"
        Write-Host "PC: $env:COMPUTERNAME"
        Write-Host "OS: $((Get-CimInstance Win32_OperatingSystem).Caption)"
    }

    default {
        Write-Host "Unknown command: $arg" -ForegroundColor Red
    }
}
'@

# Tool speichern
$toolPath = "$installPath\mytool.ps1"
Set-Content -Path $toolPath -Value $toolScript

# --- PowerShell Profile Setup ---
$profilePath = $PROFILE

if (!(Test-Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force | Out-Null
}

$aliasBlock = @"

# MyTool CLI
function mytool {
    & "$toolPath" @args
}
"@

if (-not (Get-Content $profilePath -ErrorAction SilentlyContinue | Select-String "MyTool CLI")) {
    Add-Content -Path $profilePath -Value $aliasBlock
}

Write-Host ""
Write-Host "Installation complete!" -ForegroundColor Green
Write-Host "Restart PowerShell and type: mytool" -ForegroundColor Cyan
Write-Host ""
