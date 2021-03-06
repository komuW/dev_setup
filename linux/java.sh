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

# install_java(){
#     printf "\n\n install Amazon Corretto openJDK\n"
#     # java 11 is an LTS
#     sudo apt -y update
#     sudo apt -y purge default-jre default-jdk
#     wget -nc --output-document=/tmp/java_amazon_corretto_jdk_amd64.deb https://corretto.aws/downloads/latest/amazon-corretto-11-x64-linux-jdk.deb
#     sudo dpkg -i /tmp/java_amazon_corretto_jdk_amd64.deb

#     printf "\n\n install intellij idea\n"
#     snap install intellij-idea-community --classic 

#     printf "\n\n install gradle\n"
#     wget -nc --output-document=/tmp/gradle.zip https://services.gradle.org/distributions/gradle-7.1-bin.zip
#     unzip /tmp/gradle.zip -d /usr/local
# }
# install_java