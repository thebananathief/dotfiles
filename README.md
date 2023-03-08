# shell-setup
Setup scripts for Linux bash or Windows PowerShell

## Windows
Recommend running this as admin, from any terminal other than WindowsTerminal, as settings get applied to it and pop up a meaningless error.
```
irm https://raw.githubusercontent.com/thebananathief/shell-setup/main/setup.ps1 | iex
```
- Install [`scoop`](https://github.com/ScoopInstaller/Scoop) and `neovim`, `neofetch` using scoop
- Install PowerShell Core and configure profile
- Terminal-Icons module
- Install WindowsTerminal and configure settings
- Installs oh-my-posh or Starship prompt, or none
- Downloads Cove NerdFont

## Linux
```
git clone https://github.com/thebananathief/shell-setup
cd shell-setup
./setup.sh
```
- Clone this repo to current working directory
- Install Starship prompt and create a link from ~/.config/starship.toml to the repo's
- Create a link from ~/.bashrc to the repo's