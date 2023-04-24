# install zsh: brew install zsh (new osx comes with it)
# install oh-my-zsh sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
USER_HOME=~/
SCRIPT_LOCATION="$(cd "$(dirname "$0")" && pwd)"

ln -s $SCRIPT_LOCATION/royts.zsh-theme $USER_HOME/.oh-my-zsh/themes/royts.zsh-theme
ln -s $SCRIPT_LOCATION/.zshrc $USER_HOME/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

