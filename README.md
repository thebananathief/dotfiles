# shell-setup
Setup scripts for Linux bash or Windows PowerShell

## Windows
WindowsTerminal may give an error mid-way through. User input required for prompt choice and you need to approve Admin privs for making symbolic links.
```
irm https://raw.githubusercontent.com/thebananathief/shell-setup/stable/setup.ps1?token=GHSAT0AAAAAAB7NOO2NRABMDMKG7BQEQ6SGZAIJHHQ | iex
```
- Install [`scoop`](https://github.com/ScoopInstaller/Scoop)
    - Installs `neovim`, `neofetch`, `JetBrainsMono-NF` via scoop
- Terminal-Icons module
- Installs oh-my-posh or Starship prompt (via scoop), or none
- Install PowerShell Core and configure profile
- Install WindowsTerminal and configure settings

## Linux
```
git clone https://github.com/thebananathief/shell-setup &&\
cd shell-setup &&\
chmod +x ./setup.sh &&\
./setup.sh
```
- Clone this repo to current working directory
- Install Starship prompt and create a link from ~/.config/starship.toml to the repo's
- Create a link from ~/.bashrc to the repo's