# ignore duplicates from ~/.zsh_history
setopt histignoredups
cfg-zsh-history() { $EDITOR $HISTFILE ;}
# }}}
#-------- Oh My ZSH {{{
#------------------------------------------------------
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

#Zsh_Theme
ZSH_THEME="rkj-repos"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="false"

plugins=(git 
node
bower
zsh_reload
zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

DISABLE_AUTO_TITLE=true

#Sourcing myAlias file.
if [ -f ~/.myAlias ]; then
    . ~/.myAlias
fi

#Sourcing environments file.
if [ -f ~/.myVariables ]; then
    . ~/.myAlias
fi

#-------- Auto Start Tmux Session {{{
#------------------------------------------------------
# https://wiki.archlinux.org/index.php/Tmux#Start_tmux_on_every_shell_login
# TMUX
if which tmux 2>&1 >/dev/null; then
    # if no session is started, start a new session
    test -z ${TMUX} && tmux -2

    # when quitting tmux, try to attach
    while test -z ${TMUX}; do
        tmux attach || break
    done
fi

#}}}
#		ZSH Stuff
#======================================================
#-------- Commands {{{
#------------------------------------------------------
# Show dots if tab compeletion is taking long to load
expand-or-complete-with-dots() {
  echo -n "\e[31m......\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots


#}}}
#-------- Vim Mode {{{
#------------------------------------------------------
# enable vim mode on commmand line
bindkey -v


# edit command with editor ( good for long commands )
# http://stackoverflow.com/a/903973
# usage: type someshit then Esc+v or v
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line



# no delay entering normal mode
# https://coderwall.com/p/h63etq
# https://github.com/pda/dotzsh/blob/master/keyboard.zsh#L10
# 10ms for key sequences
KEYTIMEOUT=1

# show vim status
# http://zshwiki.org/home/examples/zlewidgets
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# add missing vim hotkeys
# fixes backspace deletion issues
# http://zshwiki.org/home/zle/vi-mode
bindkey -a u undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char	#backspace
bindkey '^H' backward-delete-char


# history search in vim mode
# http://zshwiki.org./home/zle/bindkeys#why_isn_t_control-r_working_anymore
bindkey -M viins '^s' history-incremental-search-backward
bindkey -M vicmd '^s' history-incremental-search-backward


# vim mode status cursor color change
# http://andreasbwagner.tumblr.com/post/804629866/zsh-cursor-color-vi-mode
# http://reza.jelveh.me/2011/09/18/zsh-tmux-vi-mode-cursor

# bug; 112 ascii randomly showing up

zle-keymap-select () {
  if [ $KEYMAP = vicmd ]; then
    if [[ $TMUX = '' ]]; then
      echo -ne "\033]12;Red\007"
    else
      printf '\033Ptmux;\033\033]12;red\007\033\\'
    fi
  else
    if [[ $TMUX = '' ]]; then
      echo -ne "\033]12;Grey\007"
    else
      printf '\033Ptmux;\033\033]12;grey\007\033\\'
    fi
  fi
}
zle-line-init () {
  zle -K viins
  echo -ne "\033]12;Grey\007"
}
zle -N zle-keymap-select
zle -N zle-line-init

# ZSH completions# {{{
compdef _pids cpulimit
setopt completealiases

#-------- Keybinding {{{
#------------------------------------------------------

# history search using up and down arrow keys
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init () {
    emulate -L zsh
    printf '%s' ${terminfo[smkx]}
  }
  function zle-line-finish () {
    emulate -L zsh
    printf '%s' ${terminfo[rmkx]}
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

autoload -Uz history-search-end
if PATH= whence history-search-end >/dev/null 2>&1; then
  zle -N history-beginning-search-backward-end history-search-end
  zle -N history-beginning-search-forward-end history-search-end
  [ "$terminfo[kcuu1]" ] && bindkey "$terminfo[kcuu1]" history-beginning-search-backward-end
  [ "$terminfo[kcud1]" ] && bindkey "$terminfo[kcud1]" history-beginning-search-forward-end
fi

