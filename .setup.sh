#!/usr/bin/env bash
echo 'RUNNING NEW SYSTEM SETUP'

brew update

brew upgrade

echo 'INSTALLING THROUGH BREW'
# Installing the core stuff
brew install coreutils
brew install moreutils
brew install findutils

brew install htop
brew install httpie
brew install imagemagick --with-webp
brew install nmap
brew install speedtest_cli
brew install tmux
brew install wget --with-iri
# Ranger + it's dependencies
brew install ranger libcaca highlight atool lynx w3m elinks poppler transmission mediainfo exiftool

# Development
brew install python
brew install python3
brew install postgresql && brew services start postgres
brew install redis
brew install mongodb && brew services start mongodb

# webfont generators
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# the rest
brew install dark-mode
brew install buku
brew install git
brew install git-lfs
brew install mpd
brew install ncmpcpp
brew install ripgrep
brew install the_silver_searcher
brew install fzf
brew install zplug
brew install trash
brew install youtube-dl

brew install neovim
# Install vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install neovim python libraries
pip2 install --user neovim
pip3 install --user neovim

brew tap railwaycat/emacsmacport
brew install emacs-mac --with-gnutls --with-imagemagick --with-modules --with-texinfo --with-xml2 --with-spacemacs-icon
brew linkapps emacs-mac
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# version managers
# nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
# yarn
brew install yarn
# chruby
brew install chruby
brew install ruby-install

# Remove outdated versions from the cellar.
brew cleanup

# Cask time!
brew tap caskroom/cask

echo 'INSTALLING THROUGH BREW CASK'
brew cask install alfred
brew cask install bartender
brew cask install bettertouchtool
brew cask install calibre
brew cask install dropbox
brew cask install google-chrome
brew cask install iterm2
brew cask install keepassxc
brew cask install mongodb-compass
brew cask install mpv
brew cask install nextcloud
brew cask install onyx
brew cask install osxfuse
brew cask install plex-media-player
brew cask install sketch
brew cask install smcfancontrol
brew cask install soulseek
brew cask install spotify
brew cask install the-unarchiver
brew cask install transmission-remote-gui
brew cask install tunnelblick
brew cask install veracrypt
brew cask install zeplin

# Fetch and install firefox nightly
brew cask fetch caskroom/versions/firefox-nightly
brew cask install firefox-nightly

# Add cask auto upgrade functionality
brew tap buo/cask-upgrade

echo 'INSTALLING THROUGH NPM'
# global js packages
npm install -g prettier tern eslint preact-cli js-beautify

echo 'INSTALLING THROUGH PIP'
# global python packages
pip install wakatime

echo 'FINITO SETTING UP WOOP WOOP 🎉'
echo 'Remember you still need to download the following manually from the app store: Giphy, Amphetamine'
