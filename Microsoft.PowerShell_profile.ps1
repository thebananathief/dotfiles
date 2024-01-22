### PowerShell template profile 
### Version 1.03 - Tim Sneath <tim@sneath.org>
### From https://gist.github.com/timsneath/19867b12eee7fd5af2ba
###
### This file should be stored in $PROFILE.CurrentUserAllHosts
### If $PROFILE.CurrentUserAllHosts doesn't exist, you can make one with the following:
###    PS> New-Item $PROFILE.CurrentUserAllHosts -ItemType File -Force
### This will create the file and the containing subdirectory if it doesn't already 
###
### As a reminder, to enable unsigned script execution of local scripts on client Windows, 
### you need to run this line (or similar) from an elevated PowerShell prompt:
###   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
### This is the default policy on Windows Server 2012 R2 and above for server Windows. For 
### more information about execution policies, run Get-Help about_Execution_Policies.

#$ErrorActionPreference = "Stop"

# Import Terminal Icons
Import-Module -Name Terminal-Icons

# Find out if the current user identity is elevated (has admin rights)
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# Github repo shortcuts
function g($repo) {
  Set-Location "$env:USERPROFILE/github"

  switch ($repo) {
    "t" {
      Set-Location "infra"
      break}
    "d" {
      Set-Location "dotfiles"
      break}
    "n" {
      Set-Location "nixdots"
      break}
  }
}

# Git helpers
function gg {
    git add --all
    git commit -m "$args"
}
function gt {
    git add --all
    git commit -m "$args"
    git push
}
function ga { git add --all }
function gb { git pull }
function gd { git diff }
function gh { git log --graph -5 }
function gf { git status }

function arc { edit $PROFILE }
function nic { edit "$env:USERPROFILE\github\nixdots" }
function vic { edit "$env:USERPROFILE\github\dotfiles\.config\nvim" }

# Useful shortcuts for traversing directories
function bd { Set-Location - }
function cd.. { Set-Location .. }
function cd... { Set-Location ..\.. }
function cd.... { Set-Location ..\..\.. }
Set-Alias -Name .. -Value cd..
Set-Alias -Name ... -Value cd...
Set-Alias -Name .... -Value cd....

# Rebind cd
function c {
    param(
        $path
    )
    if (Test-Path $path) {
        $path = Resolve-Path $path
        Set-Location $path
        Get-ChildItem $path
    } else {
        "Could not find path $path"
    }
}

function reload { & $PROFILE }
function tail($file) { tspin -tf $file }
function lun($title) { Get-ChildItem -Recurse -Filter "*$title*" -ErrorAction SilentlyContinue -Force }
function lu($content) { Get-ChildItem -Recurse -ErrorAction SilentlyContinue -Force | Select-String -pattern $content -ErrorAction SilentlyContinue | group path | select name }

# Compute file hashes - useful for checking successful downloads 
function md5 { Get-FileHash -Algorithm MD5 $args }
function sha1 { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }

# Quick shortcut to start notepad
function n { notepad $args }

# Drive shortcuts
function HKLM: { Set-Location HKLM: }
function HKCU: { Set-Location HKCU: }
function Env: { Set-Location Env: }

# Creates drive shortcut for Work Folders, if current user account is using it
if (Test-Path "$env:USERPROFILE\Work Folders") {
    New-PSDrive -Name Work -PSProvider FileSystem -Root "$env:USERPROFILE\Work Folders" -Description "Work Folders"
    function Work: { Set-Location Work: }
}

# Set up command prompt and window title. Use UNIX-style convention for identifying 
# whether user is elevated (root) or not. Window title shows current version of PowerShell
# and appends [ADMIN] if appropriate for easy taskbar identification
function prompt { 
    if ($isAdmin) {
        "[" + (Get-Location) + "] # " 
    } else {
        "[" + (Get-Location) + "] $ "
    }
}

$Host.UI.RawUI.WindowTitle = "PowerShell {0}" -f $PSVersionTable.PSVersion.ToString()
if ($isAdmin) {
    $Host.UI.RawUI.WindowTitle += " [ADMIN]"
}

# Does the the rough equivalent of dir /s /b. For example, dirs *.png is dir /s /b *.png
function dirs {
    if ($args.Count -gt 0) {
        Get-ChildItem -Recurse -Include "$args" | Foreach-Object FullName
    } else {
        Get-ChildItem -Recurse | Foreach-Object FullName
    }
}

# Simple function to start a new elevated process. If arguments are supplied then 
# a single command is started with admin rights; if not then a new admin instance
# of PowerShell is started.
function admin {
    $shell = "powershell.exe"
    if (Test-CommandExists wt) { $shell = "wt.exe" }
    elseif (Test-CommandExists pwsh) { $shell = "pwsh.exe" }

    if ($args.Count -gt 0) {   
        $argList = "& '" + $args + "'"
        Start-Process "$shell" -Verb runAs -ArgumentList $argList
    } else {
        Start-Process "$shell" -Verb runAs
    }
}

# Set UNIX-like aliases for the admin command, so sudo <command> will run the command
# with elevated rights. 
Set-Alias -Name su -Value admin
# Use scoop's sudo package
# Set-Alias -Name sudo -Value admin

# We don't need these any more; they were just temporary variables to get to $isAdmin. 
# Delete them to prevent cluttering up the user profile. 
Remove-Variable identity
Remove-Variable principal

Function Test-CommandExists {
    Param ($command)
    $oldPreference = $ErrorActionPreference
    $ErrorActionPreference = 'SilentlyContinue'
    try { if (Get-Command $command) { RETURN $true } }
    Catch { Write-Host "$command does not exist"; RETURN $false }
    Finally { $ErrorActionPreference = $oldPreference }
} 

# If your favorite editor is not here, add an elseif and ensure that the directory it is installed in exists in your $env:Path
$EDITOR = 'nvim'
$VISUAL = 'code'
if (Test-CommandExists nvim) { $EDITOR='nvim' }
elseif (Test-CommandExists code) { $EDITOR='code' ; $VISUAL='code' }
elseif (Test-CommandExists codium) { $EDITOR='codium' ; $VISUAL='codium' }
elseif (Test-CommandExists sublime_text) { $EDITOR='sublime_text' ; $VISUAL='sublime_text' }
elseif (Test-CommandExists notepad++) { $EDITOR='notepad++' ; $VISUAL='notepad++' }
elseif (Test-CommandExists notepad) { $EDITOR='notepad' ; $VISUAL='notepad' }

Set-Alias -Name edit -Value $EDITOR
Set-Alias -Name e -Value $EDITOR
# Set-Alias -Name code -Value $VISUAL

function Get-PubIP {
    Write-Host "External IP: "(Invoke-WebRequest http://ifconfig.me/ip).Content
}
Set-Alias -Name getip -Value Get-PubIP
function uptime {
    #Windows Powershell    
    # Get-WmiObject win32_operatingsystem | Select-Object csname, @{
    #     LABEL      = 'LastBootUpTime';
    #     EXPRESSION = { $_.ConverttoDateTime($_.lastbootuptime) }
    # }

    #Powershell Core / Powershell 7+ (Uncomment the below section and comment out the above portion)
    $bootUpTime = Get-WmiObject win32_operatingsystem | Select-Object lastbootuptime
    $plusMinus = $bootUpTime.lastbootuptime.SubString(21,1)
    $plusMinusMinutes = $bootUpTime.lastbootuptime.SubString(22, 3)
    $hourOffset = [int]$plusMinusMinutes/60
    $minuteOffset = 00
    if ($hourOffset -contains '.') { $minuteOffset = [int](60*[decimal]('.' + $hourOffset.ToString().Split('.')[1]))}       
        if ([int]$hourOffset -lt 10 ) { $hourOffset = "0" + $hourOffset + $minuteOffset.ToString().PadLeft(2,'0') } else { $hourOffset = $hourOffset + $minuteOffset.ToString().PadLeft(2,'0') }
    $leftSplit = $bootUpTime.lastbootuptime.Split($plusMinus)[0]
    $upSince = [datetime]::ParseExact(($leftSplit + $plusMinus + $hourOffset), 'yyyyMMddHHmmss.ffffffzzz', $null)
    Get-WmiObject win32_operatingsystem | Select-Object @{LABEL='Machine Name'; EXPRESSION={$_.csname}}, @{LABEL='Last Boot Up Time'; EXPRESSION={$upsince}}

    #Works for Both (Just outputs the DateTime instead of that and the machine name)
    # net statistics workstation | Select-String "since" | foreach-object {$_.ToString().Replace('Statistics since ', '')}
}
function find-file($name) {
    Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        $place_path = $_.directory
        Write-Output "${place_path}\${_}"
    }
}
function unzip ($file) {
    Write-Output("Extracting", $file, "to", $pwd)
    $fullFile = Get-ChildItem -Path $pwd -Filter .\cove.zip | ForEach-Object { $_.FullName }
    Expand-Archive -Path $fullFile -DestinationPath $pwd
}
function grep($regex, $dir) {
    if ( $dir ) {
        Get-ChildItem $dir | select-string $regex
        return
    }
    $input | select-string $regex
}
function touch($file) {"" | Out-File $file -Encoding ASCII}
function df {get-volume}
function sed($file, $find, $replace) {(Get-Content $file).replace("$find", $replace) | Set-Content $file}
function which($name) {Get-Command $name | Select-Object -ExpandProperty Definition}
function export($name, $value) {Set-Item -Force -Path "env:$name" -Value $value;}
function pkill($name) {Get-Process $name -ErrorAction SilentlyContinue | Stop-Process}
function pgrep($name) {Get-Process $name}

# Set prompt for prettiness
Invoke-Expression (&starship init powershell)
# oh-my-posh init pwsh --config "~\AppData\Local\Programs\oh-my-posh\themes\talos.omp.json" | Invoke-Expression

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

# =============================================================================
#
# Utility functions for zoxide.
#

# Call zoxide binary, returning the output as UTF-8.
function global:__zoxide_bin {
    $encoding = [Console]::OutputEncoding
    try {
        [Console]::OutputEncoding = [System.Text.Utf8Encoding]::new()
        $result = zoxide @args
        return $result
    } finally {
        [Console]::OutputEncoding = $encoding
    }
}

# pwd based on zoxide's format.
function global:__zoxide_pwd {
    $cwd = Get-Location
    if ($cwd.Provider.Name -eq "FileSystem") {
        $cwd.ProviderPath
    }
}

# cd + custom logic based on the value of _ZO_ECHO.
function global:__zoxide_cd($dir, $literal) {
    $dir = if ($literal) {
        Set-Location -LiteralPath $dir -Passthru -ErrorAction Stop
    } else {
        if ($dir -eq '-' -and ($PSVersionTable.PSVersion -lt 6.1)) {
            Write-Error "cd - is not supported below PowerShell 6.1. Please upgrade your version of PowerShell."
        }
        elseif ($dir -eq '+' -and ($PSVersionTable.PSVersion -lt 6.2)) {
            Write-Error "cd + is not supported below PowerShell 6.2. Please upgrade your version of PowerShell."
        }
        else {
            Set-Location -Path $dir -Passthru -ErrorAction Stop
        }
    }
}

# =============================================================================
#
# Hook configuration for zoxide.
#

# Hook to add new entries to the database.
$global:__zoxide_oldpwd = __zoxide_pwd
function global:__zoxide_hook {
    $result = __zoxide_pwd
    if ($result -ne $global:__zoxide_oldpwd) {
        if ($null -ne $result) {
            zoxide add -- $result
        }
        $global:__zoxide_oldpwd = $result
    }
}

# Initialize hook.
$global:__zoxide_hooked = (Get-Variable __zoxide_hooked -ErrorAction SilentlyContinue -ValueOnly)
if ($global:__zoxide_hooked -ne 1) {
    $global:__zoxide_hooked = 1
    $global:__zoxide_prompt_old = $function:prompt

    function global:prompt {
        if ($null -ne $__zoxide_prompt_old) {
            & $__zoxide_prompt_old
        }
        $null = __zoxide_hook
    }
}

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

# Jump to a directory using only keywords.
function global:__zoxide_z {
    if ($args.Length -eq 0) {
        __zoxide_cd ~ $true
    }
    elseif ($args.Length -eq 1 -and ($args[0] -eq '-' -or $args[0] -eq '+')) {
        __zoxide_cd $args[0] $false
    }
    elseif ($args.Length -eq 1 -and (Test-Path $args[0] -PathType Container)) {
        __zoxide_cd $args[0] $true
    }
    else {
        $result = __zoxide_pwd
        if ($null -ne $result) {
            $result = __zoxide_bin query --exclude $result -- @args
        }
        else {
            $result = __zoxide_bin query -- @args
        }
        if ($LASTEXITCODE -eq 0) {
            __zoxide_cd $result $true
        }
    }
}

# Jump to a directory using interactive search.
function global:__zoxide_zi {
    $result = __zoxide_bin query -i -- @args
    if ($LASTEXITCODE -eq 0) {
        __zoxide_cd $result $true
    }
}

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

Set-Alias -Name z -Value __zoxide_z -Option AllScope -Scope Global -Force
Set-Alias -Name zi -Value __zoxide_zi -Option AllScope -Scope Global -Force

# =============================================================================
#
# To initialize zoxide, add this to your configuration (find it by running
# `echo $profile` in PowerShell):
#
# Invoke-Expression (& { (zoxide init powershell | Out-String) })
