#!/usr/bin/env bash
cask_packages=(
	adobe-photoshop-lightroom
        1password
        alfred
        alternote
        bartender
        dash
        dropbox
        fantastical
        flux
	focus
        google-chrome
        hipchat
        iterm2-beta
        lastfm
        polymail
        screenhero
        slack
        spectacle
        spotify
)
brew cask zap ${cask_packages[@]}

rm -r ~/iterm
rm -r ~/.bash-it
rm -r ~/.inputrc
rm -r ~/.tmp
rm -r ~/.bash_profile
rm -r ~/.editorconfig
rm -r ~/.gitattributes
rm -r ~/.gitconfig
rm -r ~/.gitignore
rm -r ~/.vim

exit 0
