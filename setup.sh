#!/usr/bin/env bash

# Install Command Line Tools without Xcode
xcode-select --install

echo "Checking for updates..."
softwareupdate --install --all

echo "Setting OSX Defaults..."
./osx_defaults.sh

mkdir ~/.tmp
mkdir ~/dev
ln -sfn "$(pwd -P)" ~/
ln -sfn "$(pwd)/.bash_profile" ~
ln -sfn "$(pwd)/.gitconfig" ~
ln -sfn "$(pwd)/.gitignore" ~
ln -sfn "$(pwd)/.gitattributes" ~
ln -sfn "$(pwd)/.inputrc" ~
ln -sfn "$(pwd)/.gemrc" ~
ln -sfn "$(pwd)/.npmrc" ~
ln -sfn "$(pwd)/.editorconfig" ~

# vim
ln -sfn "$(pwd)/.vim" ~
ln -sfn "$(pwd)/.vim/.vimrc" ~
mkdir ~/.vim/tmp

# vscode
ln -sf "$(pwd)/Code" /Users/$(whoami)/Library/Application\ Support

git submodule init
git submodule update --remote --rebase

echo "Installing brew and brew cask packages..."
./brew_setup.sh

# Custom Sounds
cp -r "$(pwd)/Sounds/" ~/Library/Sounds/

exit 0
