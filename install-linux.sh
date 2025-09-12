#!/bin/bash

sudo add-apt-repository ppa:longsleep/golang-backports -y

# Set additional repos
sudo apt-get update -y

# Set to forward SSH on to Windows
git config --global core.sshCommand ssh.exe

# Install required stuff
sudo apt install -y make \
  zsh \
  build-essential \
  wget \
  curl \
  llvm \
  tmux \
  fd-find \
  gnupg \
  software-properties-common \
  golang-go \
  lazygit

# Fix ubuntu aliases
ln -s $(which fdfind) ~/.local/bin/fd
ln -s /usr/bin/batcat ~/.local/bin/bat

# Install starship
curl -sS https://starship.rs/install.sh | sh

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install --no-update-rc

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

## Install Cargo Crates
cargo install bob-nvim ripgrep bat fnm

# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# completions
dir=~/.zfunc
[ -d ~/.zfunc ] || mkdir $HOME/.zfunc
fpath+=~/.zfunc
bob complete zsh >$dir/_bob
rg --generate complete-zsh >"$dir/_rg"
fnm completions --shell zsh >"$dir/_fnm"

# Install asdf
# ASDF_VERSION=$(curl -s "https://api.github.com/repos/asdf-vm/asdf/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
# git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch $ASDF_VERSION

# Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg |
  gpg --dearmor |
  sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" |
  sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt install terraform
