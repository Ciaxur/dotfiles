# Custom Aliases
alias ll="exa -alg --git"       # List-View + Hidden
alias l="exa -lg --git"         # List View
alias logout="kill -9 -1"       # Force Logout all Users
alias open="nautilus"           # GUI File Manager
alias kp="keepassxc.cli"        # Keepass CLI
alias py="python"               # Latest Python Alias
alias diff="diff --color"       # Diff with Color
#alias fzf="fzf --height 50% --layout=reverse --border --color=16 --preview='head -$LINES {+}'"
alias fzf="fzf --height 50% --layout=reverse --border --color=16 --preview='~/.config/lf/scopes/pistol {}'"

# Alias for Downloader-CLI by "deepjyoti30"
alias dw="py ~/documents/git-clones/downloader-cli/download.py"

# Alias to Function lfcd, function.sh has to be
#  sourced before this :)
alias fm='lfcd'

# Alias for Copying over Text by piping
#alias copy="tr -d '\n' | xclip -selection clipboard"
alias copy="xclip -selection clipboard"
