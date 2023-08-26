#/usr/bin/env bash
# For VSCode dev containers

git clone git@github.com:jasonwall/dotfiles.git ~/dotfiles

cd ~/dotfiles

git switch my-dotfiles

source rc

dotfiles install dotfiles
dotfiles install git
