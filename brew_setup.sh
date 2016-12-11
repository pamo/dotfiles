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
brew install ${brew_packages[@]}

# apps
cask_packages=(
        1password
        adobe-photoshop-lightroom
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
brew cask install ${cask_packages[@]}

ln -s "$HOME/Dropbox/Documents" ~
rbenv init
nodenv init
