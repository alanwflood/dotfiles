# Install fisher
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
# Install fisher packages
fisher add oh-my-fish/theme-bobthefish jethrokuan/z jethrokuan/fzf oh-my-fish/plugin-bang-bang brigand/fast-nvm-fish

# Install docker autocompletions
cd ~/.config/fish/completions
wget 'https://github.com/docker/cli/blob/master/contrib/completion/fish/docker.fish'