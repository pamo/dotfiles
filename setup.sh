#!/usr/bin/env bash

echo "Install Command Line Tools without Xcode"
xcode-select --install

echo "Check for github ssh keys"
./git-login.sh

echo "Checking for updates..."
softwareupdate --install --all

echo "Setting OSX Defaults..."
./osx_defaults.sh

mkdir ~/.tmp
mkdir ~/dev

sudo ln -sfn "$(pwd -P)" ~/
sudo ln -sfn "$(pwd)/.bash_profile" ~
sudo ln -sfn "$(pwd)/.gitconfig" ~
sudo ln -sfn "$(pwd)/.gitignore" ~
sudo ln -sfn "$(pwd)/.gitattributes" ~
sudo ln -sfn "$(pwd)/.inputrc" ~
sudo ln -sfn "$(pwd)/.gemrc" ~
sudo ln -sfn "$(pwd)/.npmrc" ~
sudo ln -sfn "$(pwd)/.zshrc" ~
sudo ln -s "$(pwd)/.iterm" ~
sudo rm "$(pwd)/.GlobalPreferences.plist"
sudo ln -s "$(pwd)/.GlobalPreferences.plist" ~/Library/Preferences

# vim
sudo ln -sfn "$(pwd)/.vim" ~
sudo ln -sfn "$(pwd)/.vim/.vimrc" ~
sudo ln -sfn "$(pwd)/.vim/.ideavimrc" ~
mkdir ~/.vim/tmp

echo "Installing pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo "Installing brew and brew cask packages..."
./brew_setup.sh

# vscode
sudo ln -sf "$(pwd)/Code" /Users/$(whoami)/Library/Application\ Support

git submodule init
git submodule update --remote --rebase

# Custom Sounds
cp -r "$(pwd)/Sounds/" ~/Library/Sounds/

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -L git.io/antigen > antigen.zsh)"

sudo chmod 755 /usr/local/share/zsh
sudo chmod 755 /usr/local/share/zsh/functions

echo "Link documents to dropbox"
cd $HOME
rm -rf "Documents"
sudo ln -sfn "$HOME/Dropbox/Documents" $HOME


echo "Manual steps:"
echo "1 - Open iTerm2 preferences and check the Load Preferences checkbox pointing to ~/.iterm"
echo "2 - Go to Profiles > Text and change the font to Fira Code"

exit 0
