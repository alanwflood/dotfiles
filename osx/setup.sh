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

function installCorePackages {
	echo 'INSTALLING PACKAGES THROUGH BREW'
	# Installing the core stuff
	brew tap bramstein/webfonttools

	CORE_PACKAGES=(
		bat
		coreutils
		cowsay
		dark-mode
		editorconfig
		fd
		figlet
		findutils
		fortune 
		fzf
		git
		htop
		imagemagick
		jq
		lazygit
		lolcat 
		moreutils
		nmap
		nnn
		reattach-to-user-namespace
		ripgrep
		sfnt2woff
		sfnt2woff-zopfli
		speedtest_cli
		stow
		tealdeer
		tmux
		trash
		tree
		wget
		woff2
	)

	brew install "${CORE_PACKAGES[@]}"

	# Setup fzf
	"$(brew --prefix)/opt/fzf/install --all"

	# Install Tmux Plugin Manager
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

function installFish {
	echo 'INSTALLING FISH SHELL'

	# Install Fish shell
	brew install fish
	# Add fish executable path to shells file
	grep -xqF "$(which fish)" /etc/shells || which fish | sudo tee -a /etc/shells
	chsh -s "$(which fish)"
}

function installDevelopmentTools {
	echo 'INSTALLING DEV TOOLS & LANGUAGES'

	DEV_PACKAGES=(
		python
		postgresql
		redis
		volta
		cmake
		ccls
		rustup
		rust-analyzer
                go # chruby
		# ruby-install
	)

	# Development
	brew install "${DEV_PACKAGES[@]}"

	# Set rust to sane defaults
	source "$HOME"/.cargo/env
	rustup-init -y
	rustup default stable
	rustup component add rls-preview rust-analysis rust-src

	# setup node
	volta install node
	volta install npm
}

function installNeovim {
	echo 'INSTALLING NEOVIM'

	# Neovim
	brew install neovim
	# Install vim plug
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

function installEmacs {
  # Emacs
	brew tap railwaycat/emacsmacport
	brew install emacs-mac --with-modules
	ln -s /usr/local/opt/emacs-mac/Emacs.app /Applications/Emacs.app
  git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
  ~/.emacs.d/bin/doom install
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
		dbeaver-community
		disk-inventory-x
		docker
		google-chrome
		figma
		imageoptim
		mpv
		onyx
		postman
		spotify
		the-unarchiver
	)

	brew install --cask "${CASKS[@]}"

}

function assignMpvFiletypes {
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

	for filetype in "${MPV_FILETYPES[@]}"; do
		duti -s io.mpv "$filetype" all
	done
}


function installNpmPackages {
	echo 'INSTALLING PACKAGES THROUGH NPM'

	# global js packages
	npm i -g \
		lighthouse \
		depcheck \
		neovim \
		npm-check-updates \
		prettier
}

function installPipPackages {
	echo 'INSTALLING PACKAGES THROUGH PIP'

	# global python packages
	pip3 install wakatime
	pip3 install --user neovim
}

function setupMachine {
	echo 'SETTING DEFAULTS'

	# Show filename extensions by default
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true

	echo 'SETTING UP FOLDERS'
}

checkBrew
installCorePackages
installFish
installDevelopmentTools
installNeovim
# installEmacs

# Remove outdated versions from the cellar.
brew cleanup

installCasks
installNpmPackages
installPipPackages
assignMpvFiletypes
setupMachine

echo 'FINITO SETTING UP WOOP WOOP 🎉'
echo 'Remember you still need to download the following manually from the app store: Giphy, Amphetamine. Afinity apps, etc'
