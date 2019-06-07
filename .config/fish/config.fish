set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux PAGER less

source $HOME/.config/fish/aliases.mac.fish
source $HOME/.config/fish/aliases.shared.fish

source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish

set -gx PATH $PATH /usr/local/anaconda3/bin

set -g theme_nerd_fonts yes
set -g theme_display_date no
set -g theme_color_scheme gruvbox

set -Ux NNN_USE_EDITOR 1
set -Ux NNN_TRASH 1


function bobthefish_colors -S -d 'Define a custom bobthefish color scheme'

  # Optionally include a base color scheme
  __bobthefish_colors default

  # Then override everything you want!
  # Note that these must be defined with `set -x`
  set -x color_path                     blue white
  set -x color_path_basename            blue white --bold
  # set -x color_path_nowrite             magenta black
  # set -x color_path_nowrite_basename    magenta black --bold
  #
  # set -x color_repo                     green black
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
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

