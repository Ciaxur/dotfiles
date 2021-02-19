# Custom Aliases
alias ll="exa -alg --git"       # List-View + Hidden
alias l="exa -lg --git"         # List View
alias logout="kill -9 -1"       # Force Logout all Users
alias kp="keepassxc.cli"        # Keepass CLI
alias py="python"               # Latest Python Alias
alias ipy="ipython"             # Interactive Python
alias diff="diff --color"       # Diff with Color
#alias fzf="fzf --height 50% --layout=reverse --border --color=16 --preview='head -$LINES {+}'"
alias fzf="fzf --height 60% --layout=reverse --border --color=16 --preview='~/.config/lf/scopes/pistol {}'"
alias lsblk='lsblk -o NAME,SIZE,FSUSED,FSUSE%,TYPE,FSTYPE,MOUNTPOINT,PARTTYPENAME'
alias sudo='sudo -p "Password for $USER:🔑"'
alias yay='paru'

# Aliases Based on Scripts
alias terminal="~/scripts/cli-commands/terminal"
alias open="~/scripts/cli-commands/filemanager"

# Alias for Downloader-CLI by "deepjyoti30"
alias dw="py ~/documents/git-clones/downloader-cli/download.py"

# Alias to Function lfcd, function.sh has to be
#  sourced before this :)
alias fm='lfcd'

# Alias for Copying over Text by piping
#alias copy="tr -d '\n' | xclip -selection clipboard"
alias copy="xclip -selection clipboard"

# Fun Aliases
alias 🍺="git checkout drunk 2>/dev/null || git checkout -b drunk"
alias set-wallpaper='feh --bg-scale'
alias set-theme='~/scripts/theme-switch/script.sh'
alias glog="git log --oneline --decorate --graph --pretty=format:'%C(auto)%h%d %s (%cn - %cr)'"
