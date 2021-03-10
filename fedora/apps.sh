sudo dnf install git-delta

# python

curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
dnf install make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel
curl https://pyenv.run | bash

# minikube

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
minikube config set driver docker
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

npm install -g tldr
sudo dnf install fzf


sudo vim /usr/share/applications/intellij.desktop
#[Desktop Entry]
#Version=13.0
#Type=Application
#Terminal=false
#Icon[en_US]=/home/rob/.intellij-13/bin/idea.png
#Name[en_US]=IntelliJ
#Exec=/home/rob/.intellij-13/bin/idea.sh
#Name=IntelliJ
#Icon=/home/rob/.intellij-13/bin/idea.png
sudo chown root:root /usr/share/applications/intellij.desktop
sudo chmod 644 /usr/share/applications/intellij.desktop

