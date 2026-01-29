
# WSL Arch bootstrap packages
(May need to first look at /etc/wsl.conf)

Base crap
`sudo pacman -Syu`
`sudo pacman -S --noconfirm --needed git base-devel vi`

Yay wrapper for pacman
`git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si`

Rest of packages with yay
`yay -S jq jujutsu ripgrep`

Bun
`curl -fsSL https://bun.sh/install | bash`

Add user to wheel group and authorize for `sudo` impersonation
`usermod -aG wheel cameron && visudo`
