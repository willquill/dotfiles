#/bin/bash
sudo apt update
sudo apt install -y \
  zsh vim git tmux curl wget unzip fonts-hack-ttf

# Install spaceship prompt
git clone --depth=1 https://github.com/spaceship-prompt/spaceship-prompt.git "$HOME/.zsh/spaceship"

# Use ZSH as default shell
chsh -s $(which zsh)
