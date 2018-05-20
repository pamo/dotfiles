if [[ ! -x /usr/local/bin/brew ]] ; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

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
  grip
  gti
  htop-osx
  markdown
  nodenv
  pkg-config
  python
  rbenv
  rbenv-gemset
  readline
  ripgrep
  ruby-build
  ssh-copy-id
  the_silver_searcher
  tig
  trash
  tree
  unrar
  vim --with-override-system-vi
  wget
)
brew install ${brew_packages[@]}

# apps
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
  rescuetime
  slack
  spectacle
  spotify
  suspicious-package
  transmission
  vlc
  webpquicklook
)

brew cask install --force --appdir="/Applications" ${cask_packages[@]}

rm -rf "$HOME/Documents"
ln -sfn "$HOME/Dropbox/Documents" $HOME
# Install fonts
brew tap caskroom/fonts

fonts=(
  font-clear-sans
  font-roboto
  font-source-code-pro
  font-inconsolata
  font-hack
)

echo "Installing fonts..."
brew cask install --force ${fonts[@]}

brew cleanup

echo "Initializing rbenv"
rbenv init

echo "Initializing nodenv"
nodenv init
