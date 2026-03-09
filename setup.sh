#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# ─── Xcode CLI Tools ────────────────────────────────────────────────
echo "==> Installing Xcode CLI tools"
xcode-select --install 2>/dev/null || true

# ─── Homebrew ────────────────────────────────────────────────────────
echo "==> Installing Homebrew"
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> Installing packages from Brewfile"
brew bundle --file="$DOTFILES/Brewfile"

# ─── oh-my-zsh ───────────────────────────────────────────────────────
echo "==> Installing oh-my-zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ─── GitHub auth (replaces git-login.sh) ─────────────────────────────
# `gh auth login` handles SSH key setup, git credential helper, and GitHub auth
echo "==> GitHub authentication"
if ! gh auth status &>/dev/null; then
  echo "  Run: gh auth login"
  echo "  Choose: SSH → Generate new key → Authenticate via browser"
fi

# ─── Project directories ─────────────────────────────────────────────
mkdir -p ~/me ~/dev

# ─── Git config files ────────────────────────────────────────────────
echo "==> Creating git config files"
if [ ! -f ~/.gitconfig-personal ]; then
  cat > ~/.gitconfig-personal <<EOF
[user]
  email = pamela.ocampo@gmail.com
EOF
fi

if [ ! -f ~/.gitconfig-work ]; then
  cat > ~/.gitconfig-work <<EOF
[user]
  email = your-work-email@example.com
EOF
  echo "  ⚠️  Edit ~/.gitconfig-work with your work email"
fi

# ─── Symlink dotfiles ────────────────────────────────────────────────
echo "==> Linking dotfiles"
ln -sfn "$DOTFILES/.zshrc" ~
ln -sfn "$DOTFILES/.vimrc" ~
ln -sfn "$DOTFILES/.gitconfig" ~
ln -sfn "$DOTFILES/.gitignore" ~
ln -sfn "$DOTFILES/.npmrc" ~

# Vim colorscheme
mkdir -p ~/.vim/colors
cp "$DOTFILES/.vim/colors/fairyfloss.vim" ~/.vim/colors/ 2>/dev/null || true

# ─── iTerm2 — load preferences from dotfiles ─────────────────────────
echo "==> Configuring iTerm2 to load preferences from dotfiles"
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES/.iterm"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# ─── VSCode ──────────────────────────────────────────────────────────
echo "==> Linking VSCode settings"
VSCODE_DIR="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSCODE_DIR"
ln -sfn "$DOTFILES/vscode/settings.json" "$VSCODE_DIR/settings.json"
ln -sfn "$DOTFILES/vscode/keybindings.json" "$VSCODE_DIR/keybindings.json"

if command -v code &>/dev/null; then
  echo "==> Installing VSCode extensions"
  xargs -L1 code --install-extension < "$DOTFILES/vscode/extensions.txt"
fi

# ─── Vim plugins ─────────────────────────────────────────────────────
echo "==> Installing vim plugins"
vim +PlugInstall +qall 2>/dev/null

# ─── Runtimes via mise ───────────────────────────────────────────────
echo "==> Installing runtimes"
mise install node@lts
mise use --global node@lts

# ─── Custom sounds ───────────────────────────────────────────────────
cp -r "$DOTFILES/Sounds/" ~/Library/Sounds/ 2>/dev/null || true

# ─── macOS defaults ──────────────────────────────────────────────────
echo "==> Applying macOS defaults"
chmod +x "$DOTFILES/macos.sh"
"$DOTFILES/macos.sh"

echo ""
echo "==> Done! Restart your terminal."
echo ""
echo "Manual steps:"
echo "  1. Run 'gh auth login' if not already authenticated"
echo "  2. Open iTerm2 — it will auto-load preferences from $DOTFILES/.iterm"
echo "  3. To save iTerm2 changes back: open Preferences → General → Preferences → check 'Save changes to folder when iTerm2 quits'"
