
# Obtains Running Background Jobs
function totalJobs() {
    total_jobs=$(jobs | wc -l)

    if [ $total_jobs -eq 0 ]; then
        total_jobs=""

    else
        total_jobs="[${total_jobs}]"
    fi

    print "$total_jobs"
}


local ret_status="%(?:%{$FG[133]%}➜ :%{$fg_bold[red]%}➜ )"
#local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT='${ret_status}$(totalJobs) %{$fg[blue]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$FG[160]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
