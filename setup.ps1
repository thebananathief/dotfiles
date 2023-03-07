#If the file does not exist, create it.
if (!(Test-Path -Path $PROFILE -PathType Leaf)) {
    try {
        # Detect Version of Powershell & Create Profile directories if they do not exist.
        if ($PSVersionTable.PSEdition -eq "Core" ) { 
            if (!(Test-Path -Path ($env:userprofile + "\Documents\Powershell"))) {
                New-Item -Path ($env:userprofile + "\Documents\Powershell") -ItemType "directory"
            }
        }
        elseif ($PSVersionTable.PSEdition -eq "Desktop") {
            if (!(Test-Path -Path ($env:userprofile + "\Documents\WindowsPowerShell"))) {
                New-Item -Path ($env:userprofile + "\Documents\WindowsPowerShell") -ItemType "directory"
            }
        }

        Invoke-RestMethod https://github.com/ChrisTitusTech/powershell-profile/raw/main/Microsoft.PowerShell_profile.ps1 -o $PROFILE
        Write-Host "The profile @ [$PROFILE] has been created."
    }
    catch {
        throw $_.Exception.Message
    }
}
# If the file already exists, show the message and do nothing.
 else {
		 Get-Item -Path $PROFILE | Move-Item -Destination oldprofile.ps1
		 Invoke-RestMethod https://github.com/ChrisTitusTech/powershell-profile/raw/main/Microsoft.PowerShell_profile.ps1 -o $PROFILE
		 Write-Host "The profile @ [$PROFILE] has been created and old profile removed."
 }
& $profile

function install-posh() {
    winget install -e --accept-source-agreements --accept-package-agreements JanDeDobbeleer.OhMyPosh
}

function install-starship() {
    # winget install -e --accept-source-agreements --accept-package-agreements Starship.Starship
}

# Font Install
# You will have to extract and Install this font manually, alternatively use the oh my posh font installer (Must be run as admin)
# oh-my-posh font install
# You will also need to set your Nerd Font of choice in your window defaults or in the Windows Terminal Settings.
# Invoke-RestMethod https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip?WT.mc_id=-blog-scottha -o cove.zip

# Choco install
#
# Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Terminal Icons Install
#
# Install-Module -Name Terminal-Icons -Repository PSGallery







# Clone the repository
# git clone https://github.com/thebananathief/shell-setup

# Copy the powershell profile
# if (Test-Path $PROFILE) {
#     Write-Host "Found an existing PowerShell profile, renaming..."
#     Rename-Item $PROFILE Microsoft.PowerShell_profile.ps1.bak
# }
Write-Host "Copying PowerShell profile to $PROFILE..."
# Copy-Item shell-setup\Microsoft.PowerShell_profile.ps1 $PROFILE -Force
Invoke-RestMethod https://raw.githubusercontent.com/thebananathief/shell-setup/main/Microsoft.PowerShell_profile.ps1 -o $PROFILE

# Copy the WindowsTerminal config
$WTFamilyName = $(Get-AppxPackage | Where-Object Name -eq Microsoft.WindowsTerminal).PackageFamilyName
$WTData = "$env:LOCALAPPDATA\Packages\$WTFamilyName\LocalState"
# if (Test-Path "$WTData\settings.json") {
#     Write-Host "Found an existing WindowsTerminal config, renaming..."
#     Rename-Item "$WTData\settings.json" settings.json.bak
# }
Write-Host "Copying WindowsTerminal config to $WTData..."
# Copy-Item shell-setup\WindowsTerminal\settings.json $WTData -Force
Invoke-RestMethod https://raw.githubusercontent.com/thebananathief/shell-setup/main/WindowsTerminal/settings.json -o "$WTData\settings.json"

# Copy the starship config
# if (Test-Path ~/.config -eq $False) {
#     New-Item ~/.config/
# }
Write-Host "Copying Starship config to $env:USERPROFILE\.config..."
# Copy-Item shell-setup\starship.toml ~\.config -Force
Invoke-RestMethod https://raw.githubusercontent.com/thebananathief/shell-setup/main/starship.toml -o "$env:USERPROFILE\.config\starship.toml"

Write-Host

Write-Host "Finished! -- Enjoy your pretty terminal!"
# Write-Host "Finished! -- This repository now resides in $env:USERPROFILE\shell-setup"
