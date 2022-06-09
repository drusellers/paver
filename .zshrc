# drusellers settings

# ZSH Auto Completion
autoload -U compinit && compinit
zmodload -i zsh/complist

# aliases
alias g='git'
alias gk="gitup map"
alias gc="gitup commit"
alias gp='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gu='git rebase origin/$(git rev-parse --abbrev-ref HEAD)'
alias e=etcdctl
alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
alias be='bundler exec'

# common scripts
export PATH="$HOME/bin:$PATH"

# found via brew --prefix openssl
OPEN_SSL_PATH="/usr/local/opt/openssl"
export LDFLAGS="-L$OPEN_SSL_PATH/lib"
export CPPFLAGS="-I$OPEN_SSL_PATH/include"
export OPENSSL_INCLUDE_DIR="$OPEN_SSL_PATH/include"
export OPENSSL_LIB_DIR="$OPEN_SSL_PATH/lib"
export DEP_OPENSSL_INCLUDE="$OPEN_SSL_PATH/include"

export LDFLAGS="-L/usr/local/opt/libxml2/lib"
export CPPFLAGS="-I/usr/local/opt/libxml2/include"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Ruby Set Up
eval "$(rbenv init -)"

# python setup
export PATH="$PATH:/Users/drusellers/Library/Python/3.7/bin"

# Rust
source $HOME/.cargo/env



# node / nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"


# ACM Stuff
export PATH="/Users/drusellers/dev/acm/ops-bivy/bin:$PATH"

# iterm2 support
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# set up my fancy prompt
eval "$(starship init zsh)"

# better switching
eval "$(zoxide init zsh)"

# fancy history
eval "$(atuin init zsh)"

# OMC GitHub Package Repository
export GPR_AUTH_TOKEN="..."
export FONTAWESOME_AUTH="..."
