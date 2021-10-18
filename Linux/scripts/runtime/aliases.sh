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

# Bat Aliases
alias bat_man="bat --style=snip --language=man"

# Aliases Based on Scripts
alias terminal="~/scripts/cli-commands/terminal"
alias open="~/scripts/cli-commands/filemanager"
alias openmd="~/scripts/cli-commands/openMarkdown.sh"

# Alias for Downloader-CLI by "deepjyoti30"
alias dw="py ~/documents/git-clones/downloader-cli/download.py"

# Alias to Function lfcd, function.sh has to be
#  sourced before this :)
alias fm='lfcd'

# Alias for Copying over Text by piping
#alias copy="tr -d '\n' | xclip -selection clipboard"
alias copy="xclip -selection clipboard"

# Docker Aliases based on https://github.com/devemio/docker-color-output too
alias di='docker images $@ | dco'
alias dps='docker ps $@ | dco'
alias dcps='docker-compose ps $@ | dco'

# Fun Aliases
alias 🍺="git checkout drunk 2>/dev/null || git checkout -b drunk"
alias set-wallpaper='feh --bg-scale'
alias set-theme='~/scripts/theme-switch/script.sh'
alias glog="git log --oneline --decorate --graph --pretty=format:'%C(auto)%h%d %s (%cn - %cr)'"

# Life Satisfying Aliases (Easy update, thanks to Zaki)
alias yay-update="(yay -Syu --noconfirm && notify-send Yay-update\ Succesfful) || notify-send Failed\ Update"
alias pacman-update="(sudo pacman -Syu --noconfirm && notify-send Pcman\ Succesfful) || notify-send Failed\ Update"
alias system-update="yay-update && pacman-update"
