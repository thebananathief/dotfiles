# shell-setup
Setup scripts for Linux bash or Windows PowerShell

## Windows
WindowsTerminal may give an error mid-way through. User input required for prompt choice and you need to approve Admin privs for making symbolic links.
```
git clone https://github.com/thebananathief/shell-setup.git; Set-Location shell-setup; ./setup.ps1
```
- Installs [`scoop`](https://github.com/ScoopInstaller/Scoop)
    - Installs `neovim`, `neofetch`, `JetBrainsMono-NF`, `starship` via scoop
- Terminal-Icons module
- Installs PowerShell Core and configure profile
- Installs WindowsTerminal and configure settings
- Links system's PS profile, WT settings

## Linux
```
git clone https://github.com/thebananathief/shell-setup.git &&\
cd shell-setup &&\
chmod +x ./setup.sh &&\
./setup.sh
```
- Clone this repo to current working directory
- Install Starship prompt and create a link from ~/.config/starship.toml to the repo's
- Create a link from ~/.bashrc to the repo's