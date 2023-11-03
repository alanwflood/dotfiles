# Dotfiles

See https://dev.to/writingcode/how-i-manage-my-dotfiles-using-gnu-stow-4l59

## Using stow

Ideally you'll use `stow` to symlink each of these dirs to the correct location.

For most folders you can symlink with `stow` using the following `stow -v -R -d [package to symlink] -t [location to symlink to] [dotfiles dir]`

Else following below cd into the dotfiles repo and execute the following commands:

### Neovim - Lazyvim config

```
stow -v -R -d ./lazyvim -t ~/.config/nvim .
```

### Neovim - Custom config

```
stow -v -R -d ./neovim -t ~/.config/nvim .
```

### Alacritty

```
stow -v -R -d ./alacritty -t ~/.config/alacritty .
```

### Tmux

```
stow -v -R -d ./tmux -t ~ .
```

### Fish

```
stow -v -R -d ./fish -t ~/.config/fish .
```
