# dotfiles
Setup scripts for Linux and Windows (and an option to install extra programs)

## Windows
WindowsTerminal may give an error mid-way through. User input required for prompt choice and you need to approve Admin privs for making symbolic links.
```
git clone https://github.com/thebananathief/shell-setup.git \
Set-Location shell-setup \
./setup.ps1
```
*This will install*
- [`scoop`](https://github.com/ScoopInstaller/Scoop) - `neovim`, `neofetch`, `JetBrainsMono-NF`, `starship`
- Terminal-Icons module
- PowerShell Core and configure profile - profile is symlinked to repo's
- WindowsTerminal and configure settings - settings are symlinked to repo's
- ~/config/starship.toml is symlinked to repo's

NOTE: Administrator privs are only needed for the symlinks

## Linux
```
git clone https://github.com/thebananathief/shell-setup.git &&\
cd shell-setup &&\
chmod +x ./setup.sh &&\
./setup.sh
```
*This will install*
- `starship`, `multitail`, `tree`, `neovim`, `tldr`, `neofetch`, `htop`, `smartmontools`, `ethtool`, `autojump`
- ~/config/starship.toml is symlinked to repo's
- ~/.bashrc is symlinked to repo's
