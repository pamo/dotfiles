#!/bin/sh
mkdir ~/.tmp

ln -s "$(pwd)/.bash_profile" ~
ln -s "$(pwd)/.gitconfig" ~
ln -s "$(pwd)/.gitignore" ~
ln -s "$(pwd)/.gitattributes" ~
ln -s "$(pwd)/.bash_it" ~

# Install Command Line Tools without Xcode
xcode-select --install

# vim
ln -s "$(pwd)/.vim" ~
mkdir ~/.vim/tmp

git submodule init
git submodule update

# utils
brew tap homebrew/versions
brew tap caskroom/cask
brew tap caskroom/versions
brew tap caskroom/fonts

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
	ruby-build
	ssh-copy-id
	the_silver_searcher
	tig
	tree
	trash
	unrar
	vim
	wget
)
brew install ${brew_packages[@]}

# apps
cask_packages=(
	1password
	alfred
	alternote
	bartender
	dash
	dropbox
	fantastical
	google-chrome
	hipchat
	iterm2-beta
	lastfm
	screenhero
	slack
	spectacle
	spotify
)
brew cask install ${cask_packages[@]}

# bash config
./.bash_it/install.sh

echo "Setting OSX Defaults..."
./osx_defaults.sh
exit 0
