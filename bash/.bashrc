
# ingnore case in tab completion
bind 'set completion-ignore-case on'

# set a nice command prompt
export PS1="\[\e[0;32m\]\w\[\e[0;32m\] $ \[\e[30;0m\]"
# allow colors for ls
export CLICOLOR=1

# preserve command history between sessions
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin/


# hh
export HH_CONFIG=hicolor         # get more colors
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=20000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
# if this is interactive shell, then bind hh to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.*  ]]; then bind '"\C-r": "\C-a hh \C-j"'; fi
