#!/usr/bin/env zsh

pushd ~/ownCloud/dotfiles
STOW_FOLDERS="bin,i3,tmux,git,taskwarrior,nvim,zsh"
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
	echo "f: $folder"
	stow -Rvt ~ $folder
	#stow -v $folder
done
popd
