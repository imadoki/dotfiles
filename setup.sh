#! /bin/bash
# make symbolic link
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.gvimrc ~/.gvimrc
ln -s ~/dotfiles/.vimshrc ~/.vimshrc
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.latexmkrc ~/.latexmkrc
# nvim setting
mkdir -p ~/.config
ln -s ~/dotfiles/nvim/ ~/.config/nvim
# make directory
mkdir -p ~/.vim/tmp/bak
mkdir -p ~/.vim/tmp/swp
