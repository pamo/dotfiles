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
brew_packages=(
	autoconf
	autojump
	bash-completion
	dos2unix
	git
	git-extras
	gti
	htop-osx
	markdown
	pkg-config
	rbenv
	rbenv-gemset
	readline
	rsync
	ruby-build
	ssh-copy-id
	the_silver_searcher
	tree
	unrar
	vim
	wget
)
brew install ${brew_packages[@]}


# apps
cask_packages=(
	1password
	alternote
	bartender
	dash
	dropbox
	fantastical
	google-chrome
	hipchat
	lastfm
	screenhero
	slack
	spectacle
	spotify
)
brew cask install {cask_packages[@]}

# bash config
git clone --depth=1 https://github.com/pamo/bash-it.git ~/.bash_it
cd ~/.bash_it && ./install.sh

exit 0
