#!/usr/bin/env bash
if test "$BASH" = "" || "$BASH" -uc "a=();true \"\${a[@]}\"" 2>/dev/null; then
    # Bash 4.4, Zsh
    set -euo pipefail
else
    # Bash 4.3 and older chokes on empty arrays with set -u.
    set -eo pipefail
fi
shopt -s nullglob globstar
export DEBIAN_FRONTEND=noninteractive

MY_NAME=$(whoami)

printf "\n\n update cache\n"
sudo apt-get -y update

printf "\n\n Install zsh \n"
sudo apt-get -y install zsh

printf "\n\n Install ohmyzsh \n"
rm -rf /home/$MY_NAME/.oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git /home/$MY_NAME/.oh-my-zsh

printf "\n\n Install ohmyzsh plugins \n"
git clone https://github.com/zsh-users/zsh-autosuggestions /home/$MY_NAME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions /home/$MY_NAME/.oh-my-zsh/custom/plugins/zsh-completions

printf "\n\n Add ohmyzsh config \n"
cp ../templates/zshrc.j2 /home/$MY_NAME/.zshrc

printf "\n\n change ownership of ohmyzsh dirs \n"
chown -R $MY_NAME:$MY_NAME /home/$MY_NAME/.zshrc
chown -R $MY_NAME:$MY_NAME /home/$MY_NAME/.oh-my-zsh

printf "\n\n  activate zsh shell\n"
chsh -s $(which zsh)
