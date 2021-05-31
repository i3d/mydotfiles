# Customized OMZ theme for Archcraft

if [[ "$USER" == "root" ]]; then
  PROMPT="%(?:%{$fg_bold[red]%}%{$fg_bold[yellow]%}%{$fg_bold[red]%} :%{$fg_bold[red]%} )"
  PROMPT+='%{$fg_bold[blue]%}::%m:: %{$fg[cyan]%}  %c%{$reset_color%} $(git_prompt_info)'
else
  #PROMPT="%(?:%{$fg_bold[red]%}%{$fg_bold[green]%}%{$fg_bold[yellow]%} :%{$fg_bold[red]%} )"
  #PROMPT+='%{$fg_bold[blue]%}::%m:: %{$fg[cyan]%}  %c%{$reset_color%} $(git_prompt_info)'
  # PROMPT="%{$fg_bold[red]%}〉"
  PROMPT="%{$fg_bold[red]%}  %l %{$fg_bold[yellow]%}%?%{$reset_color%}:: %T%{$fg_bold[green]%} %{$reset_color%}"
  #PROMPT+='%{$fg_bold[blue]%}::%m::%{$fg_bold[green]%}⎇ %{$fg[cyan]%} %c%{$reset_color%} $(git_prompt_info)'
  PROMPT+='%{$fg_bold[blue]%}%m::%{$fg_bold[green]%}⎇ %{$fg[cyan]%} %c%{$reset_color%} $(git_prompt_info)'
  PROMPT+="%(?:%{$fg_bold[red]%}%{$fg_bold[green]%}%{$fg_bold[yellow]%} :%{$fg_bold[red]%} )"
fi

#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}  git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%} git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# awesome web icons
# https://fontawesome.com/v5/cheatsheet
# https://icons8.com/line-awesome
#  
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
#   
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
#   , 
#   , 
#   , 
# 
# 
# 
#   ,   , 
