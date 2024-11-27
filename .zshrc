# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	sudo # Doubletap ESC to prepend current or previous command with sudo
	ssh # Adds quick SSH commands based on hosts in .ssh/config
	z
	zsh-autosuggestions # https://github.com/zsh-users/zsh-autosuggestions
	zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting
	fast-syntax-highlighting # https://github.com/zdharma-continuum/fast-syntax-highlighting
	zsh-autocomplete # https://github.com/marlonrichert/zsh-autocomplete
	# fzf
)

# export FZF_BASE=/home/cameron/.fzf/bin/fzf
# # export FZF_DEFAULT_COMMAND=''
# export FZF_DEFAULT_OPTS='--min-height=6 --height=12'
# export DISABLE_FZF_AUTO_COMPLETION="true"

source $ZSH/oh-my-zsh.sh

# zstyle ':autocomplete:*' min-input 1
# zstyle ':autocomplete:*' delay 0
zstyle ':autocomplete:*' ignored-input '..##'
# zstyle -e ':autocomplete:*:*' list-lines 'reply=( $(( LINES / 4 )) )'
