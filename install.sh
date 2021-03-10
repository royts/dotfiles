#! /bin/bash

# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/zsh/royts.zsh-theme $HOME/.oh-my-zsh/themes/royts.zsh-theme
source $HOME/.zshrc
ln -s $HOME/dotfiles/git/gitconfig.symlink $HOME/gitconfig.symlink
ln -s $HOME/dotfiles/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/vim/.vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/bin $HOME/bin
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
brew install pyenv
pyenv install 2.7.17
pyenv global 2.7.17
#ln -s /usr/local/bin/pip $HOME/opt/pip
#ln -s /usr/local/bin/python2 $HOME/opt/python
#ln -s /usr/local/bin/python3 $HOME/opt/python3
ln -s $HOME/dotfiles/vscode/keybindings.json /Library/Application\ Support/Code/User/keybindings.json
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
pip install tabview

# npm global in PATH
mkdir $HOME/.npm-global
npm config set prefix `$HOME/.npm-global`

# electron apps
mkdir $HOME/.eapps
npm install -g nativefier
nativefier https://mail.google.com/mail --user-agent 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:70.0) Gecko/20100101 Firefox/70.0' --name "Gmail a300600"  --internal-urls ".*accounts.google.com.*" $HOME/.eapps
nativefier https://mail.google.com/mail --user-agent 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:70.0) Gecko/20100101 Firefox/70.0' --name "Gmail Forter"  --internal-urls ".*accounts.google.com|mail.google.com.*" $HOME/.eapps
nativefier https://calendar.google.com/calendar/r --user-agent 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:70.0) Gecko/20100101 Firefox/70.0' --name "Google Calendar"  --internal-urls ".*accounts.google.com.*" $HOME/.eapps
nativefier  --name "Whatsapp" https://web.whatsapp.com/ $HOME/.eapps
nativefier  --name "Asana" https://app.asana.com/ $HOME/.eapps
nativefier --name "Zendesk" https://forter.zendesk.com/ --internal-urls "https://forter.okta.com/app/zendesk/.*" $HOME/Applications brew install tldr


# cursor speed
defaults write NSGlobalDomain KeyRepeat -int 2

defaults -currentHost delete -globalDomain AppleFontSmoothing
defaults -currentHost write -globalDomain AppleFontSmoothing -int 2
