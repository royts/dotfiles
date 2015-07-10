platform="unknown"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    platform="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    platform="mac"
fi

files=(
$HOME"/.bashrc"
$HOME"/.bash_ob"
$HOME"/.bash_function"
$HOME"/.bash_alias"
$HOME"/.bash_bindings"
$HOME"/.bash_maven"
$HOME"/.local/bin/bashmarks.sh"
)


for i in "${files[@]}"
do
    :
    if [ -f "$i" ]; then
        source $i
    fi
done
