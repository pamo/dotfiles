export PATH="$HOME/bin:/opt/homebrew/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="vim"

ZSH_THEME="edvardm"

plugins=(
  git                     # git aliases: gst, gco, gp, gl, etc.
  docker-compose          # dco, dcup, dcdown aliases
  colored-man-pages       # colorized man pages
  fzf                     # ctrl-r: fuzzy history, ctrl-t: fuzzy file finder
)

source $ZSH/oh-my-zsh.sh

# zsh-syntax-highlighting (installed via brew)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# zoxide — `z project` to jump, `zi` for interactive
eval "$(zoxide init zsh)"

# mise — `mise use node@22`, `mise ls` to list runtimes
eval "$(mise activate zsh)"

# Aliases
alias ls="eza --icons"
alias ll="eza -la --icons --git"
alias lt="eza -la --icons --tree --level=2"
alias cat="bat --paging=never"
alias top="htop"
alias dbranches='git branch | grep -v "main" | xargs git branch -D'

# Prettier format staged files
format-staged() {
  git diff --cached --name-only --diff-filter=ACM \
    | grep -E '\.(js|jsx|ts|tsx|json|css|scss|md)$' \
    | xargs -r npx prettier --write
}

# fzf key bindings
source <(fzf --zsh) 2>/dev/null
