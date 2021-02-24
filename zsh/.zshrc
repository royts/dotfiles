export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="royts"
#. $HOME/.oh-my-zsh/plugins/z/z.sh
export PATH="$HOME/.local/bin:$PATH" # pip install bin
plugins=(
  git
  z
  vi-mode
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

alias rebase-master='git fetch && git merge origin/master'

###############
# aws

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

alias webServerHere='python -m SimpleHTTPServer 8000'

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

alias port-listeners-list='lsof -iTCP -sTCP:LISTEN -P -n'

alias pyp="pip install -i https://pypi.python.org/simple/"
