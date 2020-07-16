# Obtains Running Background Jobs
function totalJobs() {
  total_jobs=$(jobs | sed  '/^(.*)$/d' | wc -l)

  if [ $total_jobs -eq 0 ]; then
      total_jobs=""

  else
      total_jobs="[${total_jobs}]"
  fi

  print "%{$fg_bold[blue]%}$total_jobs%{$reset_color%}"
}

# Outputs Header
function getHeader() {
  print "%{$fg[cyan]%}%~%{$reset_color%}"
}



# Job and Git Integration
PROMPT="%(?:%{$fg_bold[cyan]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+='$(totalJobs)%{$fg[blue]%}%c%{$reset_color%} $(git_prompt_info)'

# Git Themes
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
