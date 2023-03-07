# Ensure home directory
Set-Location ~

# Clone the repository and navigate to it
git clone https://github.com/thebananathief/shell-setup
Set-Location shell-setup

# Copy the powershell profile
if (Test-Path $PROFILE) {
    Rename-Item $PROFILE Microsoft.PowerShell_profile.ps1.bak
}
Copy-Item Microsoft.PowerShell_profile.ps1 $PROFILE -verbose

# Copy the WindowsTerminal config

# Copy the starship config