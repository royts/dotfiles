#! /bin/bash

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
source $HOME/.zshrc
ln -s $HOME/dotfiles/git/gitconfig.symlink $HOME/gitconfig.symlink
ln -s $HOME/dotfiles/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/vim/.vimrc $HOME/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
