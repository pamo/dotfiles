if [[ ! -x /usr/local/bin/brew ]] ; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap homebrew/cask-versions
brew tap homebrew/cask-drivers
brew tap homebrew/cask-fonts

brew_packages=(
  autoconf
  autojump
  bash-completion
  chruby
  dos2unix
  findutils
  git
  git-extras
  grip
  gti
  htop-osx
  keepingyouawake
  markdown
  mas
  mysql
  nodenv
  node-build
  pkg-config
  python
  readline
  ripgrep
  ruby-build
  ruby-install
  ssh-copy-id
  tig
  trash
  tree
  unrar
  vim
  wget
)
brew install ${brew_packages[@]}

# apps
cask_packages=(
  1password
  alfred
  dash
  docker
  dockstation
  dropbox
  fantastical
  google-chrome
  iterm2-beta
  logitech-options
  lastfm
  qlcolorcode
  qlimagesize
  qlmarkdown
  quicklook-json
  rescuetime
  sequel-pro
  station
  spectacle
  spotify
  webpquicklook
  visual-studio-code
  viscosity
)

brew cask install --force --appdir="/Applications" ${cask_packages[@]}

rm -rf "$HOME/Documents"
ln -sfn "$HOME/Dropbox/Documents" $HOME

fonts=(
  font-fira-code
)

echo "Installing fonts..."
brew cask install --force ${fonts[@]}

brew cleanup

echo "Initializing nodenv"
nodenv init

echo "Installing giphy capture"
mas install 668208984
