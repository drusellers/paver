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

# common scripts (Adds ~/bin to the path)
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
PATH=$(pyenv root)/shims:$PATH

# Rust
source $HOME/.cargo/env

# node / nvm (⚠️ this can be slow)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
# [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# iterm2 support
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# set up fancy starship 🚀 prompt
eval "$(starship init zsh)"

# better switching
# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

# fancy history
# https://atuin.sh/
eval "$(atuin init zsh)"

# GitHub Package Repository
export CR_PAT="..."
export FONTAWESOME_NPM_AUTH_TOKEN="..."

# Message Aid Stuff
export PATH="/Users/drusellers/dev/acm/ops-bivy/bin:$PATH"
export PATH="/opt/handtools/current/bin:$PATH"
alias ht="handtools"
alias htd="dotnet run --project /Users/drusellers/dev/ep/handtools/src/Handtools"
