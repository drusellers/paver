#!/bin/sh

########
# a curl-bash script for setting up my dev machines
# curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | sh
########

(
    # get to the correct directory
    cd ~
    
    # Copy down the paver content using system git
    git clone git@github.com:drusellers/paver.git .paver

    sh ~/.paver/install.sh
)



