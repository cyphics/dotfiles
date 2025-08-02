# TODO check if ~/dotfiles/ exists
#

dotfiles_folder=~/dotfiles

#ln -si ~/dotfiles/shell/.zshrc ~/.zshrc

ln -si "$dotfiles_folder/shell/.zshrc" ~/.zshrc
ln -si "$dotfiles_folder/tmux/.tmux.conf" ~/.tmux.conf
ln -si "$dotfiles_folder/bin/.local/bin" ~/.local/bin
ln -si "$dotfiles_folder/git/.gitconfig" ~/.gitconfig
ln -si "$dotfiles_folder/git/.gitignore_global" ~/.gitignore_global



ln -si "$dotfiles_folder/alacritty/.config/alacritty" ~/.config/alacitty
ln -si "$dotfiles_folder/i3/.config/i3" ~/.config/i3
ln -si "$dotfiles_folder/ownCloud/.config/ownCloud" ~/.config/ownCloud
