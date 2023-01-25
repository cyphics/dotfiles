#!/usr/bin/env zsh

pushd /home/cyphics/ownCloud/dotfiles
STOW_FOLDERS="bin,i3,tmux,git,taskwarrior,nvim,shell,polybar,alacritty"
STOW_FOLDERS="i3"
mkdir -p ~/.config/nvim/plugged/
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
	echo "Linking content of $folder"
	stow --verbose=5 -Rt ~ $folder
done
popd
