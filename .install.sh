# NvChad repo must be cloned before my dotfiles repo so it's empty
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim

# Clone dotfiles repo
git clone --bare https://github.com/cyphics/dotfiles.git $HOME/.dotfiles 

function dot {
  git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

dot checkout
dot config status.showUntrackedFiles no

# Shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# NVIM
# sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
#       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# RUST
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"



