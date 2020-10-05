#!/usr/bin/env bash

cd ~

if [ ! -d "~/.scripts" ]; then
    git clone git@github.com:jasonewall/bash-helpers.git ~/.scripts
fi

sudo apt-get update

# look for system ruby which we need to boot up dotfiles
if [ -z "$(which ruby)" ]; then
    sudo apt-get install -y ruby # really don't care which version just trying to get dotfiles install to run
fi

# check for git flow installation and install if missing
# assumes that the packaged verison of git flow is avh edition
$(git flow config >/dev/null 2>&1) || sudo apt-get install -y git-flow

# use keychain to manage ssh-agents in WSL
if [ -z "$(which keychain)" ]; then
    sudo apt-get install -y keychain
fi
# https://medium.com/@pscheit/use-an-ssh-agent-in-wsl-with-your-ssh-setup-in-windows-10-41756755993e

if [ -z "$(which make)" ]; then
    sudo apt-get install -y make
fi

if [ ! -d "~/.rbenv" ]; then
    git clone git@github.com:rbenv/rbenv.git ~/.rbenv

    if [ -z "$(which gcc)" ]; then
        sudo apt-get install gcc
    fi

    eval rbenv_path=~/.rbenv/bin
    export PATH="$rbenv_path:$PATH"

    ## From the rbenv setup guide:
    # Try to compile dynamic bash extensions to speed up rbenv
    # Doesn't matter if this fails - rbenv will still run
    cd ~/.rbenv && src/configure && make -C src
fi

if [ ! -d "~/.jenv" ]; then
    git clone git@github.com:jenv/jenv.git ~/.jenv
fi

CODE_DIR="$HOME/Code/github"
mkdir -p $CODE_DIR
cd $CODE_DIR

if [ ! -d "$CODE_DIR/dotfiles" ]; then
    git clone git@github.com:jasonewall/dotfiles.git
fi

cd dotfiles

git checkout my-dotfiles

cat <<"SCRIPT" | bash
source rc
dotfiles install dotfiles
dotfiles install profile
dotfiles install git
dotfiles install rbenv
dotfiles install jenv
dotfiles install ivy-cli
dotfiles install wsl-keychain
SCRIPT

# Finally print out some final setup instructions
rbenv init

cat << AHK
 * Download and install AutoHotKeys - put a shortcut to  https://github.com/jasonewall/macify-your-pc/blob/main/start.ahk in the startup folder"

    https://www.autohotkey.com/docs/FAQ.htm#Startup
AHK

cat << VSCODE
 * Once vscode is installed run the following to copy keybindings from source control to the app directory:

    dotfiles install vscode --wsl
VSCODE

cat << RBENV
 * You may need to run the following command get to rbenv enhancements compiled.

    cd ~/.rbenv && src/configure && make -C src
RBENV
