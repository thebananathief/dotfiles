# Winget info: https://learn.microsoft.com/en-us/windows/package-manager/winget/
# Stolen from: https://github.com/ChrisTitusTech/powershell-profile
# irm https://raw.githubusercontent.com/thebananathief/shell-setup/stable/setup.ps1?token=GHSAT0AAAAAAB7NOO2NRABMDMKG7BQEQ6SGZAIJHHQ | iex

$GITPATH = $PWD.Path
Write-Host "GITPATH = $GITPATH"

### Package Managers ###
function Install-PkgMngrs {
    Write-Host "----- SCOOP -----"

    # This is what I used for "descending" a prompt
    # $ScriptBlock = {Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression; `
    #     scoop bucket add nerd-fonts; `
    #     scoop install neofetch neovim JetBrainsMono-NF}

    # & runas /trustlevel:0x20000 "pwsh -NoExit -NoProfile -NonInteractive -Command $ScriptBlock"

    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

    # Need to start another instance because this script uses exits
    powershell -Command {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh'))}
    $env:PATH += ";$HOMEPATH\scoop\shims"
    scoop bucket add nerd-fonts
    scoop bucket add extras
    scoop install neofetch python just win32yank

    # main/ vagrant
    # nerdfonts/ JetBrainsMono-NF, DroidSansMono, Cascadia Code, MesloLG
    # sysinternals/ autoruns
    # extras/ autohotkey, advanced ip scanner, everything, firefox

    Write-Host
    Write-Host "----- CHOCOLATEY -----"
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

function Install-Starship {
    Write-Host "----- STARSHIP -----"
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

    # Invoke-RestMethod https://raw.githubusercontent.com/thebananathief/shell-setup/stable/starship.toml?token=GHSAT0AAAAAAB7NOO2NATXAWRXYTEG3P4F4ZAID33A -o "$Config\starship.toml"
    Write-Host "Starship installed"
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

    # Invoke-RestMethod https://raw.githubusercontent.com/thebananathief/shell-setup/stable/Microsoft.PowerShell_profile.ps1?token=GHSAT0AAAAAAB7NOO2NATXAWRXYTEG3P4F4ZAID33A -o $PROFILE
    Write-Host "PowerShell Core installed"
}

### WindowsTerminal ###
function Install-WT {
    Write-Host "----- WINDOWS TERMINAL -----"

    winget install -e --accept-source-agreements --accept-package-agreements --id Microsoft.WindowsTerminal

    # Keep old config
    # if (Test-Path -Path "$WTData\settings.json" -PathType Leaf) {
    #     Write-Host "Found an existing WindowsTerminal config, renaming..."
    #     Get-Item -Path "$WTData\settings.json" | Move-Item -Destination settings.json.bak
    # }

    # Invoke-RestMethod https://raw.githubusercontent.com/thebananathief/shell-setup/stable/WindowsTerminal/settings.json?token=GHSAT0AAAAAAB7NOO2NATXAWRXYTEG3P4F4ZAID33A -o "$WTData\settings.json"
    Write-Host "WindowsTerminal installed"
}

function Install-Extras {
    if ((Read-Host -Prompt "Install bootstrap programs? (y)") -ne "y") {
        return
    }

    @(  
      # system / desktop tweaks
      # "valinet.ExplorerPatcher",
      "Nilesoft.Shell",
      # CLI
      "Bitwarden.CLI",
      "Neovim.Neovim",
      "wandersick.ChMac",
      # Multi-media
      "IrfanSkiljan.IrfanView",
      "VideoLAN.VLC",
      "Spotify.Spotify",
      "Audacity.Audacity",
      # General
      "Mozilla.Firefox",
      "Discord.Discord",
      "Mega.MEGASync",
      "Obsidian.Obsidian",
      "M2Team.NanaZip",
      "VSCodium.VSCodium",
      "NordSecurity.NordVPN",
      "Parsec.Parsec",
      "Famatech.AdvancedIPScanner",
      "VMware.WorkstationPlayer",
      "WinDirStat.WinDirStat",
      "tailscale.tailscale"
    ) | ForEach-Object {
        winget install -e --exact --accept-source-agreements --accept-package-agreements --id $_
    }

    if ((Read-Host -Prompt "Install Steam and Playnite? (y)") -ne "y") {
        return
    }
    @(  "Valve.Steam",
        "Playnite.Playnite"
    ) | ForEach-Object {
        winget install -e --accept-source-agreements --accept-package-agreements --id $_
    }
}

# Install everything
Install-PkgMngrs
Write-Host
Install-Starship
Write-Host
Install-Pwsh
Write-Host
Install-WT
Write-Host
#Install-Extras
Write-Host

Write-Host "Creating/updating symbolic links..."
$WTFamilyName = $(Get-AppxPackage | Where-Object Name -eq Microsoft.WindowsTerminal).PackageFamilyName
$Cmd =  @"
New-Item -ItemType SymbolicLink -Force -Path `"$env:USERPROFILE\.config\starship.toml`" -Value `"$GITPATH\.config\starship.toml`";
New-Item -ItemType SymbolicLink -Force -Path `"$PROFILE`" -Value `"$GITPATH\Microsoft.PowerShell_profile.ps1`";
New-Item -ItemType SymbolicLink -Force -Path `"$env:LOCALAPPDATA\Packages\$WTFamilyName\LocalState\settings.json`" -Value `"$GITPATH\WindowsTerminal\settings.json`";
New-Item -ItemType SymbolicLink -Force -Path `"$env:LOCALAPPDATA\nvim`" -Value `"$GITPATH\.config\nvim`"
"@
# Create the symlinks with admin privs
Start-Process -FilePath "pwsh.exe" -Wait -Verb RunAs -ArgumentList "-NoProfile -Command `"$Cmd`""
# Print the newly created links to our original terminal
Get-Item "$env:USERPROFILE\.config\starship.toml",
"$PROFILE",
"$env:LOCALAPPDATA\Packages\$WTFamilyName\LocalState\settings.json",
"$env:LOCALAPPDATA\nvim"

# Re-initialize the powershell profile
& $profile

Write-Host
Write-Host "Finished! - restart your terminal"
