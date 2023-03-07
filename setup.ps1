# Ensure home directory
Set-Location ~

# Clone the repository and navigate to it
git clone https://github.com/thebananathief/shell-setup
Set-Location shell-setup

# Copy the powershell profile
if (Test-Path $PROFILE) {
    Write-Host "Found an existing PowerShell profile, renaming..."
    Rename-Item $PROFILE Microsoft.PowerShell_profile.ps1.bak
}
Write-Host "Copying PowerShell profile to $PROFILE..."
Copy-Item Microsoft.PowerShell_profile.ps1 $PROFILE

# Copy the WindowsTerminal config


# Copy the starship config


# Delete the setup repo
Remove-Item . -Recurse -Force