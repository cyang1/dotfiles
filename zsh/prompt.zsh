autoload colors && colors

#############################
# GIT-RELATED FUNCTIONS
#############################

if (( $+commands[git] )); then
  git="$commands[git]"
else
  git='/usr/bin/git'
fi

function in_git_repo() {
  $git rev-parse --is-inside-work-tree &> /dev/null
}

function git_dirty() {
  in_git_repo || return
  if [[ $POST_1_7_2_GIT -gt 0 ]]; then
    SUBMODULE_SYNTAX='--ignore-submodules=dirty'
  fi
  if [[ $($git status ${SUBMODULE_SYNTAX} --porcelain -uno) == '' ]]; then
    echo " on %B%F{green}$(git_prompt_info)%f%b"
  else
    echo " on %B%F{red}$(git_prompt_info)%f%b"
  fi
}

function git_prompt_info() {
  ref=$($git symbolic-ref HEAD 2>/dev/null) || return
  echo "${ref#refs/heads/}"
}

function untracked_status() {
  no_untracked || echo '%F{yellow}?%f'
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
POST_1_7_2_GIT=$(git_compare_version '1.7.2')
# clean up the namespace slightly by removing the checker function
unset -f git_compare_version

#############################
# NORMAL PROMPT FUNCTIONS
#############################

# More accurate SECONDS!
typeset -F SECONDS

function prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    echo '%B%F{white}%n%f%b at %B%F{black}%m%f%b in '
  fi
}

cur_dir='%B%F{blue}%~%f%b'

prompt_char='%(0#.%F{red}#%f.$)'

function virtualenv_info() {
  [ $VIRTUAL_ENV ] && echo "%F{cyan}($(basename $VIRTUAL_ENV))%f "
}

return_code='%(?..%F{red}%? ↵%f) '

function timer_preexec() {
  CMD_START_TIME=$SECONDS
}

function timer_precmd() {
  local elapsed=$(($SECONDS - ${CMD_START_TIME:-$SECONDS}))
  if (( $elapsed > 3 )); then
    psvar[1]=$(printf '%.2f' $elapsed)
  else
    psvar[1]=
  fi
  CMD_START_TIME=
}

autoload -U add-zsh-hook
add-zsh-hook preexec timer_preexec
add-zsh-hook precmd timer_precmd

time_taken='%(1V.%F{yellow}%1vs%f .)'

time_str='%F{green}[%*]%f'

PROMPT='
$(prompt_context)${cur_dir}$(git_dirty)$(untracked_status)
 ${prompt_char} $(virtualenv_info)'
PROMPT2='%F{red}   %_%f> '
RPROMPT='${return_code}${time_taken}${time_str}'
