#!/usr/bin/env bash
brew_packages=(
        autoconf
        autojump
        bash-completion
        dos2unix
        findutils
        git
        git-extras
        gti
        grip
        htop-osx
        markdown
        nodenv
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
brew uninstall ${brew_packages[@]}

cask_packages=(
        1password
        alfred
        alternote
        appcleaner
        bartender
        betterzipql
        cleanmymac
        dash
        dropbox
        fantastical
        flux
        focus
        google-chrome
        google-chrome-canary
        hipchat
        iterm2-beta
        lastfm
        polymail
        qlcolorcode
        qlimagesize
        qlmarkdown
        quicklook-json
        screenhero
        slack
        spectacle
        spotify
        suspicious-package
        transmission
        vlc
        webpquicklook
)
brew cask zap ${cask_packages[@]}

rm -r ~/.tmp
rm -rf ~/.bash_profile
rm -rf ~/.gitconfig
rm -rf ~/.gitignore
rm -rf ~/.gitattributes
rm -rf ~/.bash-it
rm -rf ~/.inputrc
rm -rf ~/.npmrc
rm -rf ~/.editorconfig
rm -r ~/.vim

exit 0
