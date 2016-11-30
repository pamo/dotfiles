#!/bin/sh

rm ~/.bash_profile
rm ~/.gitconfig
rm ~/.gitignore
rm -r ~/.iterm

# vim
rm ~/.vim

# speed up keystroke
defaults delete NSGlobalDomain KeyRepeat

exit 0
