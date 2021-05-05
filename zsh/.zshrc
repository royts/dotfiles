export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="royts"
#. $HOME/.oh-my-zsh/plugins/z/z.sh
export PATH="$HOME/.local/bin:$PATH" # pip install bin
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/dev/first/nirops/scripts:$PATH"
plugins=(
  git
  z
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

export BARNCH_NAME_PREFIX='royts-'
export TASK_URL_PREFIX='https://dev.azure.com/firstdag/Pikaia/_workitems/edit/'

# Creates a branch and push it to origin. Requires gh cli
# use: gitbr 'DESCRIPTION'
gitbr () {   
  title=$1
  trimmed=`expr "$title" : "^\ *\(.*[^ ]\)\ *$"`
  branch_name="$BARNCH_NAME_PREFIX${trimmed// /-}"
  git checkout -b $branch_name
  git push -u origin $branch_name

}

# Creates a PR and open it on the browser. Requires gh cli
# use: gitpr 'PR TITLE' TASK_NUMBER(optional)
gitpr () { 
  pr_body=' '
  task_number=$2
  if [[ -n "${task_number}" ]]
      then
          pr_body="task: $TASK_URL_PREFIX/$2"
  fi
  gh pr create -t $1 -b $pr_body && gh pr view --web
}

# Creates a branch and a PR. Requires gh cli
# use: gitbpr 'TITLE' TASK_NUMBER(optional)
gitbpr () {
   title=$1
   task_number=$2
   gitbr $title
   git add . 
   git ci -m $title
   gitpr $title $task_number
}

gitpr-develop-to-master() { # requires gh cli
  gh pr create -t $1 -H 'develop' -B 'master' -b '' && gh pr view --web
}

alias rebase-master='git fetch && git merge origin/master'
alias rebase-develop='git fetch && git merge origin/develop'

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

# python
#
alias pyp="pip install -i https://pypi.python.org/simple/"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/home/roy/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# intellij
alias ij="/opt/idea-IU-203.7148.57/bin/idea.sh"

# docker
alias docker-deamon-start='sudo systemctl start docker'

# tilix terminal
#if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
#fi
alias npm-install-no-husky='HUSKY_SKIP_INSTALL=1 npm install'
