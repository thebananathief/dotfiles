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

# Git helpers
function gg {
    git add --all
    if ($args.Count -eq 0) {
        git commit -m "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') EST"
    } else {
        git commit -m "$args"
    }
}
function gt {
    git add --all
    if ($args.Count -eq 0) {
        git commit -m "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') EST"
    } else {
        git commit -m "$args"
    }
    git push
}
function ga { git add --all }
function gb { git pull }
function gd { git diff }
function gh { git log --graph -5 }
function gf { git status }

function arc {
    code "$env:USERPROFILE\code\dotfiles"
}
# function vic { edit "$env:USERPROFILE\github\dotfiles\.config\nvim" }
function vic { 
    Push-Location "$env:USERPROFILE\appdata\local\nvim"
    edit .
    Pop-Location
}

function talos { ssh talos }

# Useful shortcuts for traversing directories
function bd { Set-Location - }
function cd.. { Set-Location .. }
function cd... { Set-Location ..\.. }
function cd.... { Set-Location ..\..\.. }
function ll { Get-ChildItem -Force }
function l { Get-ChildItem -Force }
Set-Alias -Name .. -Value cd..
Set-Alias -Name ... -Value cd...
Set-Alias -Name .... -Value cd....

function reload { & $PROFILE }
function tail($file) { tspin -tf $file }
function lun($title) { Get-ChildItem -Recurse -Filter "*$title*" -ErrorAction SilentlyContinue -Force }
function lu($content) { Get-ChildItem -Recurse -ErrorAction SilentlyContinue -Force | Select-String -pattern $content -ErrorAction SilentlyContinue | group path | select name }

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
$env:EDITOR = 'nvim'
$env:VISUAL = 'code'

Set-Alias -Name edit -Value $env:EDITOR
Set-Alias -Name e -Value $env:EDITOR

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

function unzip ($file) {
    Write-Output("Extracting", $file, "to", $pwd)
    $fullFile = Get-ChildItem -Path $pwd -Filter .\cove.zip | ForEach-Object { $_.FullName }
    Expand-Archive -Path $fullFile -DestinationPath $pwd
}

function touch($file) {"" | Out-File $file -Encoding ASCII}
Set-Alias -Name df -Value Get-Volume
function sed($file, $find, $replace) {(Get-Content $file).replace("$find", $replace) | Set-Content $file}
function which($name) {Get-Command $name | Select-Object -ExpandProperty Definition}
function export($name, $value) {Set-Item -Force -Path "env:$name" -Value $value;}
function pkill($name) {Get-Process $name -ErrorAction SilentlyContinue | Stop-Process}
function pgrep($name) {Get-Process $name}


# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

# Starship
Invoke-Expression (& 'C:\Program Files\starship\bin\starship.exe' init powershell --print-full-init | Out-String)

# Zoxide
Invoke-Expression (& { (zoxide init --hook pwd powershell | Out-String) })
# Invoke-Expression (& { (zoxide init powershell | Out-String) })
