PROMPT="[%n %~]$ "

export EDITOR="nvim"
export VISUAL="nvim"
export OPENER=xdg-open

# function for if file exists, source
include() {
	[[ -f "$1" ]] && source "$1"
}

# zsh auto suggestions
include ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh
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
include /usr/share/fzf/key-bindings.zsh
include /usr/share/fzf/completion.zsh
export FZF_DEFAULT_COMMAND="fd --type file --hidden --no-ignore --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi --height=40% --reverse --border=none"

# Edit line in vim with ctrl-e:
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

bindkey -s '\e\e' 'sudo !!'

set -o emacs

alias nv="nvim"
alias lg="lazygit"
alias rm='rm -i'
alias mv='mv -i'
alias ls='eza'
alias ll='eza -lab --icons'
alias lz='NVIM_APPNAME=lazyvim nvim'
# python venv
alias act='source venv/bin/activate'
alias deact='deactivate'

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
	local pid
	if [ "$UID" != "0" ]; then
		pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
	else
		pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
	fi

	if [ "x$pid" != "x" ]; then
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
			--exclude "venv" |
			fzf-tmux --query="$1" --multi --select-1 --exit-0
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
	dir=$(fd ${1:-.} --exclude '.vscode' \
		--exclude '.cache' \
		--exclude '.cargo' \
		--exclude '.git' \
		--exclude '.mozilla' \
		--exclude '.pyenv' \
		--exclude '.rustup' \
		--exclude '.texlive' \
		--exclude 'Repos/*/*' \
		--exclude '_*' \
		--exclude 'backup_samsungT5' \
		--exclude 'venv' \
		-t d --hidden --no-ignore-vcs | fzf +m) &&
		cd "$dir"
}

# lf cd function
lfcd() {
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
