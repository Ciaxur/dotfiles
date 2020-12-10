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
ZSH_THEME="robbyrussell-mod"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# https://github.com/lukechilds/zsh-nvm
#  Lazy Load NVM (shaves 0.5s+)
plugins=(git)
source $ZSH/oh-my-zsh.sh


# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Allows Aliases to have Completion
unsetopt completealiases


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

# Configure Pager ; RegExp Search
#export PAGER="most -r"

# Load Sources 
source ~/scripts/runtime/functions.sh
source ~/scripts/runtime/aliases.sh
source ~/scripts/runtime/keybinds.sh
source ~/scripts/runtime/env.sh

# Source ZSH Syntax Highlighting
# Git: https://github.com/zsh-users/zsh-syntax-highlighting
source ~/Documents/git-clones/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load NVM only when Needed
nvm() {
  if [ !$NVM_DIR ]; then
    echo "Initializing NVM..."

    # NVM Exports
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    # Default to Stable
    nvm use stable
    nvm
  fi
}
# NVM Export Lastest Installed Version
LATEST=`ls $HOME/.nvm/versions/node/ | head -1`
export PATH=$PATH:$HOME/.nvm/versions/node/$LATEST/bin



# Pip Packages Exports
export PATH=$PATH:$HOME/.local/bin

# Golang Package Exports
export PATH=$PATH:$GOPATH/bin

# fzf Additions
source /home/omar/Documents/git-clones/fzf/shell/completion.zsh
source /home/omar/Documents/git-clones/fzf/shell/key-bindings.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


# Configure "time" command's Output
TIMEFMT='%J   %U  user %S system %P cpu %*E total'$'\n'\
'avg shared (code):         %X KB'$'\n'\
'avg unshared (data/stack): %D KB'$'\n'\
'total (sum):               %K KB'$'\n'\
'max memory:                %M MB'$'\n'\
'page faults from disk:     %F'$'\n'\
'other page faults:         %R'



# Configure Completion
source ~/.oh-my-zsh/completions/*.zsh 2&> /dev/null

# Define Completions
compdef _deno deno      # Deno Autocomplete

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/home/omar/.cache/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# Jump Config
eval "$(jump shell)"
