
# ingnore case in tab completion
bind 'set completion-ignore-case on'

# set a nice command prompt
export PS1="\[\e[32;1m\]\w\[\e[30;1m\] $ \[\e[30;0m\]"
# allow colors for ls
export CLICOLOR=1

# preserve command history between sessions
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin/
