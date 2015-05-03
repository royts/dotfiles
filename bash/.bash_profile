platform="unknown"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    platform="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    platform="mac"
fi

files=(
"/Users/rtsabari/.bashrc"
"/Users/rtsabari/.bash_ob"
"/Users/rtsabari/.bash_function"
"/Users/rtsabari/.bash_alias"
"/Users/rtsabari/.bash_bindings"
"/Users/rtsabari/.bash_maven"
"/Users/rtsabari/.local/bin/bashmarks.sh"
)


for i in "${files[@]}"
do
    :
    if [ -f "$i" ]; then
        source $i
    fi
done
