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

printf "\n\n  download zig from master branch(change when zig gets to ver1)\n"
wget -nc --directory-prefix=/usr/local https://ziglang.org/builds/zig-linux-x86_64-master.tar.xz
printf "\n\n  untar zig file\n"
mkdir -p /usr/local/zig && tar -xf "/usr/local/zig-linux-x86_64-master.tar.xz" -C /usr/local/zig --strip-components 1

# todo: add zig to $PATH
printf "\n\n use zig as: \n"
printf "\t /usr/local/zig/zig build-exe hel.zig \n"

# to install on Osx: brew install zig --HEAD