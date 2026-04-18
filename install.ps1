# DARK TERMINAL INSTALLER
# Run via: irm URL | iex

$ErrorActionPreference = "Stop"

$installDir = "$env:LOCALAPPDATA\DarkTerminal"
$batPath = "$installDir\dark-terminal.bat"

Write-Host "Installing DARK TERMINAL v3.0..." -ForegroundColor Green

# Ordner erstellen
New-Item -ItemType Directory -Path $installDir -Force | Out-Null

# Batch Script Inhalt (dein CMD Design)
$batContent = @'
@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion
title DARK TERMINAL v3.0 // NEIKI OS
mode con: cols=120 lines=45

powershell -c "[console]::beep(300,80);Start-Sleep -Milliseconds 50;[console]::beep(500,80);Start-Sleep -Milliseconds 50;[console]::beep(700,120);Start-Sleep -Milliseconds 50;[console]::beep(900,150)" >nul

cls
echo DARK TERMINAL INSTALLED SUCCESSFULLY
timeout /t 2 >nul
start cmd /k "%~dp0dark-terminal.bat"
'@

# Datei schreiben
Set-Content -Path $batPath -Value $batContent -Encoding UTF8

$desktop = [Environment]::GetFolderPath("Desktop")

$shortcutPath = "$desktop\Dark Terminal.lnk"
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($shortcutPath)
$Shortcut.TargetPath = $batPath
$Shortcut.WorkingDirectory = $installDir
$Shortcut.Save()

Write-Host "DONE!" -ForegroundColor Green
Write-Host "Location: $batPath"
Write-Host "Desktop Shortcut created."
Write-Host "Run it anytime: Dark Terminal"
