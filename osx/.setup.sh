#!/usr/bin/env bash
echo 'RUNNING NEW SYSTEM SETUP'

function checkBrew {
	# Check for Homebrew, install if it's missing
	if test ! "$(which brew)"; then
	    echo "Installing homebrew..."
	    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	brew update
	brew upgrade
}

function installCore {
	echo 'INSTALLING PACKAGES THROUGH BREW'
	# Installing the core stuff
	brew install --cask osxfuse
	brew tap bramstein/webfonttools

	brew install \
		coreutils \
		moreutils \
		findutils \
		htop \
		imagemagick \
		nmap \
		speedtest_cli \
		tmux \
		bat \
		tree \
		reattach-to-user-namespace \
		rs/tap/curlie \
		wget \
		nnn \
		# Fun stuff
		cowsay lolcat fortune figlet 
		# webfont generators
		sfnt2woff \
		sfnt2woff-zopfli \
		woff2 \
		# the rest
		dark-mode \
		git \
		git-lfs \
		tig \
		fd \
		jq \
		shellcheck \
		ripgrep \
		trash \
		editorconfig \
		stow \
		fzf

	# Setup fzf
	$(brew --prefix)/opt/fzf/install --all

	# Install Tmux Plugin Manager
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

function installFish {
	echo 'INSTALLING FISH SHELL'
	# Install Fish shell
	brew install fish
	# Add fish executable path to shells file
	grep -xqF "$(which fish)" /etc/shells || echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
	chsh -s "$(which fish)"
}

function installDevelopmentTools {
	echo 'INSTALLING DEV TOOLS'
	# Development
	brew install \
		# node version manager
		volta \
		python \
		postgresql \
		redis \
		# C/C++
		cmake \
		ccls \
		# Rust
		rustup \
		rust-analyzer
		# chruby
		chruby ruby-install

	# Set rust to sane defaults
	source $HOME/.cargo/env
	rustup-init -y
	rustup default stable
	rustup component add rls-preview rust-analysis rust-src

	# setup node
	volta install node
	volta install npm

	# brew services start postgres
}

function installNeovim {
# Neovim
brew install neovim
# Install vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

function installEmacs {
# Emacs
brew tap d12frosted/emacs-plus
brew install emacs-plus
ln -s /usr/local/opt/emacs-plus/Emacs.app /Applications/Emacs.app
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
brew services start emacs-plus
}

function installCasks {
	# Cask time!
	brew tap homebrew/cask

	echo 'INSTALLING PACKAGES THROUGH BREW CASK'

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

	brew install --cask adoptopenjdk
	brew install --cask "${CASKS[@]}"

	# Fetch and install firefox developer edition
	brew fetch --cask homebrew/cask-versions/firefox-developer-edition
	brew install --cask firefox-developer-edition

	# Add cask auto upgrade functionality
	brew tap buo/cask-upgrade

	# Set associations for new apps
	brew install duti
	MPV_FILETYPES=(
		wav
		mp3
		mp4
		ogg
		flv
		m4a
		flac
		avi
		wma
		m3u
		cue
		pls
		aiff
		mkv
	)
	for filetype in $MPV_FILETYPES; do
		duti -s io.mpv $filetype all
	done
}


function installNpmPackages {
	echo 'INSTALLING PACKAGES THROUGH NPM'
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
}

function installPipPackages {
	echo 'INSTALLING PACKAGES THROUGH PIP'
	# global python packages
	pip3 install wakatime
	pip3 install --user neovim
}

function setupUpMachine {
	echo 'SETTING DEFAULTS'

	# Show filename extensions by default
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true

	echo 'SETTING UP FOLDERS'

	mkdir ~/Code
	mkdir ~/Code/Misc
	# git clone https://github.com/sebastiencs/icons-in-terminal.git ~/Code/Misc
	# sh ~/Code/Misc/icons-in-terminal/install.sh

	mkdir ~/Sites
	mkdir ~/Sites/Work
	mkdir ~/Sites/Education
	mkdir ~/Sites/Personal
}

checkBrew
installCore
intallFish
installDevelopmentTools
installMisc
# installNeovim
# installEmacs

# Remove outdated versions from the cellar.
brew cleanup

# installCasks
installNpmPackages
installPipPackages
setupMachine

echo 'FINITO SETTING UP WOOP WOOP 🎉'
echo 'Remember you still need to download the following manually from the app store: Giphy, Amphetamine. Afinity apps, etc'
