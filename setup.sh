#!/usr/bin/env sh

RC='\e[0m'
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'

checkEnv() {
    ## Check if the current directory is writable.
    GITPATH="$(dirname "$(realpath "$0")")"
    if [ ! -w ${GITPATH} ]; then
        echo -e "${RED}Can't write to ${GITPATH}${RC}"
        exit 1
    fi

    # Check if ZSH is installed
    if ! command -v zsh >/dev/null 2>&1; then
        echo -e "${RED}ZSH must be installed!${RC}"
        exit 1
    fi

    # Check if oh-my-zsh is installed
    if [ ! -d "$ZSH" ]; then
        echo -e "${RED}oh-my-zsh must be installed!${RC}"
        echo -e "URL: https://ohmyz.sh/#install"
        echo -e 'CMD: sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
        exit 1
    fi
}

installPlugins() {
    git clone https://github.com/zsh-users/zsh-autosuggestions.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
    git clone https://github.com/marlonrichert/zsh-autocomplete.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
}

linkConfig() {
    ## Check if a zshrc file is already there.
    OLD_ZSHRC="${HOME}/.zshrc"
    if [ -e ${OLD_ZSHRC} ]; then
        echo -e "${YELLOW}Moving old bash config file to ${HOME}/.zshrc.bak${RC}"
        if ! mv ${OLD_ZSHRC} ${HOME}/.zshrc.bak; then
            echo -e "${RED}Can't move the old zshrc file!${RC}"
            exit 1
        fi
    fi

    echo -e "${YELLOW}Linking new config files...${RC}"
    ## Make symbolic links
    ln -sv ${GITPATH}/.zshrc ${HOME}/.zshrc
    # ln -sv ${GITPATH}/.shell_aliases ${HOME}/.shell_aliases
    ln -sv ${GITPATH}/.shell_aliases ${HOME}/.oh-my-zsh/custom/profile.zsh
}

checkEnv
installPlugins

if linkConfig; then
    echo -e "${GREEN}Done!\nRestart your shell to see the changes.${RC}"
fi
