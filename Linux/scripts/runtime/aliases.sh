# Custom Aliases
alias ll="ls -alh"              # List-View + Hidden
alias l="ls -lh"                # List View
alias logout="kill -9 -1"       # Force Logout all Users
alias open="nautilus"           # GUI File Manager
alias kp="keepassxc.cli"        # Keepass CLI
alias py="python3.7"            # Latest Python Alias

# Alias for Downloader-CLI by "deepjyoti30"
alias dw="py ~/documents/git-clones/downloader-cli/download.py"

# Alias to Function lfcd, function.sh has to be
#  sourced before this :)
alias fm='lfcd'

# Alias for Copying over Text by piping
alias copy="tr -d '\n' | xclip -selection clipboard"
