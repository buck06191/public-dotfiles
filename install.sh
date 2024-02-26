#!/bin/bash
#
# Install brew dependencies

brew bundle install --file ./Brewfile

for config_dir in "nvim" "alacritty"; do
	rm -r $HOME/.config/${config_dir}
	ln -sn $(realpath ./.config/${config_dir}) $HOME/.config/${config_dir}
done

rm $HOME/.zshrc
ln -s $(realpath ./.zshrc) $HOME/.zshrc
