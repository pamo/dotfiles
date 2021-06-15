#!/usr/bin/env bash
# Login to Gitub
git credential-osxkeychain
git config --global credential.helper osxkeychain
git config --global user.name "Pamela Ocampo"
git config --global user.email "pamela.ocampo@gmail.com"

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
ln -sfn "$(pwd)/.zshrc" ~

# vim
ln -sfn "$(pwd)/.vim" ~
ln -sfn "$(pwd)/.vim/.vimrc" ~
mkdir ~/.vim/tmp
echo "Installing pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# vscode
ln -sf "$(pwd)/Code" /Users/$(whoami)/Library/Application\ Support

git submodule init
git submodule update --remote --rebase

echo "Installing brew and brew cask packages..."
./brew_setup.sh

# Custom Sounds
cp -r "$(pwd)/Sounds/" ~/Library/Sounds/

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -L git.io/antigen > antigen.zsh)"

exit 0
