#!/usr/bin/env bash
echo 'RUNNING NEW SYSTEM SETUP'

# Check for Homebrew, install if it's missing
if test ! "$(which brew)"; then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade

echo 'INSTALLING THROUGH BREW'
# Installing the core stuff
brew install coreutils
brew install moreutils
brew install findutils

brew install htop
brew install imagemagick
brew install nmap
brew install speedtest_cli

# Tmux and Tmux Plugin Manager
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

brew install tree
brew install --cask osxfuse
brew install reattach-to-user-namespace
brew install rs/tap/curlie
brew install wget
brew install nnn

# Fun stuff
brew install cowsay lolcat fortune figlet

# Fish shell
brew install fish
chsh -s "$(which fish)"

# Development
brew install python
brew install python3
brew install postgresql && brew services start postgres
brew install redis
brew install mongodb && brew services start mongodb

# C/C++
brew install cmake
brew install ccls

# Install rust language with sane defaults
brew install rustup
rustup-init -y
rustup default stable
rustup component add rls-preview rust-analysis rust-src
brew install rust-analyzer

# webfont generators
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# the rest
brew install dark-mode
brew install git
brew install git-lfs
brew install tig
brew install fd
brew install jq
brew install shellcheck
brew install ripgrep
brew install trash
brew install editorconfig

brew install fzf
$(brew --prefix)/opt/fzf/install


# Neovim
brew install neovim
# Install vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install neovim python libraries
pip2 install --user neovim
pip3 install --user neovim

# Emacs
brew tap d12frosted/emacs-plus
brew install emacs-plus
ln -s /usr/local/opt/emacs-plus/Emacs.app /Applications/Emacs.app
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

# version managers

# node version manager
brew install volta
# chruby
brew install chruby
brew install ruby-install

# Remove outdated versions from the cellar.
brew cleanup

# Cask time!
brew tap caskroom/cask

echo 'INSTALLING THROUGH BREW CASK'

CASKS=(
  alacritty
  alfred
  bartender
  bettertouchtool
  bitwarden
  dbeaver-community
  disk-inventory-x
  docker
  google-chrome
  figma
  imageoptim
  intellij-idea-ce
  java
  macdown
  miro
  mpv
  nextcloud
  nightowl
  onyx
  postman
  sketch
  spotify
  the-unarchiver
  tunnelblick
  virtualbox
)

brew install --cask "${CASKS[@]}"

# Fetch and install firefox developer edition
brew fetch --cask caskroom/versions/firefox-developer-edition
brew install --cask firefox-developer-edition

# Add cask auto upgrade functionality
brew tap buo/cask-upgrade

echo 'INSTALLING THROUGH NPM'
# global js packages
npm i -g lighthouse \
         depcheck \
         eslint \
         js-beautify \
         neovim \
         npm-check-updates \
         prettier \
         stylelint \
         tldr

echo 'INSTALLING THROUGH PIP'
# global python packages
pip3 install wakatime

echo 'SETTING DEFAULTS'

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

mkdir ~/Code
mkdir ~/Code/Misc
git clone https://github.com/sebastiencs/icons-in-terminal.git ~/Code/Misc
sh ~/Code/Misc/icons-in-terminal/install.sh

mkdir ~/Sites
mkdir ~/Sites/Work
mkdir ~/Sites/Education
mkdir ~/Sites/Personal

echo 'FINITO SETTING UP WOOP WOOP 🎉'
echo 'Remember you still need to download the following manually from the app store: Giphy, Amphetamine. Afinity apps, etc'
