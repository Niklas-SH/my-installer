Write-Host "Hello! Installing tool..."

$path = "$env:LOCALAPPDATA\MyTool"
New-Item -ItemType Directory -Force -Path $path

Write-Host "Done!"
