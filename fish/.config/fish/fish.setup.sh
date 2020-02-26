#!/bin/bash

# Install fisher
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
# Install fisher packages
fisher add oh-my-fish/theme-bobthefish jethrokuan/z jethrokuan/fzf oh-my-fish/plugin-bang-bang brigand/fast-nvm-fish matchai/spacefish
