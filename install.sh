#! /bin/bash

# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# install with package manager
git zsh vim-gui-common ncdu fzf


sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s /bin/zsh roy
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
mv $HOME/.zshrc{,_old} && ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/zsh/royts.zsh-theme $HOME/.oh-my-zsh/themes/royts.zsh-theme
source $HOME/.zshrc
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

# (still needed?)# npm global in PATH
# (still needed?)mkdir $HOME/.npm-global
# (still needed?)npm config set prefix `$HOME/.npm-global`



# (osx) # cursor speed
# (osx) defaults write NSGlobalDomain KeyRepeat -int 2
# (osx) 
# (osx) defaults -currentHost delete -globalDomain AppleFontSmoothing
# (osx) defaults -currentHost write -globalDomain AppleFontSmoothing -int 2

# gh - fedora
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh

# gh xubuntu
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt update
sudo apt install gh
