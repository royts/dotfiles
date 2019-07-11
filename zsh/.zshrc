# Path to your oh-my-zsh installation.
export ZSH=/Users/roy-work/.oh-my-zsh
export ZSH_THEME="royts"
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zshmarks)

# User configuration

#export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Applications/Postgres.app/Contents/Versions/9.4/bin"
#export PATH="/usr/local/bin:$PATH" #for custom python version
#export PYTHONPATH="$HOME/opt/python"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export NVM_DIR="/Users/roy-work/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export HOMEBREW_GITHUB_API_TOKEN=f8a8c35643cdd58a9bffcc9441740b2f2c7f39e7

git-remove-merged-branches(){
  git fetch --prune && git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -D
}
#alias python=/usr/local/Cellar/python/2.7.11/bin/python
alias python-create-virtual-env='virtualenv venv'
alias python-use-virtual-env='source venv/bin/activate'
alias python-leave-virtaual-env='deactivate'
#git
git-fetch-and-merge(){
  git fetch && git merge origin/$1
}

# ssh
ssh-prod () {
  ssh ubuntu@$1 -i ~/.ssh/prod1.pem
}
ssh-own-user () {
  ssh roy.tsabari@$1 -i ~/.ssh/id_rsa
}
ssh-dev () {
  ssh ubuntu@$1 -i ~/.ssh/u2_ssh.pem
}
ssh-docker () {
  ssh roy.tsabari@$1 -i ~/.ssh/id_rsa
}

gciamp () {
  git ci -am "$1" && git push
}

aws-ls-region () {
  filter="Name=tag:Name,Values=*${1}*"
  aws ec2 --region $2 describe-instances --filters $filter --query 'Reservations[].Instances[].[[Tags[?Key==`Name`].Value, PublicIpAddress, PrivateIpAddress, PublicDnsName][]]' --output table
}
aws-ls () {
  aws-ls-region $1 'us-east-1'
}
aws-ls-west (){
  aws-ls-region $1 'us-west-2'
}

alias gcomasterp='git co master && git pull'

time-stamp-millis-to-date () {
  arg=$1
  trimmed=${arg[1,-4]}
  echo ${date -r $trimmed}
}

s3-get () {
  output=`aws s3 cp s3://$1 /Users/roy-work/test`
  file_path=$(echo $output|awk '{print $NF}')
  vi $file_path
}
sqs-find-by-name (){
  aws sqs list-queues  | grep $1
}
sqs-messages-count-by-quue-url (){
  aws sqs get-queue-attributes --attribute-names ApproximateNumberOfMessages --queue-url $1
}
sqs-purge-queue(){
  aws sqs purge-queue --queue-url $1
}
real_path(){
  echo "$(cd "$(dirname "$1")"; pwd -P)/$(basename "$1")"
}

kill_by_name () {
 ps -ax | grep $1 | awk '{print $1}' | xargs kill -9
}
alias vim-spf13-update-plugins='vim +BundleInstall! +BundleClean +q'

# https://github.com/rupa/z
. $HOME/dev/z/z.sh
export PATH="$HOME/opt:$PATH"
export PATH="$HOME/opt/forter-dev-tools:$PATH" # Forter dev-tools

alias webServerHere='python -m SimpleHTTPServer 8000'
# ln -s /usr/local/bin/ipython ipython
# ln -s /usr/local/bin/pip pip
# ln -s /usr/local/bin/python2 python

# ag
alias ag_js='ag -G "/.js$" $1'
alias ag_ext='ag -G "/.$1" $2'
export HOMEBREW_GITHUB_API_TOKEN=ebfe3889b6a14d5202d5b12abe82abd5f5c629ba
alias rebase-master='git fetch && git merge origin/master'

alias fvim='vim $(fzf)'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/roy-work/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/roy-work/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/roy-work/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/roy-work/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

alias gff='git feature from'
alias docke-pps="docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Image}}' "
alias i='ipython'

#compdef gozer
_gozer() {
  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _GOZER_COMPLETE=complete-zsh  gozer)
}
if [[ "$(basename ${(%):-%x})" != "_gozer" ]]; then
  autoload -U compinit && compinit
  compdef _gozer gozer
fi
# alias vim=nvim
alias vim-clean-pyc='find . -name "*.pyc" -exec rm {} \;'
alias notify= '| tee terminal-notifier'
