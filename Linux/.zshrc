#######################
## ZSH Configuration ##
#######################
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history


#############################
## oh-my-zsh Configuration ##
#############################

# Path to your oh-my-zsh installation.
export ZSH="/home/omar/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
source $ZSH/oh-my-zsh.sh





# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"



########################
## User Configuration ##
########################


# Colorize man Pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export PAGER="most"

# Load Sources 
source ~/scripts/runtime/functions.sh
source ~/scripts/runtime/aliases.sh
source ~/scripts/runtime/keybinds.sh
source ~/scripts/runtime/env.sh

# Source ZSH Syntax Highlighting
# Git: https://github.com/zsh-users/zsh-syntax-highlighting
source ~/documents/git-clones/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# NVM Exports
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Pip Packages Exports
export PATH=$PATH:$HOME/.local/bin

# Golang Package Exports
export PATH=$PATH:$GOPATH/bin
