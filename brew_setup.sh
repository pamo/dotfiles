if [[ ! -x /usr/local/bin/brew ]] ; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap homebrew/cask-versions
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
  markdown
  mysql
  nodenv
  pkg-config
  python
  readline
  ripgrep
  ruby-build
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
  dropbox
  fantastical
  google-chrome
  iterm2-beta
  lastfm
  qlcolorcode
  qlimagesize
  qlmarkdown
  quicklook-json
  rescuetime
  station
  spectacle
  spotify
  webpquicklook
  visual-studio-code
)

brew cask install --force --appdir="/Applications" ${cask_packages[@]}

rm -rf "$HOME/Documents"
ln -sfn "$HOME/Dropbox/Documents" $HOME
# Install fonts
brew tap caskroom/fonts

fonts=(
  font-fira-code
)

echo "Installing fonts..."
brew cask install --force ${fonts[@]}

brew cleanup

echo "Initializing nodenv"
nodenv init
