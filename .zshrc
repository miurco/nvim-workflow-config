# Simple prompt: just show current directory and prompt symbol
# PROMPT='%~ %# '
PROMPT=''

eval "$(zoxide init zsh)"
eval "$(luarocks path --bin)"

# Zsh history configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY          # Append to history file instead of replacing
setopt SHARE_HISTORY           # Share history between sessions
setopt HIST_IGNORE_DUPS        # Don't save duplicate commands
setopt HIST_IGNORE_ALL_DUPS    # Remove older duplicate entries
setopt HIST_FIND_NO_DUPS       # Don't display duplicates when searching
setopt HIST_IGNORE_SPACE       # Don't save commands starting with space
setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks
setopt INC_APPEND_HISTORY      # Add commands immediately (not at shell exit)

# Set personal aliases
alias ,ez="nvim ~/.zshrc"
alias ,sz="source ~/.zshrc"
alias ,ev="nvim ~/.config/nvim/init.lua"

alias gb="git branch"
alias gc="git commit -m"
alias gch="git checkout"
alias gl="git log"
alias ga="git add"
alias gp="git pull"
alias gpu="git push"
alias gpu="git push --force"
alias gs="git status"


# Auto-rename tmux window to current directory
if [[ -n "$TMUX" ]]; then
  precmd() {
    tmux rename-window "${PWD##*/}"
  }
fi

# Auto-clear screen before each command for single-command view
autoload -Uz add-zsh-hook
clear-before-command() {
  clear
  tput cup 0 0
}
add-zsh-hook preexec clear-before-command
