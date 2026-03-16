#!/usr/bin/env bash
set -euo pipefail

# Minimal bootstrap for a fresh Mac — installs just enough to clone dotfiles and run setup.
# Usage: curl -fsSL https://raw.githubusercontent.com/pamo/dotfiles/main/bootstrap.sh | bash

DOTFILES_DIR="$HOME/me/dotfiles"
REPO="https://github.com/pamo/dotfiles.git"

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
