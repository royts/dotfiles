# open locatin in file browser
alias browse='xdg-open'

alias disableTouchpad='synclient TouchpadOff=1'
alias enableTouchpad='synclient TouchpadOff=0'
# set a nice command prompt
# export PS1="\[\e[32;1m\]\w\[\e[20;1m\] $ \[\e[20;0m\]"

alias webServerHere='python -m SimpleHTTPServer 8000'

alias grep='grep --color'

# make ls coloured, and append characters to denote filetype ( eg trailing / on directory names)
alias ls='ls -F --color=auto'

# short for ls
alias l='ls'

# show only hidden files
alias l.='ls -d .*'

# list all files
alias la='ls -a'

# long format listing
 alias ll="ls -l"

 # list only directories
 alias lsd='ls -d */'

 # list, order by extension
 alias lx='ls -X'

# previous directory
alias p='cd -'

# short for cd ..
alias s='cd ..'

# allow omission of space in cd .. and cd -
alias cd..='cd ..'
alias cd-='cd -'
# Remove a directoryalias rd='rmdir'

# Make a directory
alias md='mkdir'

# ingnore case in tab completion
bind 'set completion-ignore-case on'

# open docs in existing gvim window
gvim () { command gvim --remote-tab-silent $@ || command gvim $@; }

alias ll="ls -l"

alias cd..="cd .."

export MARKPATH=$HOME/.marks
function jump { 
      cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
      mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
      rm -i "$MARKPATH/$1"
}
function marks {
      ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks jump unmark


#keyboard layout
function changeKeyboardLayoutToRegular(){
  echo 1 | sudo tee /sys/module/hid_apple/parameters/fnmode
  xmodmap ~/dotfiles/bash/.regularConfig.xmodmappings
}
function changeKeyboardLayoutToApple(){

  echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
  xmodmap ~/dotfiles/bash/.appleConfig.xmodmappings

}
function changeFontScaleBig (){
  gsettings set org.gnome.desktop.interface text-scaling-factor 1.2 
}
function changeFontScaleRegular(){
  gsettings set org.gnome.desktop.interface text-scaling-factor 1 
  
}
function goodMorning () {
  cd ~/dev/git/outbrain/trunk/ ;
  git stash;
  git svn rebase;
  git stash pop;
  mvn-all -T16;
  mvn test -P integration -T16;
}
function testBeforeCommit() {
  mvn test -pl $1 -Pintegration -T4C 
}

PURPLE=$(echo -en "\033[35m")
GREEN=$(echo -en "\033[32m")
RED=$(echo -en "\033[31m")
YELLOW=$(echo -e "\033[33m")
BLUE=$(echo -e "\033[1;34m")
NORMAL=$(echo -e "\033[0m")
 
mvn2() {
mvn $* | sed \
	-e "s/^\(.ERROR. .*\)$/$RED\1$NORMAL/		; #contain ERROR start 2nd char
	s/^\(Tests run: .*<<< FAILURE\!\)/$RED\1$NORMAL/	; # contain Tests run: <something> <<< FAILURE
	s/^\( \w*\\([\w\.]*\\).*: .*\)/$RED\1$NORMAL/	; # a name of method(name of class with package): error message
	s/^\(Failed tests:.*\)/$RED\1$NORMAL/		; # contain Failed tests: 
	s/^\(|.*\)/$RED\1$NORMAL/			; # line start with pipe
	s/^\(### Content of table.*\)/$RED\1$NORMAL/	; # line start ### Content of table (dbunit)
	s/^\(Caused by*.*\)/$RED\1$NORMAL/		; # line start Caused by
	s/^\(\tat .*\)/$RED\1$NORMAL/			; # line start at ... (stack trace)
	s/^\(\t*.*more.*\)/$RED\1$NORMAL/		; # line start with tab and contain something with more (stack trace)
	s/^\(##*.*\)/$RED\1$NORMAL/			; # line start more than 1 #
	s/^\(Running.*\)/$BLUE\1$NORMAL/		; # Line start with Running (surefire)
	s/^\(Tests run: .*[^FAILURE].*\)/${YELLOW}\1${NORMAL}/ ;  # test not failed
	s/^\(.INFO. BUILD FAILURE.*\)$/$RED\1$NORMAL/	; # BUILD FAILURE
	s/^\(.INFO. ----.*\)$/$PURPLE\1$NORMAL/		; # INFO of module block
	s/^\(.INFO. Building.*SNAPSHOT\)$/$PURPLE\1$NORMAL/; # INFO of module block (with version)
	s/^\(.INFO. --- .* ---.*\)$/$PURPLE\1$NORMAL/	; # info of plugin
	s/^\(.INFO. .*\)$/$GREEN\1$NORMAL/		; # other info
	s/^\(.WARNING. .*\)$/$BLUE\1$NORMAL/		; # warning
	s/^\(\w*\.\w*\) \(r [0-9]* w 0 e 0 .* seconds.*\)$/$BLUE\1$NORMAL $YELLOW\2$NORMAL/; 
	s/^\(\w*\.\w*\) \(r [0-9]* w [1-9] e 0 .* seconds.*\)$/$RED\1 \2$NORMAL/; 
	s/^\(\w*\.\w*\) \(r [0-9]* w [1-9] e [1-9] .* seconds.*\)$/$RED\1 \2$NORMAL/; 
	s/^\(\w*\.\w*\) \(r [0-9]* w 0 e [1-9] .* seconds.*\)$/$RED\1 \2$NORMAL/; 
						# Fitnesse execute test;
	s/^\([^\[].*\)/${YELLOW}\1${NORMAL}/ ; 		# line doesn't start with [ 
	" 
}

###################
### dev machine ###
#################
alias outbrainTrunk='/home/rtsabari/dev/git/outbrain/trunk'
export PYTHONPATH=/home/$USER/bin/hive/build/dist/lib/py/

export JAVA_HOME=/usr/lib/jvm/java-7-oracle
export PATH=$PATH:$JAVA_HOME/bin:/home/$USER/scripts/

# set a nice command prompt
export PS1="\[\e[32;1m\]\w\[\e[30;1m\] $ \[\e[30;0m\]"
# allow colors for ls
export CLICOLOR=1

# Setup tomcat debug mode for jpda
export JPDA_ADDRESS=8000
export JPDA_TRANSPORT=dt_socket

export JAVA_OPTS='-Xmx2048m -Xms512m -XX:MaxPermSize=512m'
export CATALINA_OPTS='-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9999 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.outbrain.environment=dev -Dlog4j.configuration=file:///home/$USER/dev/log4j.xml -Djava.awt.headless=true'
export CATALINA_PID=~/dev/temp/catalina.pid
export TOMCAT_HOME=~/bin/tomcat/

# environment for unit tests
export com_outbrain_environment=junit

alias mvn-eclipse='mvn2 eclipse:eclipse -Dwtpversion=2.0 -DdownloadSources=true  -DdownloadJavadocs=true'
alias mvn-install='mvn2 install -DskipTests=true -DwarProject.packaging=jar'
alias mvn-clean-install="mvn2 clean install -DskipTests=true -DwarProject.packaging=jar"
alias mvn-clean-install-eclipse='mvn2 clean install  -DskipTests=true  eclipse:eclipse -DwarProject.packaging=jar -Dwtpversion=2.0 -DdownloadSources=true -DdownloadJavadocs=true' 
alias mvn-clean-compile-all='mvn2 clean test-compile'
alias mvn-all="mvn-clean-install"
alias mvn-test-fast="mvn2 test"
alias ps-java='ps aux | grep java'

function mvn-make {
  mvn reactor:make -Dmake.artifacts=$1 -Dmake.goals=install,-DskipTests -DwarProject.packaging=jar
}

function mvn-make-dependents {
  mvn reactor:make-dependents -Dmake.artifacts=$1 -Dmake.goals=install,-DskipTests -DwarProject.packaging=jar
}

function mvn-make-all-related {
  mvn reactor:make reactor:make-dependents -Dmake.artifacts=$1 -Dmake.goals=install,-DskipTests -DwarProject.packaging=jar
}

# maven setup
export M2_HOME=/home/$USER/bin/maven
export M2=$M2_HOME/bin
export M2=$M2_HOME/bin
export PATH=$M2:$PATH
export M2_REPO=~/.m2/
export MAVEN_OPTS='-Xmx2024m -Xms256m -XX:MaxPermSize=384m'

# svn setup
alias sd='svn diff --diff-cmd=/home/$USER/bin/svn-diff-meld'

# hadoop familiy setup
export HADOOP_HOME=/home/$USER/bin/hadoop-0.20.2
export HIVE_HOME=/home/$USER/bin/hive/build/dist
export PATH=$PATH:$HADOOP_HOME/bin:$HIVE_HOME/bin

# ant setup
export ANT_LIB=/usr/share/ant/lib

# colored svn

# download colored-svn from the attachment section below and put it under /home/$USER/bin/

alias svn=/home/$USER/bin/colored-svn

#function appendSoftwareListCommand {
#  if[$# > 1]
#  then
#    echo "### $0" >> ~/dotfiles/software/installSoftware.sh
#    echo "$1" >> ~/dotfiles/software/installSoftware.sh
#  else
#     echo "### $0" >> ~/dotfiles/software/installSoftware.sh
#  fi
#
#}
######## git ######
function gitIsDirty {
  if [$(git diff --shortstat 2> /dev/null | tail -n1) != "" ] 
    then
      return 1
  else
    return 0
  fi
}
