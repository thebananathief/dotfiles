#!/bin/bash
iatest=$(expr index "$-" i)

# These are loaded automatically by the shell
# Source global definitions
# if [ -f /etc/bash.bashrc ]; then
# 	 . /etc/bash.bashrc
# fi

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Disable the bell
if [[ $iatest -gt 0 ]]; then bind "set bell-style visible"; fi

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest -gt 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest -gt 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# HANDLED IN /etc/bash.bashrc
# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

# Allow ctrl-S for history navigation (with ctrl-R)
[[ $- == *i* ]] && stty -ixon

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Expand the history size
export HISTFILESIZE=10000
export HISTSIZE=500

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
#export GREP_OPTIONS='--color=auto' #deprecated
#alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#######################################################
# MACHINE SPECIFIC ALIAS'S
#######################################################

# Alias's for SSH
# alias SERVERNAME='ssh YOURWEBSITE.com -l USERNAME -p PORTNUMBERHERE'

# Git helpers
gg() {
	git add --all
	git commit -m "$1"
}
gt() {
	git add --all
	git commit -m "$1"
	git push
}
alias ga='git add --all'
alias gb='git pull'
alias gd='git diff'
alias gh='git log --graph -5'
alias gf='git status'

alias agi='sudo apt install $c'
alias agr='sudo apt remove $c'
alias agu='sudo apt update && sudo apt upgrade'

alias nic='sudoedit /etc/nixos/configuration.nix'
alias nis='sudo nixos-rebuild switch'
alias nip='nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq'
alias hyc='edit ~/.config/hypr'
alias vic='edit ~/.config/nvim'

# alias web='cd /var/www/html'
# alias tdev='cd "/mnt/c/Users/github/media-server/infra/provision"'
# alias stor='cd "/mnt/storage"'
# alias appd='cd "/opt/appdata"'

alias bd='cd -'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

function g() {
  cd "$HOME/github"

  case $@ in
    "d")
      cd "dotfiles"
    ;;
    "t")
      cd "infra"
    ;;
  esac
}

# Alias's to mount ISO files
# mount -o loop /home/NAMEOFISO.iso /home/ISOMOUNTDIR/
# umount /home/NAMEOFISO.iso
# (Both commands done as root only.)

#######################################################
# GENERAL ALIAS'S
#######################################################
# To temporarily bypass an alias, we precede the command with a \
# EG: the ls command is aliased, but to use the normal ls command you would type \ls

# Systemctl shortened commands
alias scup='sudo systemctl start $c'
alias scdown='sudo systemctl stop $c'
alias scstat='sudo systemctl status $c'
alias screst='sudo systemctl restart $c'
alias sc='sudo systemctl $c'

# Edit common files
alias ebrc='edit ~/.bashrc'
alias sebrc='sudoedit /etc/bash.bashrc'
alias esmb='sudoedit /etc/samba/smb.conf'

# Alias's to modified commands
alias cp='cp -i'
alias mv='mv -i'
#alias rm='trash -v'
alias mkdir='mkdir -p'
#alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'
alias multitail='multitail --no-repeat -c'
alias freshclam='sudo freshclam'
alias dup='alacritty --working-directory "$(pwd)" &'

# Allows aliases to be used after sudo
alias sudo='sudo '

# Remove a directory and all files
alias rmd='/bin/rm  --recursive --force --verbose '

# Alias's for multiple directory listing commands
alias ls='ls -AFh --color=always' # add colors and file type extensions
alias lx='ls -lXBh' # sort by extension
alias lk='ls -lSrh' # sort by size
alias lc='ls -lcrh' # sort by change time
alias lu='ls -lurh' # sort by access time
alias lr='ls -lRh' # recursive ls
alias lt='ls -ltrh' # sort by date
alias lw='ls -xAh' # wide listing format
alias ll='ls -Fls' # long listing format
alias labc='ls -lAp' #alphabetical sort
alias lf="ls -l | egrep -v '^d'" # files only
alias ldir="ls -l | egrep '^d'" # directories only

# Search running processes
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Search files in the current folder
alias f="find . | grep "

# Count all files (recursively) in the current folder
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"

# Show open ports
alias openports='netstat -nape --inet'

# Alias's to show disk space and space used in a folder
alias diskspace="du -Sh | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias dff='df -hT | sort -d'

# Searches for text in all files in the current folder
ftext () {
	# -i case-insensitive
	# -I ignore binary files
	# -H causes filename to be printed
	# -r recursive search
	# -n causes line number to be printed
	# optional: -F treat search term as a literal, not a regular expression
	# optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
	grep -iIHrn --color=always "$1" . | less -r
}

# Copy and go to the directory
cpg () {
	if [ -d "$2" ];then
		cp "$1" "$2" && cd "$2"
	else
		cp "$1" "$2"
	fi
}

# Move and go to the directory
mvg () {
	if [ -d "$2" ];then
		mv "$1" "$2" && cd "$2"
	else
		mv "$1" "$2"
	fi
}

# Create and go to the directory
mkdirg () {
	mkdir -p "$1"
	cd "$1"
}

# Goes up a specified number of directories  (i.e. up 4)
up () {
	local d=""
	limit=$1
	for ((i=1 ; i <= limit ; i++))
		do
			d=$d/..
		done
	d=$(echo $d | sed 's/^\///')
	if [ -z "$d" ]; then
		d=..
	fi
	cd $d
}

#Automatically do an ls after each cd
# cd () {
# 	if [ -n "$1" ]; then
# 		builtin cd "$@" && ls
# 	else
# 		builtin cd ~ && ls
# 	fi
# }

# IP address lookup
function getip () {
	echo -n "External IP: " ; curl http://ifconfig.me/ip
}