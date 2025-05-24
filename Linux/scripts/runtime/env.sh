# Environment Variables
export EDITOR=nvim
export GOPATH=~/Documents/go
export LESS='--mouse -RX'
export ANDROID_SDK=~/Documents/Android/Sdk
export SSH_AUTH_SOCK="/run/user/1000/ssh-agent.socket"
export SUDO_ASKPASS=/usr/lib/ssh/ssh-askpass
export BAT_CONFIG_PATH=~/.config/bat/bat.conf

# Set terminal options.
if [ "$TMUX" != "" ]; then
  export TERM=rxvt-256color
else
  # TODO: document why i chose tmux-256color. this is breaking nvterm within neovim.
  # https://superuser.com/questions/1580568/zsh-prints-the-command-i-ran-before-showing-the-output
  #
  # export TERM=tmux-256color
  export TERM=xterm-256color
fi


# Ruby Path
export RUBY_PATH="/home/omar/.gem/ruby/2.7.0"

# Export Path
export PATH="$RUBY_PATH/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# GUI Themes
export QT_STYLE_OVERRIDE=Oxygen
