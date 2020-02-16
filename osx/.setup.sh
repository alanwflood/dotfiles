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
# Tmux and Tmux Plugin Manager
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

brew install tree
brew install ntfs-3g
brew install reattach-to-user-namespace --with-wrap-pbcopy-and-pbpaste
brew install wget --with-iri
# Ranger + it's dependencies
# brew install ranger libcaca highlight atool lynx w3m elinks poppler transmission mediainfo exiftool
brew install nnn

# Fun stuff
brew install cowsay lolcat fortune figlet

# Fish shell
brew install fish

# Fisher package manager
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

FISHER_PACKAGES=(
  "brigand/fast-nvm-fish",
  "jethrokuan/fzf",
  "jethrokuan/z",
  "oh-my-fish/plugin-bang-bang",
  "oh-my-fish/theme-bobthefish"
)
fisher add "${FISHER_PACKAGES[@]}"
unset -v FISHER_PACKAGES

# Development
brew install python
brew install python3
brew install postgresql && brew services start postgres
brew install redis
brew install mongodb && brew services start mongodb
brew install rustup

# Language Servers
brew install ccls

# Install rust language with sane defaults
rustup-init -y
rustup default stable
rustup component add rls-preview rust-analysis rust-src

# Install Dart
# brew tap dart-lang/dart
# brew install dart

# webfont generators
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# the rest
brew install dark-mode
brew install git
brew install git-lfs
brew install ripgrep

brew install fzf
$(brew --prefix)/opt/fzf/install

# brew install zplug
brew install trash
brew install youtube-dl

# Neovim
brew install neovim
# Install vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install neovim python libraries
pip2 install --user neovim
pip3 install --user neovim

# Emacs
# brew tap railwaycat/emacsmacport
# brew install emacs-mac --with-gnutls --with-imagemagick --with-modules --with-texinfo --with-xml2 --with-spacemacs-icon
# brew linkapps emacs-mac
# git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# version managers
# nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
# chruby
brew install chruby
brew install ruby-install

# Remove outdated versions from the cellar.
brew cleanup

# Cask time!
brew tap caskroom/cask

echo 'INSTALLING THROUGH BREW CASK'
# old
# brew cask install charles
# brew cask install iterm2
# brew cask install oni
# brew cask install smcfancontrol
# brew cask install transmission-remote-gui
# brew cask install whatsapp
# brew cask install soulseek

brew cask install alcritty
brew cask install alfred
brew cask install android-studio android-platform-tools
brew cask install bartender
brew cask install bettertouchtool
brew cask install bitwarden
brew cask install calibre
brew cask install dbeaver-community
brew cask install disk-inventory-x
brew cask install docker
brew cask install dropbox
brew cask install google-chrome
brew cask install figma
brew cask install imageoptim
brew cask install intellij-idea-ce
brew cask install java
brew cask install karabinder-elements
brew cask install mongodb-compass
brew cask install mpv
brew cask install nextcloud
brew cask install ngrok
brew cask install nightowl
brew cask install onyx
brew cask install osxfuse
brew cask install plex-media-player
brew cask install postman
brew cask install sketch
brew cask install spotify
brew cask install the-unarchiver
brew cask install tunnelblick
brew cask install veracrypt
brew cask install virtualbox vagrant
brew cask install zeplin

# Fetch and install firefox nightly
brew cask fetch caskroom/versions/firefox-nightly
brew cask install firefox-nightly

# Add cask auto upgrade functionality
brew tap buo/cask-upgrade

echo 'INSTALLING THROUGH NPM'
# global js packages
npm i -g lighthouse \
        expo-cli \
        bs-platform \
        eslint \
        javascript-typescript-langserver \
        js-beautify \
        neovim \
        now \
        npm-check-updates \
        prettier \
        tldr \
        vue-language-server

echo 'INSTALLING THROUGH PIP'
# global python packages
pip install wakatime

echo 'FINITO SETTING UP WOOP WOOP 🎉'
echo 'Remember you still need to download the following manually from the app store: Giphy, Amphetamine. Afinity apps, etc'
