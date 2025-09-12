#!/bin/bash
#
# Install brew dependencies

if [ "$(uname)" == "Darwin" ]; then
  echo "Setting up for MacOS"
  brew bundle install --file ./Brewfile
  ln -s $(realpath ./.zshrc-mac) $HOME/.zshrc-mac
  ln -s $(realpath ./.tmux.conf.osx) $HOME/.tmux.conf.osx
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  echo "Setting up Linux"
  ./install-linux.sh
  ln -s $(realpath ./.zshrc-linux) $HOME/.zshrc-linux
else
  echo "Couldn't establish OS. Exiting"
  exit 1
fi

for config_dir in "nvim"; do
  rm -r $HOME/.config/${config_dir}
  ln -sn $(realpath ./.config/${config_dir}) $HOME/.config/${config_dir}
done

rm $HOME/.zshrc
ln -s $(realpath ./.zshrc) $HOME/.zshrc
ln -s $(realpath ./.tmux.conf) $HOME/.tmux.conf
ln -s $(realpath ./.tmux.powerline.conf) $HOME/.tmux.powerline.conf
