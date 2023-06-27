# history size
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
# export HISTCONTROL=ignoredups:erasedups

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

alias nv="nvim"
alias rm='rm -i'
alias mv='mv -i'
export EDITOR="nvim"
export VISUAL="nvim"
export EDITOR=nvim
export OPENER=xdg-open

PROMPT="[%n %~]$ "

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

fd() {
  local dir
  dir=$(find ${1:-.} -path 'placeholder11' -prune \
                  -o -path '*/.mozilla' -prune \
                  -o -path '*/.git' -prune \
                  -o -path '*/.pyenv' -prune \
                  -o -path '*/.cache' -prune \
                  -o -path '*/.texlive' -prune \
                  -o -path '*/Repos/*/*' -prune \
                  -o -path '*/.config/*/*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# lf cd function
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

alias lf="lfcd"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
