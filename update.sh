#!/bin/bash

username=$(id -u -n 1000)

cp /home/$username/.tmux.conf /home/$username/debconfig/.tmux.conf
cp /home/$username/.zshrc /home/$username/debconfig/.zshrc
cp /home/$username/.config/i3/config /home/$username/debconfig/i3/config
cp /home/$username/.config/alacritty/alacritty.yml /home/$username/debconfig/alacritty.yml

# For nvim, use rsync to exclude .git directory
rsync -av --exclude='.git' /home/$username/.config/nvim/ /home/$username/debconfig/
