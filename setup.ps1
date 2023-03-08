# Winget info: https://learn.microsoft.com/en-us/windows/package-manager/winget/
# Stolen from: https://github.com/ChrisTitusTech/powershell-profile

### Chocolatey ###
# Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

### Scoop ###
function Install-Scoop {
    Write-Host "----- SCOOP -----"

    # $ScriptBlock = {Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression; `
    #     scoop bucket add nerd-fonts; `
    #     scoop install neofetch neovim JetBrainsMono-NF}

    # & runas /trustlevel:0x20000 "pwsh -NoExit -NoProfile -NonInteractive -Command $ScriptBlock"

    Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
    scoop bucket add nerd-fonts
    scoop install neofetch neovim

    # main/ vagrant
    # nerdfonts/ JetBrainsMono-NF, DroidSansMono, Cascadia Code, MesloLG
    # sysinternals/ autoruns
    # extras/ autohotkey, advanced ip scanner, everything, firefox
}

function Install-Posh {
    # winget install -e --accept-source-agreements --accept-package-agreements --id JanDeDobbeleer.OhMyPosh
    scoop install oh-my-posh JetBrainsMono-NF

    # TODO: Install posh config
    Write-Host "oh-my-posh was installed"
}

function Install-Starship {
    # winget install -e --accept-source-agreements --accept-package-agreements --id Starship.Starship
    scoop install starship JetBrainsMono-NF

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
function Install-Pwsh {
    Write-Host "----- POWERSHELL -----"

    # Terminal Icons
    Install-Module -Name Terminal-Icons -Repository PSGallery

    # Powershell Windows Update
    # Install-Module -Name PSWindowsUpdate
    # Add-WUServiceManager -MicrosoftUpdate

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
function Install-WT {
    Write-Host "----- WINDOWS TERMINAL -----"

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
function Install-Prmpt {
    Write-Host "----- PROMPT -----"

    $Key = $null
    do {
        Write-Host "P = Install oh-my-posh`nS = Install Starship prompt`nN = Skip prompt setup"
        $Key = [System.Console]::ReadKey()
    } while ($Key.Key -notmatch "^P|^S|^N")

    Write-Host
    Switch ($Key.Key) {
        p {
            Install-Posh
        }
        s {
            Install-Starship
        }
        n {}
    }
}

### Cove NerdFont ###
function Install-CoveNF {
    Write-Host "----- NERDFONT -----"

    $Key = $null
    do {
        Write-Host "Download Cascaydia Cove NerdFont? (Y | N)"
        $Key = [System.Console]::ReadKey()
    } while ($Key.Key -notmatch "^Y|^N")
    
    if ($Key.Key -like 'y') {
        # You will have to extract and Install this font manually, alternatively use the oh my posh font installer (Must be run as admin)
        # You will also need to set your Nerd Font of choice in your window defaults or in the Windows Terminal Settings.
        $Downloads = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
        Invoke-RestMethod https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip?WT.mc_id=-blog-scottha -o "$Downloads\cove.zip"
        Expand-Archive -LiteralPath "$Downloads\cove.zip" -DestinationPath "$Downloads\CoveNF"
        Remove-Item -Path "$Downloads\cove.zip"
        
        Invoke-Item $Downloads
        Write-Host "Cove NerdFont downloaded to $Downloads`n"
    }
}

# if (([bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544"))) {
    Install-Scoop
    Install-Pwsh
    Install-Prmpt
    # Install-CoveNF
    Install-WT

    # Re-initialize the powershell profile
    & $profile
    
    Write-Host "`nFinished! -- Enjoy your pretty terminal!"
    Write-Host "If you're missing icons, make sure you download the Cove NerdFont"
# } else {
#     Write-Host "You should run this script in an admin terminal!"
    # throw "Script needs to be ran as admin"
# }
