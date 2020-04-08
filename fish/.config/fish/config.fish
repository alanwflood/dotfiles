set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux PAGER less

# Source General Aliases
source $HOME/.config/fish/aliases.shared.fish

# Per OS Setup
switch (uname)
  case Darwin # OSX
    source /usr/local/share/chruby/chruby.fish
    source /usr/local/share/chruby/auto.fish

    source $HOME/.config/fish/aliases.mac.fish

    set -gx ANDROID_HOME $HOME/Library/Android/sdk
    set -gx PATH $PATH $ANDROID_HOME/emulator
    set -gx PATH $PATH $ANDROID_HOME/tools
    set -gx PATH $PATH $ANDROID_HOME/tools/bin
    set -gx PATH $PATH $ANDROID_HOME/platform-tools
    set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
  case Linux
    set -Ux BROWSER /usr/bin/firefox-developer-edition
    source /usr/share/chruby/chruby.fish
    source /usr/share/chruby/auto.fish

    source $HOME/.config/fish/aliases.linux.fish

    # Setup Global NPM packages
    set PATH "$HOME/.local/npm-global/bin:$PATH"
    set -Ux npm_config_prefix $HOME/.local/npm-global
end

# Setup Ruby Gems path
set -gx PATH $PATH (ruby -e 'print Gem.user_dir')/bin
# Setup Rust Cargo path
set -gx PATH $PATH $HOME/.cargo/bin

set -g theme_nerd_fonts yes
set -g theme_display_date no
set -g theme_color_scheme gruvbox

# NNN Settings
set -Ux NNN_USE_EDITOR 1
set -Ux NNN_TRASH 1

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

function bobthefish_colors -S -d 'Define a custom bobthefish color scheme'
  # Optionally include a base color scheme
  __bobthefish_colors gruvbox

  # Then override everything you want!
  # Note that these must be defined with `set -x`
  set -x color_path                     blue white
  set -x color_path_basename            blue white --bold
  # set -x color_path_nowrite             magenta black
  # set -x color_path_nowrite_basename    magenta black --bold
  #
  set -x color_repo                     brgreen black
  # set -x color_repo_work_tree           black black --bold
  set -x color_repo_dirty                 red brwhite
  # set -x color_repo_staged              yellow black
  #
  # set -x color_vi_mode_default          brblue black --bold
  # set -x color_vi_mode_insert           brgreen black --bold
  # set -x color_vi_mode_visual           bryellow black --bold
  #
  # set -x color_vagrant                  brcyan black
  # set -x color_k8s                      magenta white --bold
  # set -x color_username                 white black --bold
  # set -x color_hostname                 white black
  # set -x color_rvm                      brmagenta black --bold
  # set -x color_virtualfish              brblue black --bold
  # set -x color_virtualgo                brblue black --bold
  # set -x color_desk                     brblue black --bold
end
