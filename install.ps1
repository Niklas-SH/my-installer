$ErrorActionPreference = "Stop"

Write-Host "Installing DARK TERMINAL v3.0..." -ForegroundColor Green

$installDir = "$env:LOCALAPPDATA\DarkTerminal"
$batPath = "$installDir\dark-terminal.bat"

# Ordner erstellen
New-Item -ItemType Directory -Path $installDir -Force | Out-Null

# BAT Datei herunterladen
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/Niklas-SH/my-installer/main/dark-terminal.bat" `
  -OutFile $batPath

# Desktop sicher finden (FIX für OneDrive / Windows Varianten)
$desktop = [Environment]::GetFolderPath("Desktop")

if (-not (Test-Path $desktop)) {
    $desktop = "$env:USERPROFILE\OneDrive\Desktop"
}

if (-not (Test-Path $desktop)) {
    $desktop = "$env:USERPROFILE\Desktop"
}

# Shortcut erstellen (SAFE)
try {
    $shortcutPath = Join-Path $desktop "Dark Terminal.lnk"

    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($shortcutPath)
    $Shortcut.TargetPath = $batPath
    $Shortcut.WorkingDirectory = $installDir
    $Shortcut.Save()

    Write-Host "Desktop shortcut created." -ForegroundColor Green
} catch {
    Write-Host "Shortcut creation skipped (desktop not accessible)" -ForegroundColor Yellow
}

Write-Host "DONE! Run Dark Terminal from Desktop or folder." -ForegroundColor Green
