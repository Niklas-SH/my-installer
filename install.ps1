$ErrorActionPreference = "Stop"

Write-Host "Installing DARK TERMINAL v3.0..." -ForegroundColor Green

$installDir = "$env:LOCALAPPDATA\DarkTerminal"
$batPath = "$installDir\dark-terminal.bat"

# Ordner erstellen
New-Item -ItemType Directory -Path $installDir -Force | Out-Null

# BAT Datei laden
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/Niklas-SH/my-installer/main/dark-terminal.bat" `
  -OutFile $batPath

Write-Host "Installed successfully!" -ForegroundColor Green
Write-Host "Location: $batPath"

# Desktop Shortcut (100% safe)
try {
    $desktop = [Environment]::GetFolderPath("Desktop")

    if (-not (Test-Path $desktop)) {
        $desktop = "$env:USERPROFILE\Desktop"
    }

    $shortcutPath = Join-Path $desktop "Dark Terminal.lnk"

    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($shortcutPath)
    $Shortcut.TargetPath = $batPath
    $Shortcut.WorkingDirectory = $installDir
    $Shortcut.Save()

    Write-Host "Shortcut created!" -ForegroundColor Green
} catch {
    Write-Host "Shortcut skipped (no desktop access)" -ForegroundColor Yellow
}
