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
alias tf='terraform'
alias dc='docker compose'

# common scripts (Adds ~/bin to the path)
export PATH="$HOME/bin:$PATH"

# found via brew --prefix openssl
OPEN_SSL_PATH="/opt/homebrew/opt/openssl@3"
export LDFLAGS="-L$OPEN_SSL_PATH/lib"
export CPPFLAGS="-I$OPEN_SSL_PATH/include"
export OPENSSL_INCLUDE_DIR="$OPEN_SSL_PATH/include"
export OPENSSL_LIB_DIR="$OPEN_SSL_PATH/lib"
export DEP_OPENSSL_INCLUDE="$OPEN_SSL_PATH/include"

export LDFLAGS="-L/usr/local/opt/libxml2/lib"
export CPPFLAGS="-I/usr/local/opt/libxml2/include"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# set the editor
export EDITOR="code --wait"

# dotnet
# dotnet-install.sh - wget https://dot.net/v1/dotnet-install.sh
PATH="/Users/drusellers/.dotnet:$PATH"
PATH="$PATH:/Users/drusellers/.dotnet/tools"
export DOTNET_ROOT="$HOME/.dotnet"

# Ruby Set Up
eval "$(rbenv init - zsh)"

# python setup
PATH=$(pyenv root)/shims:$PATH

# Rust
source $HOME/.cargo/env

# node / nvm (⚠️ this can be slow)
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# JVM support
# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"
# Java 17 -> brew install openjdk@17
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

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

# Environment Variables for Dev Work
export FONTAWESOME_NPM_AUTH_TOKEN="..."

# Just needs read:package
export CR_PAT="..."
export GPR_AUTH_TOKEN="${CR_PAT}"
export NUGET_KEY="..."


