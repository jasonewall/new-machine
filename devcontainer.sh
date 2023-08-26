#/usr/bin/env bash
# For VSCode dev containers

git clone https://github.com/jasonwall/dotfiles.git ~/dotfiles

cd ~/dotfiles

git switch my-dotfiles

source rc

dotfiles install dotfiles
dotfiles install profile
dotfiles install git
