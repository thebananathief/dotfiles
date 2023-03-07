# Clone the repository
git clone https://github.com/thebananathief/shell-setup

# Copy the powershell profile
# if (Test-Path $PROFILE) {
#     Write-Host "Found an existing PowerShell profile, renaming..."
#     Rename-Item $PROFILE Microsoft.PowerShell_profile.ps1.bak
# }
Write-Host "Copying PowerShell profile to $PROFILE..."
Copy-Item shell-setup\Microsoft.PowerShell_profile.ps1 $PROFILE -Force

# Copy the WindowsTerminal config
$WTFamilyName = $(Get-AppxPackage | Where-Object Name -eq Microsoft.WindowsTerminal).PackageFamilyName
$WTData = "$env:LOCALAPPDATA\Packages\$WTFamilyName\LocalState"
# if (Test-Path "$WTData\settings.json") {
#     Write-Host "Found an existing WindowsTerminal config, renaming..."
#     Rename-Item "$WTData\settings.json" settings.json.bak
# }
Write-Host "Copying WindowsTerminal config to $WTData..."
Copy-Item shell-setup\WindowsTerminal\settings.json $WTData -Force
# C:\Users\Cameron\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState

# Copy the starship config
# if (Test-Path ~/.config -eq $False) {
#     New-Item ~/.config/
# }
Write-Host "Copying Starship config to $env:USERPROFILE\.config..."
Copy-Item shell-setup\starship.toml ~\.config -Force

Write-Host
Write-Host "Finished! -- This repository now resides in $env:USERPROFILE\shell-setup"
# Delete the setup repo
# Remove-Item shell-setup -Recurse -Force
