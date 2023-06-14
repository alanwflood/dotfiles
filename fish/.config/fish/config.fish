set -Ux PAGER less
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -x LANG en_UK.UTF-8

# Source General Aliases
source $HOME/.config/fish/aliases.shared.fish

function fish_greeting
	if type -q fortune
		and type -q lolcat
	    fortune -s | lolcat
	end
end


# Per OS Setup
switch (uname)
    case Darwin # OSX
        # I rarely use ruby on work machines anymore
        # source /usr/local/share/chruby/chruby.fish
        # source /usr/local/share/chruby/auto.fish

        source $HOME/.config/fish/aliases.mac.fish

        set -gx ANDROID_HOME $HOME/Library/Android/sdk
        set -gx PATH $PATH $ANDROID_HOME/emulator
        set -gx PATH $PATH $ANDROID_HOME/tools
        set -gx PATH $PATH $ANDROID_HOME/tools/bin
        set -gx PATH $PATH $ANDROID_HOME/platform-tools
        set -U fish_user_paths "/opt/homebrew/bin" $fish_user_paths
    case Linux
        set -Ux BROWSER /usr/bin/firefox-developer-edition
        source /usr/share/chruby/chruby.fish
        source /usr/share/chruby/auto.fish

        source $HOME/.config/fish/aliases.linux.fish

        # Setup Global NPM packages
        set PATH "$HOME/.local/npm-global/bin:$PATH"
        set -Ux npm_config_prefix $HOME/.local/npm-global
end

# Ruby Gems path
set -gx PATH $PATH (ruby -e 'print Gem.user_dir')/bin
# Rust Cargo path
set -gx PATH $PATH $HOME/.cargo/bin
# doom-emacs commands path
set -gx PATH $PATH $HOME/.emacs.d/bin
# Volta node manager path
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
# thefuck integration
if type -q thefuck
	thefuck --alias | source
end

if type -q zoxide
	zoxide init fish | source
end

set -g theme_nerd_fonts yes
set -g theme_display_date no
set -g theme_color_scheme gruvbox

# NNN Settings
alias nnn="nnn -e"
set -Ux NNN_USE_EDITOR 1
set -Ux NNN_TRASH 1
set -Ux NNN_PLUG "p:rsynccp"

# Compatability for vterm inside emacs
function vterm_printf
    if [ -n "$TMUX" ]
        # tell tmux to pass the escape sequences through
        # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
        printf "\ePtmux;\e\e]%s\007\e\\ " "$argv"
    else if string match -q -- "screen*" "$TERM"
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end

# If fisher doesn't exist install it
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME $HOME/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# If Tmux Package Manager doesn't exist install it
if not test -d $HOME/.tmux/plugins/tpm
    if set -q TMUX
        git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    end
end

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
