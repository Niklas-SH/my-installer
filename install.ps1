Write-Host "==============================" -ForegroundColor Cyan
Write-Host "  SPICETIFY STYLE INSTALLER  " -ForegroundColor Green
Write-Host "=============================="

# Check if Spotify exists
$spotifyPath = "$env:APPDATA\Spotify"

if (!(Test-Path $spotifyPath)) {
    Write-Host "Spotify not found! Please install Spotify first." -ForegroundColor Red
    exit
}

# Install Spicetify (official way)
Write-Host "Installing Spicetify..." -ForegroundColor Yellow
iwr -useb https://raw.githubusercontent.com/spicetify/spicetify-cli/main/install.ps1 | iex

# Wait
Start-Sleep -Seconds 2

# Apply Spicetify
Write-Host "Applying Spicetify..." -ForegroundColor Yellow
spicetify backup apply

# Install Marketplace (optional but cool)
Write-Host "Installing Spicetify Marketplace..." -ForegroundColor Yellow
iwr -useb https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.ps1 | iex

Write-Host ""
Write-Host "DONE! Restart Spotify 🎧" -ForegroundColor Green
Write-Host ""
