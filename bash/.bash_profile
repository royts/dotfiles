platform="unknown"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    platform="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    platform="mac"
fi

files=(
$HOME"/.bashrc"
$HOME"/.bash_function"
$HOME"/.bash_alias"
$HOME"/.bash_bindings"
$HOME"/.local/bin/bashmarks.sh"
)


for i in "${files[@]}"
do
    :
    if [ -f "$i" ]; then
        source $i
    fi
done
# added by Miniconda3 4.6.14 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/miniconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/miniconda3/etc/profile.d/conda.sh" ]; then
# . "/miniconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/roy-work/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/roy-work/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/roy-work/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/roy-work/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

