#!/usr/bin/env bash
set -euo pipefail

# Minimal bootstrap for a fresh Mac — installs just enough to clone dotfiles and run setup.
# Usage: curl -fsSL https://raw.githubusercontent.com/pamo/dotfiles/main/bootstrap.sh | bash
#
# Prerequisites:
#   1. Generate an SSH key: ssh-keygen -t ed25519 -C "your@email.com"
#   2. Add ~/.ssh/id_ed25519.pub to https://github.com/settings/keys
#   3. Then run this script

DOTFILES_DIR="$HOME/me/dotfiles"
REPO="git@github.com:pamo/dotfiles.git"

# Verify SSH key is available before attempting clone
if ! ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
  echo "ERROR: SSH key not authorized with GitHub."
  echo "  1. Generate a key: ssh-keygen -t ed25519 -C 'your@email.com'"
  echo "  2. Add it to GitHub: https://github.com/settings/keys"
  exit 1
fi

echo "==> Installing Xcode CLI tools (for git)"
xcode-select --install 2>/dev/null || true

# Wait for xcode-select to finish if it kicked off an install
until xcode-select -p &>/dev/null; do
  echo "  Waiting for Xcode CLI tools..."
  sleep 5
done

if [ -d "$DOTFILES_DIR/.git" ]; then
  echo "==> Dotfiles already cloned at $DOTFILES_DIR, pulling latest"
  git -C "$DOTFILES_DIR" pull --rebase
else
  echo "==> Cloning dotfiles"
  mkdir -p "$(dirname "$DOTFILES_DIR")"
  git clone "$REPO" "$DOTFILES_DIR"
fi

echo "==> Running setup"
cd "$DOTFILES_DIR"
./setup.sh
