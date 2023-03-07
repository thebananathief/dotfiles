# Choco install
# Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Terminal Icons Install
Install-Module -Name Terminal-Icons -Repository PSGallery

function Install-Posh() {
    winget install -e --accept-source-agreements --accept-package-agreements --id JanDeDobbeleer.OhMyPosh

    # TODO: Install posh config
    Write-Host "oh-my-posh was installed"
}

function Install-Starship() {
    winget install -e --accept-source-agreements --accept-package-agreements --id Starship.Starship

    $Config = "$env:USERPROFILE\.config"

    # Ensure config folder exists
    if (!(Test-Path -Path $Config -PathType Container)) {
        New-Item -Path $Config -ItemType "directory"
    }

    # Keep old config
    # if (Test-Path -Path "$Config\starship.toml" -PathType Leaf) {
    #     Write-Host "Found an existing Starship config, renaming..."
    #     Get-Item -Path "$Config\starship.toml" | Move-Item -Destination starship.toml.bak
    # }

    Invoke-RestMethod https://raw.githubusercontent.com/thebananathief/shell-setup/main/starship.toml -o "$Config\starship.toml"
    Write-Host "Starship installed, config at $env:USERPROFILE\.config`n"
}

### PowerShell ###
function Install-Pwsh() {
    winget install -e --accept-source-agreements --accept-package-agreements --id Microsoft.PowerShell

    $Documents = (New-Object -ComObject Shell.Application).NameSpace('shell:Personal').Self.Path

    # Detect Version of Powershell & Create Profile directories if they do not exist.
    if ($PSVersionTable.PSEdition -eq "Core" ) { 
        if (!(Test-Path -Path "$Documents\Powershell" -PathType Container)) {
            New-Item -Path "$Documents\Powershell" -ItemType "directory"
        }
    }
    elseif ($PSVersionTable.PSEdition -eq "Desktop") {
        if (!(Test-Path -Path "$Documents\WindowsPowerShell" -PathType Container)) {
            New-Item -Path "$Documents\WindowsPowerShell" -ItemType "directory"
        }
    }

    # Keep old profile
    # if (Test-Path -Path $PROFILE -PathType Leaf) {
    #     Write-Host "Found an existing PowerShell profile, renaming..."
    #     Get-Item -Path $PROFILE | Move-Item -Destination Microsoft.PowerShell_profile.ps1.bak
    # }

    Invoke-RestMethod https://raw.githubusercontent.com/thebananathief/shell-setup/main/Microsoft.PowerShell_profile.ps1 -o $PROFILE
    Write-Host "PowerShell Core installed, this terminal's profile is at $PROFILE`n"
}

### WindowsTerminal ###
function Install-WT() {
    winget install -e --accept-source-agreements --accept-package-agreements --id Microsoft.WindowsTerminal

    $WTFamilyName = $(Get-AppxPackage | Where-Object Name -eq Microsoft.WindowsTerminal).PackageFamilyName
    $WTData = "$env:LOCALAPPDATA\Packages\$WTFamilyName\LocalState"

    # Keep old config
    # if (Test-Path -Path "$WTData\settings.json" -PathType Leaf) {
    #     Write-Host "Found an existing WindowsTerminal config, renaming..."
    #     Get-Item -Path "$WTData\settings.json" | Move-Item -Destination settings.json.bak
    # }

    Invoke-RestMethod https://raw.githubusercontent.com/thebananathief/shell-setup/main/WindowsTerminal/settings.json -o "$WTData\settings.json"
    Write-Host "WindowsTerminal installed, config at $WTData`n"
}

### Prompts ###
function Install-Prmpt() {
    $Key = $null
    do {
        Write-Host "P = Install oh-my-posh`nS = Install Starship prompt"
        $Key = [System.Console]::ReadKey()
    } while ($Key.Key -notmatch "^P|^S")

    Write-Host
    Switch ($Key.Key) {
        p {
            Install-Posh
        }
        s {
            Install-Starship
        }
    }
}

### Cove NerdFont ###
function Install-CoveNF() {
    $Key = $null
    do {
        Write-Host "Download Cascaydia Cove NerdFont? (Y | N)"
        $Key = [System.Console]::ReadKey()
    } while ($Key.Key -notmatch "^Y|^N")
    
    if ($Key.Key -like 'y') {
        # Font Install
        # You will have to extract and Install this font manually, alternatively use the oh my posh font installer (Must be run as admin)
        # oh-my-posh font install
        # You will also need to set your Nerd Font of choice in your window defaults or in the Windows Terminal Settings.
        $Downloads = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
        Invoke-RestMethod https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip?WT.mc_id=-blog-scottha -o "$Downloads\cove.zip"
        Invoke-Item $Downloads

        # TODO: See if I can install the fonts too
        Write-Host "Cove NerdFont downloaded to $Downloads`n"
    }
}

Install-Pwsh
Install-WT
Install-Prmpt
Install-CoveNF

# Re-initialize the powershell profile
& $profile

Write-Host

Write-Host "If you're missing icons, make sure you download the Cove NerdFont`nFinished! -- Enjoy your pretty terminal!"
# Write-Host "Finished! -- This repository now resides in $env:USERPROFILE\shell-setup"
