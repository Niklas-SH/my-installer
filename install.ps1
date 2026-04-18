$ErrorActionPreference = "SilentlyContinue"

Write-Host "Installing DARK TERMINAL v3.0..." -ForegroundColor Green

$installDir = "$env:LOCALAPPDATA\DarkTerminal"
$batPath = "$installDir\dark-terminal.bat"

# Install Ordner
New-Item -ItemType Directory -Path $installDir -Force | Out-Null

# BAT Datei holen
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/Niklas-SH/my-installer/main/dark-terminal.bat" `
  -OutFile $batPath

Write-Host "Installed successfully!" -ForegroundColor Green
Write-Host "Path: $batPath"

# ---- SAFE DESKTOP HANDLING (FIXED) ----
try {
    $desktop = [Environment]::GetFolderPath("Desktop")

    if (-not (Test-Path $desktop)) {
        $desktop = "$env:USERPROFILE\Desktop"
    }

    if (-not (Test-Path $desktop)) {
        throw "Desktop not found"
    }

    $shortcutPath = Join-Path $desktop "Dark Terminal.lnk"

    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($shortcutPath)
    $Shortcut.TargetPath = $batPath
    $Shortcut.WorkingDirectory = $installDir
    $Shortcut.Save()

    Write-Host "Shortcut created on Desktop" -ForegroundColor Green
}
catch {
    Write-Host "Shortcut skipped (Desktop not accessible)" -ForegroundColor Yellow
}
