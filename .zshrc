#aliases
alias g='git'
alias gk="gitup map"
alias gc="gitup commit"
alias gp='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gu='git rebase origin/$(git rev-parse --abbrev-ref HEAD)'
alias e=etcdctl
alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"


## Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#bring in vagrant
#brew install vagrant
export PATH="/Applications/Vagrant/bin:$PATH"

#brew install go
export GOPATH=~/dev/gocode
export PATH="$PATH:$GOPATH/bin"


eval "$(rbenv init -)"

# found via brew --prefix openssl
OPEN_SSL_PATH="/usr/local/opt/openssl"
export LDFLAGS="-L$OPEN_SSL_PATH/lib"
export CPPFLAGS="-I$OPEN_SSL_PATH/include"
export OPENSSL_INCLUDE_DIR="$OPEN_SSL_PATH/include"
export OPENSSL_LIB_DIR="$OPEN_SSL_PATH/lib"
export DEP_OPENSSL_INCLUDE="$OPEN_SSL_PATH/include"

# Java
export JAVA_HOME=$(/usr/libexec/java_home)

# OMC Stuff
export PATH="/Users/drusellers/dev/omc/shipit/bin:$PATH"
export PATH="/Users/drusellers/dev/omc/depot/depot-client/bin:$PATH"

# ACM Stuff
export PATH="/Users/drusellers/dev/acm/ops-bivy/bin:$PATH"

# Rust
export PATH="$PATH:/Users/drusellers/.cargo/bin"

# home brew
export PATH="/usr/local/sbin:$PATH"

# iterm2 + zsh
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# node / nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

