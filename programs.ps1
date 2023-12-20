
$GITPATH = $PWD.Path
Write-Host "GITPATH = $GITPATH"

function Install-Programs {
  Install-Module -Name Terminal-Icons -Repository PSGallery
  
  if ((Get-Command scoop) -eq "") {
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
  }

  scoop bucket add nerd-fonts
  scoop bucket add extras
  scoop install neofetch ripgrep win32yank zoxide sudo fzf just yazi eza bottom JetBrainsMono-NF zig tree-sitter universal-ctags sops age

  # https://scoop.sh/#/apps
  # https://winget.run/

  @(  
    # "valinet.ExplorerPatcher",
  #   "wandersick.ChMac",
  #   "IrfanSkiljan.IrfanView",
    "Bitwarden.CLI",
    "Spotify.Spotify",
    "Mega.MEGASync",
    "Playnite.Playnite",
    "tailscale.tailscale"
  ) | ForEach-Object {
      winget install -e --exact --accept-source-agreements --accept-package-agreements --id $_
  }
}

function Install-NeovimPrf {
  # TODO: Ensure git is installed
  # Set-Location "$HOME\Appdata\Local"
  git clone https://github.com/AstroNvim/AstroNvim "$HOME\Appdata\Local\nvim"
  git clone https://github.com/thebananathief/astronvim-user.git "$HOME\Appdata\Local\nvim\lua\user"
}

function Install-NileSoft {
  $nssPath = "$env:ProgramFiles\Nilesoft Shell\shell.nss"
  $insertLine = "import 'imports/custom.nss'"
  $content = Get-Content -Tail 1 $nssPath
  if ($content -ne $insertLine) {

    Add-Content $nssPath $insertLine
  }
}

function Install-Symlinks {
  Write-Host "Creating/updating symbolic links..."
  $WTFamilyName = $(Get-AppxPackage | Where-Object Name -eq Microsoft.WindowsTerminal).PackageFamilyName
  $Cmd = @"
New-Item -ItemType SymbolicLink -Force -Path `"$PROFILE`" -Value `"$GITPATH\Microsoft.PowerShell_profile.ps1`";
New-Item -ItemType SymbolicLink -Force -Path `"$env:LOCALAPPDATA\Packages\$WTFamilyName\LocalState\settings.json`" -Value `"$GITPATH\WindowsTerminal\settings.json`";
New-Item -ItemType SymbolicLink -Force -Path `"$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\Passive.ahk`" -Value `"$GITPATH\Passive.ahk`";
New-Item -ItemType SymbolicLink -Force -Path `"$env:ProgramFiles\Nilesoft Shell\imports\custom.nss`" -Value `"$GITPATH\Nilesoft Shell\custom.nss`";
"@
  # Create the symlinks with admin privs
  # Start-Process -FilePath "pwsh.exe" -Wait -Verb RunAs -ArgumentList "-NoProfile -NoExit -Command '$Cmd'"
  # $GITPATH
  sudo $Cmd
  
  # Print the newly created links to our original terminal
  # Get-Item "$PROFILE"
  # Get-Item "$env:LOCALAPPDATA\Packages\$WTFamilyName\LocalState\settings.json"
  # Get-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\Passive.ahk"
  # Get-Item "$env:ProgramFiles\Nilesoft Shell\imports\custom.nss"
}


# Install-Programs
# Install-NeovimPrf
# Install-NileSoft
Install-SymLinks