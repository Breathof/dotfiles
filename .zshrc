HOSTNAME=$(hostname)
WORK_HOSTNAME="UY000CXL935W9H2"

if [[ "$HOSTNAME" == "$WORK_HOSTNAME" ]]; then
  # Fury CLI
  export RANGER_FURY_LOCATION=/Users/igferreira/.fury
  export RANGER_FURY_VENV_LOCATION=/Users/igferreira/.fury/fury_venv
  declare FURY_BIN_LOCATION="/Users/igferreira/.fury/fury_venv/bin"
  export PATH="$PATH:$FURY_BIN_LOCATION"
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Homebrew
  export PATH="/opt/homebrew/bin:$PATH"
fi

# Zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
autoload -U compinit && compinit
zinit cdreplay -q

bindkey -v
bindkey '^h' history-search-backward
bindkey '^l' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space # Ignore a command by prepend a space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" 
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview "ls --color $realpath" 
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview "ls --color $realpath" 

# Oh my posh
# TODO: Install it if not aviable
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
	eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
	# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/catppuccin.omp.json)"
fi

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Aliases
source ~/.aliases

# PATH
export PATH=$PATH:$(go env GOPATH)/bin
