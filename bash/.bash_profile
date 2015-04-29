platform="unknown"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  platform="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  platform="mac"
fi

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.bash_ob ]; then
  source ~/.bash_ob
fi

if [ -f ~/.bash_function ]; then
  source ~/.bash_function
fi

if [ -f ~/.bash_alias ]; then
  source ~/.bash_alias
fi

if [ -f ~/.bash_marks ]; then
  source ~/.bash_marks
fi

if [ -f ~/.bash_bindings ]; then
  source ~/.bash_marks
fi


