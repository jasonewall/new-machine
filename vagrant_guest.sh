#!/usr/bin/env bash

set -e

cd ~

if [ ! -d ~/.scripts ]; then
    git clone git@github.com:jasonewall/bash-helpers.git ~/.scripts
fi

sudo apt-get update

# we need this for selecta
if [ -z "$(which ruby)" ]; then
    sudo apt-get install -y ruby # really don't care which version, selecta runs on anything i'm pretty sure
fi

# selecta expect rbenv which then delegates to system
if [ ! -d ~/.rbenv ]; then
    git clone git@github.com:rbenv/rbenv.git ~/.rbenv

    if [ -z "$(which gcc)" ]; then
        sudo apt-get install -y gcc
    fi

    eval rbenv_path=~/.rbenv/bin
    export PATH="$rbenv_path:$PATH"
fi

CODE_DIR="$HOME/github.com/jasonewall"
cd $CODE_DIR

if [ ! -d $CODE_DIR/dotfiles ]; then
    git clone git@github.com:jasonewall/dotfiles.git
fi

cd dotfiles

git switch my-dotfiles

mv ~/.gitconfig{,.backup}

cat <<"SCRIPT" | bash
    source rc
    dotfiles install dotfiles
    dotfiles install profile
    dotfiles install ps1
    dotfiles install git
    dotfiles install rbenv
SCRIPT

mv ~/.gitconfig{.backup,}

if [ -d /etc/docker ]; then
    sudo cp ~/github.com/jasonewall/new-machine/support/vagrant_guest/docker/daemon.json /etc/docker
    sudo systemctl restart docker
fi
