#!/usr/bin/env bash
# For VSCode dev containers

git clone https://github.com/jasonewall/dotfiles.git ~/dotfiles

git clone https://github.com/jasonewall/bash-helpers.git ~/.scripts

cd ~/dotfiles

git switch my-dotfiles

source rc

dotfiles install dotfiles
dotfiles install profile
dotfiles install git
