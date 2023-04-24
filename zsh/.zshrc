export FZF_BASE=/opt/homebrew/opt/fzf

export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="royts"
#. $HOME/.oh-my-zsh/plugins/z/z.sh
export PATH="$HOME/.local/bin:$PATH" # pip install bin
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/dev/first/nirops/scripts:$PATH"
plugins=(
  git
  z
  fzf
  vi-mode
  zsh-autosuggestions
  zsh-syntax-highlighting # got to be the last one!
)
source $ZSH/oh-my-zsh.sh


##############
# git

git-remove-merged-branches(){
  git fetch --prune && git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -D
}

git-fetch-and-merge(){
  git fetch && git merge origin/$1
}

gciamp () {
  git ci -am "$1" && git push
}

gcob () { # git checkout back
  git checkout @{-$1}
}
export BARNCH_NAME_PREFIX='royts-'
export TASK_URL_PREFIX='https://dev.azure.com/firstdag/Pikaia/_workitems/edit/'

# Creates a branch and push it to origin.
#   usage: gitbr 'DESCRIPTION'
gitbr () {   
  title=$1
  clean_title=${title//(\[|\]|\/|,)/-}
  trimmed=`expr "$clean_title" : "^\ *\(.*[^ ]\)\ *$"`
  branch_name="$BARNCH_NAME_PREFIX${trimmed// /-}"
  git checkout -b $branch_name
  git push -u origin $branch_name
}

# GITHUB ###############
# Creates a PR on Github and open it on the browser. Requires gh cli
# use: ghbr 'PR TITLE' TASK_NUMBER(optional)
ghpr () { 
  pr_body=' '
  task_number=$2
  if [[ -n "${task_number}" ]]
      then
          pr_body="task: $TASK_URL_PREFIX/$2"
  fi
  gh pr create -d -t $1 -b $pr_body && gh pr view --web
}
alias ghopr='gh pr view -w'
#
# Creates a branch and a PR on Github. Requires gh cli
# use: ghpr 'TITLE' TASK_NUMBER(optional)
ghbpr () {
   title=$1
   task_number=$2
   gitbr $title
   git add . 
   git ci -m $title
   git push
   ghpr $title $task_number
}

# GITLAB ###############

# Creates a PR on Gitlab and open it on the browser. Requires the gitlab cli
# use: glbr 'PR TITLE' TASK_NUMBER(optional)
glpr () { 
  pr_body=' '
  task_number=$2
  if [[ -n "${task_number}" ]]
      then
          pr_body="task: $TASK_URL_PREFIX/$2"
  fi
  glab mr create --draft -y -t $1 -d $pr_body && glab mr view --web
}
alias glopr="glab mr view -w"

# Creates a branch and a PR on Gitlab
# use: ghpr 'TITLE' TASK_NUMBER(optional)
glbpr () {
   title=$1
   task_number=$2
   gitbr $title
   git add . 
   git ci -m $title
   git push
   glpr $title $task_number
}

gitpr-develop-to-master() { # requires gh cli
  gh pr create -t $1 -H 'develop' -B 'main' -b '' && gh pr view --web
}

# ask bors to merge my PR by commenting
bors-merge() {
  gh pr comment -b 'bors merge'
}

gitpr-checks() {
  gh pr checks
}

alias rebase-main='git pull --rebase origin master'
alias rebase-develop='git pull --rebase origin develop'

###############
# aws

aws-ls-region () {
  filter="Name=tag:Name,Values=*${1}*"
  aws ec2 --region $2 describe-instances --filters $filter --query 'Reservations[].Instances[].[[Tags[?Key==`Name`].Value, PublicIpAddress, PrivateIpAddress, PublicDnsName][]]' --output table
}
aws-ls () {
  filter="Name=tag:Name,Values=*${1}*"
  aws ec2 describe-instances --filters $filter --query 'Reservations[].Instances[].[[Tags[?Key==`Name`].Value, PublicIpAddress, PrivateIpAddress, PublicDnsName][]]' --output table
}
aws-ssh () {
  filter="Name=tag:Name,Values=*${1}*"
  query="Reservations[*].Instances[*].PublicIpAddress"
  public_ip=$(aws ec2 describe-instances --filters $filter --query $query --output text)
  public_ip=${public_ip/$'\r'/}
  ssh ubuntu@$public_ip
}

s3-get () {
  output=`aws s3 cp s3://$1 $HOME/test`
  file_path=$(echo $output|awk '{print $NF}')
  echo '==================>'$file_path
  vim $file_path
}

aws-sqs-list(){
  aws sqs list-queues  | grep $1
}

aws-sqs-messages-count (){
  aws sqs get-queue-attributes --attribute-names ApproximateNumberOfMessages --queue-url $1
}

aws-sqs-purge(){
  aws sqs purge-queue --queue-url $1
}

aws-elb-list(){
  aws elb describe-load-balancers --query "LoadBalancerDescriptions[*].LoadBalancerName" | grep $1
}

aws-elb-instances-list(){
  aws elb describe-load-balancers --load-balancer-names $1 --query "LoadBalancerDescriptions[*].Instances"
}

aws-ec2-instance-list(){
 aws ec2 describe-instance-information --filters "Key=InstanceIds,Values=$1" --query "InstanceInformationList[*].ComputerName"
}

###################
# apps

kill_by_name () {
 ps -ax | grep $1 | awk '{print $1}' | xargs kill -9
}

csv () {
    tabview $1
}

alias webServerHere='python -m http.server 8000'
alias webServerHere-python-2='python -m SimpleHTTPServer 8000'


# ag
alias ag_js='ag -G "/.js$" $1'
alias ag_ext='ag -G "/.$1" $2'

alias i='ipython'

# vim
alias vim-clean-pyc='find . -name "*.pyc" -exec rm {} \;'
#set -o vi
export EDITOR=vim
#bindkey -v
#bindkey '^R' history-incremental-search-backward

 ## Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

# python
#
alias pyp="pip install -i https://pypi.python.org/simple/"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/home/roy/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# intellij
alias ij="/opt/idea-IU-203.7148.57/bin/idea.sh"

docker-kill-running-containers () {
  docker kill $(docker ps -q)
}
docker-remove-all-running-containers () {
  docker rm $(docker ps -a -q)
}
docker-remove-all-images () {
  docker rmi $(docker images -q)
}

# docker
alias docker-deamon-start='sudo systemctl start docker'


alias npm-install-no-husky='HUSKY_SKIP_INSTALL=1 npm install'

# aws
export AWS_USER="roy@firstdag.com"

export HUSKY_SKIP_HOOKS=1
export HUSKY=0

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# Roy: NVM load is very slow. That is why we do it in a custom way:
# export PATH=~/.nvm/versions/node/v18.13.0/bin:$PATH
# # Load NVM
# export NVM_DIR=~/.nvm
# [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" --no-use


export PATH="$HOME/.tfenv/bin:$PATH"
alias resolution-reset='xrandr --output eDP-1-1 --mode 1920x1080'
eval "$(pyenv init -)"
export PATH="/opt/homebrew/opt/node@14/bin:$PATH"

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="/Users/royts/.deta/bin:$PATH"
decode () {
  echo "$1" | base64 -d ; echo
}
alias vim ='nvim'
