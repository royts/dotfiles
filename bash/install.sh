#! /bin/bash

USER_HOME=~/
SCRIPT_LOCATION="$(cd "$(dirname "$0")" && pwd)"

ln -s $SCRIPT_LOCATION/.bash_profile $USER_HOME.bash_profile
ln -s $SCRIPT_LOCATION/.bashrc $USER_HOME.bashrc
ln -s $SCRIPT_LOCATION/.bash_function $USER_HOME.bash_function
ln -s $SCRIPT_LOCATION/.bash_alias $USER_HOME.bash_alias
ln -s $SCRIPT_LOCATION/.bash_bindings $USER_HOME.bash_bindings
