if [[ ! -x /usr/local/bin/brew ]] ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

     echo >> /Users/pamo/.zprofile
     echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/pamo/.zprofile
     eval "$(/opt/homebrew/bin/brew shellenv)"

brew bundle
brew cleanup

echo "installing nodenv"
nodenv install
eval "$(nodenv init -)"
