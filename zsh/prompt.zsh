autoload colors && colors

#############################
# GIT-RELATED FUNCTIONS
#############################

if (( $+commands[git] )); then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

function in_git_repo() {
  $git status -s &> /dev/null
}

function git_dirty() {
  in_git_repo || return
  if [[ $POST_1_7_2_GIT -gt 0 ]]; then
    SUBMODULE_SYNTAX="--ignore-submodules=dirty"
  fi
  if [[ $($git status ${SUBMODULE_SYNTAX} --porcelain -uno) == "" ]]; then
    echo " on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
  else
    echo " on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
  fi
}

function git_prompt_info() {
  ref=$($git symbolic-ref HEAD 2>/dev/null) || return
  echo "${ref#refs/heads/}"
}

function untracked_status() {
  no_untracked || echo "%{$fg[yellow]%}?%{$reset_color%}"
}

function no_untracked() {
  in_git_repo || return 0
  return $($git ls-files --other --directory --exclude-standard | sed q | wc -l)
}

# compare the provided version of git to the version installed and on path
# prints 1 if input version <= installed version
# prints -1 otherwise
function git_compare_version() {
  local INPUT_GIT_VERSION=$1;
  local INSTALLED_GIT_VERSION
  INPUT_GIT_VERSION=(${(s/./)INPUT_GIT_VERSION});
  INSTALLED_GIT_VERSION=($(command git --version 2>/dev/null));
  INSTALLED_GIT_VERSION=(${(s/./)INSTALLED_GIT_VERSION[3]});

  for i in {1..3}; do
    if [[ $INSTALLED_GIT_VERSION[$i] -lt $INPUT_GIT_VERSION[$i] ]]; then
      echo -1
      return 0
    fi
  done
  echo 1
}

# this is unlikely to change so make it all statically assigned
POST_1_7_2_GIT=$(git_compare_version "1.7.2")
# clean up the namespace slightly by removing the checker function
unset -f git_compare_version

#############################
# NORMAL PROMPT FUNCTIONS
#############################

function prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    echo "%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in "
  fi
}

local cur_dir="%{$fg_bold[blue]%}%~%{$reset_color%}"

function prompt_char() {
  if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $; fi
}

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%}) "

function virtualenv_info() {
  [ $VIRTUAL_ENV ] && echo "%{$fg[cyan]%}("`basename $VIRTUAL_ENV`")%{$reset_color%} "
}

local time_str="%{$fg[green]%}[%*]%{$reset_color%}"

PROMPT='
$(prompt_context)${cur_dir}$(git_dirty)$(untracked_status)
 $(prompt_char) '
PROMPT2='%{$fg[red]%}   %_%{$reset_color%}> '
RPROMPT='${return_code}$(virtualenv_info)${time_str}'
