#!/bin/sh

ln -s "$(pwd)/.bash_profile" ~
ln -s "$(pwd)/.gitconfig" ~
ln -s "$(pwd)/.gitignore" ~
ln -s "$(pwd)/.gitattributes" ~

# vim
ln -s "$(pwd)/.vim" ~
mkdir ~/.vim/tmp
git submodule init
git submodule update

# speed up keystroke
defaults write -g KeyRepeat -int 0.5

# trash
brew install trash

# utils
brew install tree
brew install translate-shell


# bash config
git clone --depth=1 https://github.com/pamo/bash-it.git ~/.bash_it
cd ~/.bash_it && ./install.sh

exit 0
