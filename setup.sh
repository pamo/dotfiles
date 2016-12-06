#!/usr/bin/env bash

# Install Command Line Tools without Xcode
xcode-select --install

echo "Checking for updates..."
softwareupdate --install --all

echo "Setting OSX Defaults..."
./osx_defaults.sh

mkdir ~/.tmp
ln -s "$(pwd)/.bash_profile" ~
ln -s "$(pwd)/.gitconfig" ~
ln -s "$(pwd)/.gitignore" ~
ln -s "$(pwd)/.gitattributes" ~
ln -s "$(pwd)/.bash-it" ~
ln -s "$(pwd)/.inputrc" ~
ln -s "$(pwd)/.editorconfig" ~

# vim
ln -s "$(pwd)/.vim" ~
ln -s "$(pwd)/.vim/.vimrc" ~
mkdir ~/.vim/tmp

git submodule init
git submodule update

echo "Installing brew and brew cask packages..."
./brew_setup.sh

# Bash Config
./.bash-it/install.sh -s -n
./.bash-it/configure.sh

# Install iterm themes
open iterm/*.itermcolors

./node_config.sh
exit 0
