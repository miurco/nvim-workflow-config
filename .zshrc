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


# Alacritty theme switcher
alatheme() {
    local theme_dir="$HOME/.config/alacritty/themes/alacritty-theme/themes"
    local theme=$(ls "$theme_dir" | sed 's/\.toml$//' | fzf --prompt="Alacritty Theme: " --height=40% --reverse)
    
    if [[ -n "$theme" ]]; then
        sed -i '' "s|\".*\.toml\"|\"~/.config/alacritty/themes/alacritty-theme/themes/$theme.toml\"|" "$HOME/.config/alacritty/alacritty.toml"
        echo "Switched to: $theme"
    fi
}

# opencode
export PATH=/Users/mihai.iurcomgmail.com/.opencode/bin:$PATH


