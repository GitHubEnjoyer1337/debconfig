#!/bin/bash

username=$(id -u -n 1000)

cp /home/$username/.tmux.conf /home/$username/debconfig/.tmux.conf
cp /home/$username/.bashrc /home/$username/debconfig/.bashrc
cp -R /home/$username/.config/i3 /home/$username/debconfig/i3

# For nvim, use rsync to exclude .git directory
rsync -av --exclude='.git' /home/$username/.config/nvim/ /home/$username/debconfig/nvim/
