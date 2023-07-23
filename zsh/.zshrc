# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# history size
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
# export HISTCONTROL=ignoredups:erasedups

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

bindkey -s '\e\e' 'sudo !!'

set -o emacs

alias nv="nvim"
alias lg="lazygit"
alias rm='rm -i'
alias mv='mv -i'
alias act='source venv/bin/activate'
alias deact='deactivate'
alias ls='exa'
# alias ll='exa -labh --no-time --no-filesize --icons'
alias ll='exa -labh --time-style="long-iso" --icons'
alias src='source ~/.config/zsh/.zshrc'
alias lz='NVIM_APPNAME=lazyvim nvim'
alias lf='$HOME/.config/lf/lfub'
export EDITOR="nvim"
export VISUAL="nvim"
export EDITOR=nvim
export OPENER=xdg-open

PROMPT="[%n %~]$ "

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

for file in /home/brian/.config/zsh/plugins/*.zsh; do
  source "$file"
done

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  IFS=$'\n' files=($(
    find . -type f \
    -not -path "*/.vscode/*" \
    -not -path "*/.git/*" \
    -not -path "*/venv/*" \
    -not -path "*/.cache/*" \
    -not -path "*/.texlive/*" \
    -not -path "*/.pyenv/*" \
    -not -path "*/_*/*" \
    -not -path "*/Repos/*/*" \
    | fzf-tmux --query="$1" --multi --select-1 --exit-0
  ))
  # [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
  if [[ -n "$files" ]]; then
    for file in "${files[@]}"; do
      extension="${file##*.}"
      if [[ "$extension" == "pdf" ]]; then
        xdg-open "$file"
      else
        ${EDITOR:-vim} "$file"
      fi
    done
  fi
}

# fe() {
#   find . -type f ! -name "*/.mozilla/*" | fzf | xargs nvim
# }

fd() {
  local dir
  dir=$(find ${1:-.} -path '*/.vscode' -prune \
                  -o -path '*/.mozilla' -prune \
                  -o -path '*/.git' -prune \
                  -o -path '*/venv' -prune \
                  -o -path '*/.pyenv' -prune \
                  -o -path '*/.cache' -prune \
                  -o -path '*/.texlive' -prune \
                  -o -path '*/_*' -prune \
                  -o -path '*/Repos/*/*' -prune \
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

# alias lf="lfcd"


source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
