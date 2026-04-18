@echo off
chcp 65001 >nul
title DARK TROLL LOOP
color 0A

:loop
cls
echo ================================
echo   SYSTEM RUNNING... (TROLL MODE)
echo   PRESS ESC TO EXIT
echo ================================
echo.

choice /c X /n /t 1 /d X >nul

:: ESC detection workaround via PowerShell key check
powershell -NoProfile -Command ^
"if ([console]::KeyAvailable) { $k = [console]::ReadKey($true); if ($k.Key -eq 'Escape') { exit 99 } }"

if errorlevel 99 exit

goto loop
