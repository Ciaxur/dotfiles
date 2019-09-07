# Custom Aliases
alias ll="ls -alh"              # List-View + Hidden
alias l="ls -lh"                # List View
alias logout="kill -9 -1"       # Force Logout all Users
alias open="nautilus"           # GUI File Manager
alias kp="keepassxc.cli"        # Keepass CLI

# TUI File Manager (Ranger) - Goes to Directory in ranger on exit
alias fm='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'



