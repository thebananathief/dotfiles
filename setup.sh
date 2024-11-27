#!/usr/bin/env sh

RC='\e[0m'
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'

checkEnv() {
    ## Check if the current directory is writable.
    GITPATH="$(dirname "$(realpath "$0")")"
    if [[ ! -w ${GITPATH} ]]; then
        echo -e "${RED}Can't write to ${GITPATH}${RC}"
        exit 1
    fi
}

linkConfig() {
    ## Check if a zshrc file is already there.
    OLD_ZSHRC="${HOME}/.zshrc"
    if [[ -e ${OLD_ZSHRC} ]]; then
        echo -e "${YELLOW}Moving old bash config file to ${HOME}/.zshrc.bak${RC}"
        if ! mv ${OLD_ZSHRC} ${HOME}/.zshrc.bak; then
            echo -e "${RED}Can't move the old zshrc file!${RC}"
            exit 1
        fi
    fi

    echo -e "${YELLOW}Linking new config files...${RC}"
    ## Make symbolic links
    ln -svf ${GITPATH}/.zshrc ${HOME}/.zshrc
    ln -svf ${GITPATH}/.bash_aliases ${HOME}/.bash_aliases
}

checkEnv

if linkConfig; then
    echo -e "${GREEN}Done!\nrestart your shell to see the changes.${RC}"
else
    echo -e "${RED}Something went wrong!${RC}"
fi
