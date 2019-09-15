#!/bin/sh

########
# setup a new laptop
########

# import common functions
# shellcheck disable=SC1091
. ./libexec/helpers


# shellcheck disable=SC2154
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

# bail on the first error
set -e

# setup our home bin dir
if [ ! -d "$HOME/bin/" ]; then
  mkdir "$HOME/bin"
fi

if [ ! -f "$HOME/.zshrc" ]; then
  touch "$HOME/.zshrc"
fi

# add the user bin to path
# shellcheck disable=SC2016
append_to_zshrc 'export PATH="$HOME/bin:$PATH"'

# This is where homebrew installs to
HOMEBREW_PREFIX="/usr/local"

# LOGNAME is defined by the shell
# groups: `admin` - default for mac
if [ -d "$HOMEBREW_PREFIX" ]; then
  if ! [ -r "$HOMEBREW_PREFIX" ]; then
    sudo chown -R "$LOGNAME:admin" /usr/local
  fi
else
  sudo mkdir "$HOMEBREW_PREFIX"
  sudo chflags norestricted "$HOMEBREW_PREFIX"
  sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
fi

##
# Switch shell to ZSH
##
update_shell() {
  local shell_path;
  shell_path="$(which zsh)"

  fancy_echo "Changing your shell to zsh ..."
  if ! grep "$shell_path" /etc/shells > /dev/null 2>&1 ; then
    fancy_echo "Adding '$shell_path' to /etc/shells"
    sudo sh -c "echo $shell_path >> /etc/shells"
  fi
  chsh -s "$shell_path"
}

case "$SHELL" in
  */zsh)
    if [ "$(which zsh)" != '/bin/zsh' ] ; then
      update_shell
    fi
    ;;
  *)
    update_shell
    ;;
esac

##
# Install Homebrew
##

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    curl -fsS \
      'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

    append_to_zshrc '# recommended by brew doctor'

    # shellcheck disable=SC2016
    append_to_zshrc 'export PATH="/usr/local/bin:$PATH"' 1

    export PATH="/usr/local/bin:$PATH"
fi

if brew list | grep -Fq brew-cask; then
  # cask is now built into homebrew
  fancy_echo "Uninstalling old Homebrew-Cask ..."
  brew uninstall --force brew-cask
fi

fancy_echo "Updating Homebrew formulae ..."
brew update

fancy_echo "Installing from Homebrew ..."
brew bundle --file=- <<EOF
tap "homebrew/services"

#Mac App Store
brew "mas"

# Unix
brew "git"
brew "openssl"
brew "the_silver_searcher"
brew "vim"
brew "zsh"
brew "pdsh"
brew "vaulted"

# Heroku
brew "heroku-toolbelt"

# Programming languages
brew "libyaml" # should come after openssl
brew "node"
brew "rbenv"
brew "ruby-build"
brew "yarn"
EOF

fancy_echo "Installing from Homebrew Casks ..."
brew cask install visual-studio-code
brew cask install virtualbox
brew cask install vagrant
brew cask install beyond-compare
brew cask install iterm2
brew cask install slate
brew cask install gitup
brew cask install karabiner-elements
#atom?
#chrome?
#rider / intellij / JetBrains management tool


fancy_echo "Installing From AppStore ..."
mas install 406056744  # evernote
mas install 896450579  # textual
mas install 1278508951 # trello
mas install 711830901  # omnigraffle
mas install 425424353  # unarchiver
mas install 407963104  # pixelmator
mas install 403388562  # transmit
mas install 497799835  # xcode
mas install 803453959  # slack
mas install 411643860  # daisydisk
mas install 904280696  # things 3
mas install 1333542190 # 1Password 7
mas install 975937182  # Fantastical 2

fancy_echo "Configuring Ruby ..."
find_latest_ruby() {
  rbenv install -l | grep -v - | tail -1 | sed -e 's/^ *//'
}

ruby_version="$(find_latest_ruby)"

# set up ruby in your zshrc
# shellcheck disable=SC2016
append_to_zshrc 'eval "$(rbenv init - --no-rehash)"' 1
eval "$(rbenv init -)"

# install the most recent version of ruby
if ! rbenv versions | grep -Fq "$ruby_version"; then
  RUBY_CONFIGURE_OPTS=--with-openssl-dir=/usr/local/opt/openssl rbenv install -s "$ruby_version"
fi

rbenv global "$ruby_version"
rbenv shell "$ruby_version"
gem update --system
gem_install_or_update 'bundler'
number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))

#Install Rustup
curl https://sh.rustup.rs -sSf | sh

# Configure Slate
cp slate.cfg ~/.slate

# configure zsh
sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
