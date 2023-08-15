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
            Set-Location "media-server/infra"
            break}
        "d" {
            Set-Location "dotfiles"
            break}
    }
}

# Git helpers
function gcom {
    git add .
    git commit -m "$args"
}
function gpush {
    git add .
    git commit -m "$args"
    git push
}
function gpull { git pull }
function glog { git log --graph -5 }
function gstat { git status }

function ebrc { edit $PROFILE }

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
if (Test-CommandExists nvim) { $EDITOR='nvim' }
elseif (Test-CommandExists code) { $EDITOR='code' }
elseif (Test-CommandExists codium) { $EDITOR='codium' }
elseif (Test-CommandExists pvim) { $EDITOR='pvim' }
elseif (Test-CommandExists vim) { $EDITOR='vim' }
elseif (Test-CommandExists vi) { $EDITOR='vi' }
elseif (Test-CommandExists sublime_text) { $EDITOR='sublime_text' }
elseif (Test-CommandExists notepad++) { $EDITOR='notepad++' }
elseif (Test-CommandExists notepad) { $EDITOR='notepad' }

if (Test-CommandExists code) { $VISUAL='code' }
elseif (Test-Commandexists codium) { $VISUAL='codium' }

Set-Alias -Name edit -Value $EDITOR
Set-Alias -Name e -Value $EDITOR
Set-Alias -Name vedit -Value $VISUAL
Set-Alias -Name ve -Value $VISUAL
Set-Alias -Name code -Value $VISUAL

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
