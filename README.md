# shell-setup
Setup scripts for Linux bash or Windows PowerShell

## One-liner
### Windows
Recommend running this as admin, from any terminal other than WindowsTerminal, as settings get applied to it and pop up a meaningless error.
```
irm https://raw.githubusercontent.com/thebananathief/shell-setup/main/setup.ps1 | iex
```

### Linux
```
git clone https://github.com/thebananathief/shell-setup
cd shell-setup
./setup.sh
```

## What it does
### setup.ps1
- Install PowerShell Core and configure profile
- Terminal-Icons module
- Install WindowsTerminal and configure settings
- Installs oh-my-posh or Starship prompt, or none
- Downloads Cove NerdFont

### setup.sh
- 