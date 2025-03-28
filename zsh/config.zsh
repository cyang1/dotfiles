if [[ -n $SSH_CONNECTION ]]; then
  export PS1='%m:%3~$(git_info_for_prompt)%# '
else
  export PS1='%3~$(git_info_for_prompt)%# '
fi

# For OpenBSD/OS X `ls`
export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

# `ls` colors for the rest of us
if (( $+commands[dircolors] )); then
  eval $(dircolors -b $ZSH/zsh/dircolors.trapd00r)
elif (( $+commands[gdircolors] )); then
  eval $(gdircolors -b $ZSH/zsh/dircolors.trapd00r)
fi

# Pretty colors during tab completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

fpath=($ZSH/functions $fpath)

autoload -U $ZSH/functions/*(:t)

# 10ms timeout for key sequences
KEYTIMEOUT=1

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt HIST_VERIFY
setopt SHARE_HISTORY # share history between sessions ???
setopt EXTENDED_HISTORY # add timestamps to history
setopt PROMPT_SUBST
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_REDUCE_BLANKS

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases
