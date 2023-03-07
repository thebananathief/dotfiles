# Winget info: https://learn.microsoft.com/en-us/windows/package-manager/winget/

function Install-Font {  
    param  
    (  
        [System.IO.FileInfo]$fontFile  
    )  
          
    try { 
        #get font name
        $gt = [Windows.Media.GlyphTypeface]::new($fontFile.FullName)
        $family = $gt.Win32FamilyNames['en-us']
        if ($null -eq $family) { $family = $gt.Win32FamilyNames.Values.Item(0) }
        $face = $gt.Win32FaceNames['en-us']
        if ($null -eq $face) { $face = $gt.Win32FaceNames.Values.Item(0) }
        $fontName = ("$family $face").Trim() 
            
        switch ($fontFile.Extension) {  
            ".ttf" {$fontName = "$fontName (TrueType)"}  
            ".otf" {$fontName = "$fontName (OpenType)"}  
        }  

        write-host "Installing font: $fontFile with font name '$fontName'"

        If (!(Test-Path ("$($env:windir)\Fonts\" + $fontFile.Name))) {  
            write-host "Copying font: $fontFile"
            Copy-Item -Path $fontFile.FullName -Destination ("$($env:windir)\Fonts\" + $fontFile.Name) -Force 
        } else {  write-host "Font already exists: $fontFile" }

        If (!(Get-ItemProperty -Name $fontName -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -ErrorAction SilentlyContinue)) {  
            write-host "Registering font: $fontFile"
            New-ItemProperty -Name $fontName -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -PropertyType string -Value $fontFile.Name -Force -ErrorAction SilentlyContinue | Out-Null  
        } else {  write-host "Font already registered: $fontFile" }
            
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($oShell) | out-null 
        Remove-Variable oShell
    } catch {
        write-host "Error installing font: $fontFile. " $_.exception.message
    }
}

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
    Write-Host "----- POWERSHELL -----"

    # Terminal Icons
    Install-Module -Name Terminal-Icons -Repository PSGallery

    # Powershell Windows Update
    Install-Module -Name PSWindowsUpdate
    Add-WUServiceManager -MicrosoftUpdate

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
function Install-Prmpt() {
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
function Install-CoveNF() {
    Write-Host "----- NERDFONT -----"

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
        Expand-Archive -LiteralPath "$Downloads\cove.zip" -DestinationPath "$Downloads\CoveNF"

        #Loop through fonts in the same directory as the script and install/uninstall them
        foreach ($FontItem in (Get-ChildItem -Path "$Downloads\CoveNF" | Where-Object {$_.Name -match '.+\.ttf|.+\.otf'})) {  
            Install-Font -fontFile $FontItem.FullName  
        }
        
        Invoke-Item $Downloads
        Write-Host "Cove NerdFont downloaded to $Downloads`n"
    }
}

Install-Pwsh
Install-WT
Install-Prmpt
Install-CoveNF

# Re-initialize the powershell profile
& $profile

Write-Host "`nFinished! -- Enjoy your pretty terminal!"
Write-Host "If you're missing icons, make sure you download the Cove NerdFont"
# Write-Host "Finished! -- This repository now resides in $env:USERPROFILE\shell-setup"
