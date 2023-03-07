# Clone the repository
# git clone https://github.com/thebananathief/shell-setup

# Copy the powershell profile
# if (Test-Path $PROFILE) {
#     Write-Host "Found an existing PowerShell profile, renaming..."
#     Rename-Item $PROFILE Microsoft.PowerShell_profile.ps1.bak
# }
Write-Host "Copying PowerShell profile to $PROFILE..."
# Copy-Item shell-setup\Microsoft.PowerShell_profile.ps1 $PROFILE -Force
Invoke-WebRequest https://raw.githubusercontent.com/thebananathief/shell-setup/main/Microsoft.PowerShell_profile.ps1 -o $PROFILE

# Copy the WindowsTerminal config
$WTFamilyName = $(Get-AppxPackage | Where-Object Name -eq Microsoft.WindowsTerminal).PackageFamilyName
$WTData = "$env:LOCALAPPDATA\Packages\$WTFamilyName\LocalState"
# if (Test-Path "$WTData\settings.json") {
#     Write-Host "Found an existing WindowsTerminal config, renaming..."
#     Rename-Item "$WTData\settings.json" settings.json.bak
# }
Write-Host "Copying WindowsTerminal config to $WTData..."
# Copy-Item shell-setup\WindowsTerminal\settings.json $WTData -Force
Invoke-WebRequest https://raw.githubusercontent.com/thebananathief/shell-setup/main/WindowsTerminal/settings.json -o "$WTData\settings.json"

# Copy the starship config
# if (Test-Path ~/.config -eq $False) {
#     New-Item ~/.config/
# }
Write-Host "Copying Starship config to $env:USERPROFILE\.config..."
# Copy-Item shell-setup\starship.toml ~\.config -Force
Invoke-WebRequest https://raw.githubusercontent.com/thebananathief/shell-setup/main/starship.toml -o "$env:USERPROFILE\.config\starship.toml"

Write-Host
Write-Host "Finished! -- Enjoy your pretty terminal!"
# Write-Host "Finished! -- This repository now resides in $env:USERPROFILE\shell-setup"
# Delete the setup repo
# Remove-Item shell-setup -Recurse -Force
