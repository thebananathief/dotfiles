immich (){
	case $1 in
		up) sudo systemctl start docker-immich-{ml,server,microservices,postgres,redis} ;;
	down) sudo systemctl stop docker-immich-{ml,server,microservices,postgres,redis} ;;
		 *) echo "type down or up" ;;
	esac
}

# Find nix package location and copy
np (){
  file=$( eza --color=never -D /nix/store | fzf --preview='tree /nix/store/{}')
  echo "/nix/store/$file"
  echo "/nix/store/$file" | wl-copy
}
npy (){
  file=$( eza --color=never -D /nix/store | fzf --preview='tree /nix/store/{}')
  echo "/nix/store/$file" | wl-copy
  yazi "/nix/store/$file"
}

# Copy path
cpl (){
  echo "$PWD/$1"
  echo "$PWD/$1" | wl-copy
}

# Quick SSH
alias talos='ssh talos'

alias lsgpu='sudo intel_gpu_top'

# Copy font
# fontc (){
#   font=$(fc-list : file family style | fzf --preview 'ueberzugpp {1}')
#   echo $font
#   $font | wl-copy
# }
alias fonts='yad --font | wl-copy'

# Quick edit shell configs
alias vic='edit ~/.config/nvim/lua/user'
alias zrc='edit ~/.zshrc'
alias brc='edit ~/.bashrc'
alias arc='edit ~/.bash_aliases'
alias rbrc='sudoedit /etc/bash.bashrc'

# Quick NIX actions
# alias nic='sudo -E nvim ~/github/nixdots'
alias nic='edit ~/github/nixdots'
alias nis='sudo nixos-rebuild switch'
alias gnis='cd ~/github/nixdots && gb && nis'
alias nib='sudo nixos-rebuild boot'
alias nip="nix-build '<nixpkgs>' --no-build-output -A"

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Systemctl shortened commands
alias sc='systemctl'
alias scf='systemctl list-units --failed'
alias rhit='systemctl reboot'
alias shit='systemctl poweroff'

# Alias to show the date
alias da='date "+%Y-%m-%d %A %T %Z"'

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
alias rg='rg -S'
alias j='just'


# Allows aliases to be used after sudo
alias sudo='sudo '
alias adm='sudo -s'

# Remove a directory and all files
alias rmd='rm  --recursive --force --verbose '
# Neovim's swap directory which annoys me sometimes
alias vds='rm -f ~/.local/state/nvim/swap/*'

# alias ls="ls -AFh --color=always" # add colors and file type extensions
# alias lx="ls -lXBh" # sort by extension
# alias lk="ls -lSrh" # sort by size
# alias lc="ls -lcrh" # sort by change time
# alias lu="ls -lurh" # sort by access time
# alias lr="ls -lRh" # recursive ls
# alias lt="ls -ltrh" # sort by date
# alias lw="ls -xAh" # wide listing format
# alias ll="ls -Fls" # long listing format
# alias labc="ls -lAp" #alphabetical sort
# alias ldir="ls -l | egrep '^d'" # directories only
# alias lf="ls -l | egrep -v '^d'" # files only
alias cd..='cd ..'
alias cd...='cd ...'
alias cd....='cd ....'
alias lf="yazi"
alias ii='thunar'

# alias chmod commands
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Count all files (recursively) in the current folder
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"

command_exists () {
    command -v $1 >/dev/null 2>&1;
}

# Show open ports
alias openports='netstat -nape --inet'

# Alias's to show disk space and space used in a folder
alias dff='df --output=target,source,fstype,size,used,avail,pcent -h | (sed -u 1q; sort -k 1,1)'
alias diskspace="du -Sh | sort -nr | more"
alias folders='du -h -d1 | sort -hr'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'

# Alias's for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# Show all logs in /var/log
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"
log () {
	journalctl -u $1.service -f | tspin
}
alias loga='journalctl -u $1.service | tspin'
alias tailf="tspin -f"

# KITTY - alias to be able to use kitty features when
# connecting to remote servers(e.g use tmux on remote server)
alias kssh="kitty +kitten ssh"

alias e='edit'
alias sedit='sudo -E edit'
alias se='sedit'
# "sudoedit" is also a command provided by sudo to launch your
# default editor and safely edit a read-only file

#######################################################
# SPECIAL FUNCTIONS
#######################################################

# Universal text editor functions
edit () {
  $EDITOR "$@"
}

# Extracts any archive(s) (if unp isn't installed)
extract () {
	for archive in "$@"; do
		if [ -f "$archive" ] ; then
			case $archive in
				*.tar.bz2)   tar xvjf $archive    ;;
				*.tar.gz)    tar xvzf $archive    ;;
				*.bz2)       bunzip2 $archive     ;;
				*.rar)       rar x $archive       ;;
				*.gz)        gunzip $archive      ;;
				*.tar)       tar xvf $archive     ;;
				*.tbz2)      tar xvjf $archive    ;;
				*.tgz)       tar xvzf $archive    ;;
				*.zip)       unzip $archive       ;;
				*.Z)         uncompress $archive  ;;
				*.7z)        7z x $archive        ;;
				*)           echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

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

# Copy file with a progress bar
cpp() {
	set -e
	strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
	| awk '{
	count += $NF
	if (count % 10 == 0) {
		percent = count / total_size * 100
		printf "%3d%% [", percent
		for (i=0;i<=percent;i++)
			printf "="
			printf ">"
			for (i=percent;i<100;i++)
				printf " "
				printf "]\r"
			}
		}
	END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
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
mkdg () {
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

# Returns the last 2 fields of the working directory
pwdtail () {
	pwd|awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}

# Show the current distribution
distribution () {
	local dtype
	# Assume unknown
	dtype="unknown"
	
	# First test against Fedora / RHEL / CentOS / generic Redhat derivative
	if [ -r /etc/rc.d/init.d/functions ]; then
		source /etc/rc.d/init.d/functions
		[ zz`type -t passed 2>/dev/null` == "zzfunction" ] && dtype="redhat"
	
	# Then test against SUSE (must be after Redhat,
	# I've seen rc.status on Ubuntu I think? TODO: Recheck that)
	elif [ -r /etc/rc.status ]; then
		source /etc/rc.status
		[ zz`type -t rc_reset 2>/dev/null` == "zzfunction" ] && dtype="suse"
	
	# Then test against Debian, Ubuntu and friends
	elif [ -r /lib/lsb/init-functions ]; then
		source /lib/lsb/init-functions
		[ zz`type -t log_begin_msg 2>/dev/null` == "zzfunction" ] && dtype="debian"
	
	# Then test against Gentoo
	elif [ -r /etc/init.d/functions.sh ]; then
		source /etc/init.d/functions.sh
		[ zz`type -t ebegin 2>/dev/null` == "zzfunction" ] && dtype="gentoo"
	
	# For Mandriva we currently just test if /etc/mandriva-release exists
	# and isn't empty (TODO: Find a better way :)
	elif [ -s /etc/mandriva-release ]; then
		dtype="mandriva"

	# For Slackware we currently just test if /etc/slackware-version exists
	elif [ -s /etc/slackware-version ]; then
		dtype="slackware"

	fi
	echo $dtype
}

# Show the current version of the operating system
ver () {
	local dtype
	dtype=$(distribution)

	if [ $dtype == "redhat" ]; then
		if [ -s /etc/redhat-release ]; then
			cat /etc/redhat-release && uname -a
		else
			cat /etc/issue && uname -a
		fi
	elif [ $dtype == "suse" ]; then
		cat /etc/SuSE-release
	elif [ $dtype == "debian" ]; then
		lsb_release -a
		# sudo cat /etc/issue && sudo cat /etc/issue.net && sudo cat /etc/lsb_release && sudo cat /etc/os-release # Linux Mint option 2
	elif [ $dtype == "gentoo" ]; then
		cat /etc/gentoo-release
	elif [ $dtype == "mandriva" ]; then
		cat /etc/mandriva-release
	elif [ $dtype == "slackware" ]; then
		cat /etc/slackware-version
	else
		if [ -s /etc/issue ]; then
			cat /etc/issue
		else
			echo "Error: Unknown distribution"
			exit 1
		fi
	fi
}

# Show current network information
netinfo () {
	echo "--------------- Network Information ---------------"
	ip a show wifi2 | grep "inet" | awk -F' ' '{print $2}'
	ip a show wifi2 | grep "inet" | awk -F' ' '{print $4}'
	ip l show wifi2 | grep "link" | awk -F' ' '{print $2}'
	echo "---------------------------------------------------"
}

# IP address lookup
getip () {
	# Dumps a list of all IP addresses for every device
	# /sbin/ifconfig |grep -B1 "inet addr" |awk '{ if ( $1 == "inet" ) { print $2 } else if ( $2 == "Link" ) { printf "%s:" ,$1 } }' |awk -F: '{ print $1 ": " $3 }';

	# Internal IP Lookup
	echo -n "Internal IP: " ; ip a show wifi2 | grep "inet" | awk -F' ' '{print $2}'

	# External IP Lookup
	echo -n "External IP: " ; curl http://ifconfig.me/ip
}
