# Bind End/Home Keys
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey -s "l" 'l\n'
# Bind to "lfcd" function from function.sh
bindkey -s '^o' 'nnncd\n'
bindkey -s '^s' 'fzf\n'
