#aliases
alias g='git'
alias gk='gitk --all &'
alias gp='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gu='git rebase origin/$(git rev-parse --abbrev-ref HEAD)'

## Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#bring in vagrant
#brew install vagrant
export PATH="/Applications/Vagrant/bin:$PATH"

#brew install go
export GOPATH=~/dev/gocode
export PATH="$PATH:$GOPATH/bin"