# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    zle-keymap-select
    echoti smkx
  }
  function zle-line-finish() {
    echo -ne "\033[2 q" # block cursor
    echoti rmkx
  }
  function zle-keymap-select() {
    case $KEYMAP in
      vicmd) echo -ne "\033[2 q";; # block cursor
      viins|main) echo -ne "\033[6 q";; # line cursor
    esac
  }
  zle -N zle-line-init
  zle -N zle-line-finish
  zle -N zle-keymap-select
fi


bindkey -v                                                     # Use vim key bindings

bindkey -M viins '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
bindkey -M vicmd '^r' history-incremental-search-backward

if [[ "${terminfo[kcuu1]}" != "" ]]; then
  bindkey -M viins "${terminfo[kcuu1]}" up-line-or-search      # start typing + [Up-Arrow] - fuzzy find history forward
  bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-search
fi
if [[ "${terminfo[kcud1]}" != "" ]]; then
  bindkey -M viins "${terminfo[kcud1]}" down-line-or-search    # start typing + [Down-Arrow] - fuzzy find history backward
  bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-search
fi

bindkey -M viins '^k' up-line-or-search
bindkey -M viins '^j' down-line-or-search
bindkey -M vicmd 'k' up-line-or-search
bindkey -M vicmd 'j' down-line-or-search
bindkey -M viins '^a' vi-beginning-of-line
bindkey -M viins '^e' vi-end-of-line

if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey -M viins "${terminfo[khome]}" vi-beginning-of-line   # [Home] - Go to beginning of line
fi
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey -M viins "${terminfo[kend]}" vi-end-of-line          # [End] - Go to end of line
fi

bindkey ' ' magic-space                                        # [Space] - do history expansion

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete            # [Shift-Tab] - move through the completion menu backwards
fi

bindkey '^?' backward-delete-char                              # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char                     # [Delete] - delete forward
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi

# Required so that these work properly after going from cmd to insert mode
bindkey "^W" backward-kill-word
bindkey "^U" backward-kill-line

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line
