#!/usr/bin/env zsh

pushd ~/ownCloud/dotfiles
STOW_FOLDERS="bin,i3,tmux,git,taskwarrior,nvim,shell,polybar"
mkdir -p ~/.config/nvim/plugged/
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
	echo "Linking content of $folder"
	stow -Rvt ~ $folder
done
popd
