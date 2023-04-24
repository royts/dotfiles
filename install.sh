#! /bin/bash

# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# install with package manager
git zsh vim-gui-common ncdu fzf slack jetbrains-toolbox visual-studio-code geany spotify yt-music keep maccy jq
https://docs.docker.com/desktop/mac/install/


ln -s $HOME/dotfiles/git/gitconfig.symlink $HOME/gitconfig.symlink
ln -s $HOME/dotfiles/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/git/.gitignore $HOME/.gitignore
ln -s $HOME/dotfiles/vim/.vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/vim/.ideavimrc $HOME/.ideavimrc
ln -s $HOME/dotfiles/bin $HOME/bin
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
curl https://pyenv.run | bash
pyenv install 3.7.10
pyenv global 2.7.10
# (osx) ln -s $HOME/dotfiles/vscode/keybindings.json /Library/Application\ Support/Code/User/keybindings.json
# (osx) defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
pip install tabview

brew install pipenv
ln -s $(brew --cellar python)/* ~/.pyenv/versions/ # The way Homebrew works nowadays
pipenv --python ~/.pyenv/versions/3.9.9/bin/python3

# (still needed?)# npm global in PATH
# (still needed?)mkdir $HOME/.npm-global
# (still needed?)npm config set prefix `$HOME/.npm-global`

# OSX stuff
# cursor speed
defaults write NSGlobalDomain KeyRepeat -int 2

# font smoothing
defaults -currentHost delete -globalDomain AppleFontSmoothing
defaults -currentHost write -globalDomain AppleFontSmoothing -int 2

# apple cheapset
softwareupdate --install-rosetta

# gh - fedora
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh

# gh xubuntu
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt update
sudo apt install gh
