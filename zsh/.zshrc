# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

PROMPT="[%n %~]$ "

# zsh auto suggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# history size
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
# export HISTCONTROL=ignoredups:erasedups

# ruby / jekyll
export PATH=$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH

# pacman
alias pacin="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' --preview-window=65% | xargs -ro sudo pacman -S"
alias pacre="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' --preview-window=65% | xargs -ro sudo pacman -Rns"

# case insensitive search
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

# bemenu
export BEMENU_OPTS="--fn 'Hack 11'"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_COMMAND="fd --type file --hidden --no-ignore --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi --height=40% --reverse --border=none"

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
alias ls='eza'
alias ll='eza -lab --icons'
alias src='source ~/.config/zsh/.zshrc'
alias lz='NVIM_APPNAME=lazyvim nvim'
# alias lf='$HOME/.config/lf/lfub'
export EDITOR="nvim"
export VISUAL="nvim"
export OPENER=xdg-open

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

# search files fzf
fe() {
  IFS=$'\n' files=($(
  fd -t f --color=always --hidden --no-ignore-vcs \
    --exclude ".cache" \
    --exclude ".cargo" \
    --exclude ".git" \
    --exclude ".local" \
    --exclude ".mypy_cache" \
    --exclude ".pyenv" \
    --exclude ".rustup" \
    --exclude ".texlive" \
    --exclude ".vscode" \
    --exclude "Repos/*/*" \
    --exclude "_*" \
    --exclude "backup_samsungT5" \
    --exclude "mnt" \
    --exclude "venv" \
    | fzf-tmux --query="$1" --multi --select-1 --exit-0
  ))
  # [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
  if [[ -n "$files" ]]; then
    for file in "${files[@]}"; do
      extension="${file##*.}"
      if [[ "$extension" =~ (pdf|jpg|jpeg|JPG|png)$ ]]; then
        xdg-open "$file"
      else
        ${EDITOR:-vim} "$file"
      fi
    done
  fi
}

# cd to directory fzf
fcd() {
  local dir
  dir=$(fd ${1:-.} --exclude '.vscode'  \
                   --exclude '.cache'  \
                   --exclude '.cargo'  \
                   --exclude '.git'  \
                   --exclude '.mozilla'  \
                   --exclude '.pyenv'  \
                   --exclude '.rustup'  \
                   --exclude '.texlive'  \
                   --exclude 'Repos/*/*'  \
                   --exclude '_*'  \
                   --exclude 'backup_samsungT5'  \
                   --exclude 'venv'  \
                   -t d --hidden --no-ignore-vcs | fzf +m) &&
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


source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
