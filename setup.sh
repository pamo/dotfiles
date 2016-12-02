#!/bin/sh

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

# vim
ln -s "$(pwd)/.vim" ~
mkdir ~/.vim/tmp

git submodule init
git submodule update

# utils
# Homebrew
if [[ ! -x /usr/local/bin/brew ]] ; then
                                /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

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
	flux
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
ln -s "$HOME/Dropbox/Documents" ~

# Bash Config
./.bash-it/install.sh -s -n
./.bash-it/configure.sh

# Install iterm themes
open iterm/*.itermcolors
exit 0
