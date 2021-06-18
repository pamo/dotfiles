if [[ ! -x /usr/local/bin/brew ]] ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


brew bundle
brew cleanup

echo "Initializing nodenv"
nodenv init
