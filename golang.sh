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


GOLANG_VERSION=go1.15.2.linux-amd64

printf "\n\n  download golang\n"
wget -nc --output-document="/usr/local/$GOLANG_VERSION.tar.gz" "https://dl.google.com/go/$GOLANG_VERSION.tar.gz"
printf "\n\n  untar golang file\n"
tar -xzf "/usr/local/$GOLANG_VERSION.tar.gz" -C /usr/local/


printf "\n\n install https://github.com/myitcv/gobin \n"
export GOPATH="$HOME/go" && \
export PATH=$PATH:/usr/local/go/bin && \
export PATH=$HOME/go/bin:$PATH
go get -u github.com/myitcv/gobin

printf "\n\n gobin install some golang packages\n"
export GOPATH="$HOME/go" && \
export PATH=$PATH:/usr/local/go/bin && \
export PATH=$HOME/go/bin:$PATH
gobin -u github.com/rogpeppe/gohack
gobin -u honnef.co/go/tools/cmd/staticcheck@2020.1.6
gobin -u github.com/go-delve/delve/cmd/dlv
gobin -u golang.org/x/tools/gopls
gobin -u golang.org/x/tools/cmd/godex
gobin -u github.com/containous/yaegi/cmd/yaegi # yaegi repl. usage: rlwrap yaegi
gobin -u github.com/maruel/panicparse/v2/cmd/pp
gobin -u github.com/securego/gosec/cmd/gosec
gobin -u github.com/google/pprof
gobin -u github.com/rs/curlie
gobin -u github.com/tsenart/vegeta

printf "\n\n install gotip https://godoc.org/golang.org/dl/gotip \n"
# go get golang.org/dl/gotip
# gotip download

printf "\n\n change ownership of ~/go\n"
go version
chown -R komuw:komuw $HOME/go
chown -R komuw:komuw $HOME/.cache/


