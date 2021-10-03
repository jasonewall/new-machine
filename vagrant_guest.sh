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

CODE_DIR="$HOME/github.com/jasonewall"
cd $CODE_DIR

if [ ! -d "$CODE_DIR/dotfiles" ]; then
    git clone git@github.com:jasonewall/dotfiles.git
fi

cd dotfiles

git switch my-dotfiles

mv ~/.gitconfig{,.backup}

cat <<"SCRIPT" | bash
    source rc
    dotfiles install dotfiles
    dotfiles install profile
    dotfiles install git
SCRIPT

mv ~/.gitconfig{.backup,}
