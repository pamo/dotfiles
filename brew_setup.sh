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
				adobe-photoshop-lightroom
				1password
				alfred
				alternote
				bartender
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
				screenhero
				slack
				spectacle
				spotify
)
brew cask install ${cask_packages[@]}
ln -s "$HOME/Dropbox/Documents" ~
