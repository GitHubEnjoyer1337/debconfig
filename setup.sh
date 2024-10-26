#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)

# Update packages list and update system
apt update
apt upgrade -y

# Making .config and Moving config files
cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/screenshots
mkdir -p /home/user01/github/ssh/githubenjoyer1337
mkdir -p /opt/appimages
cp -fr /home/$username/debconfig/.config /home/$username/
cp .bashrc /home/$username/.bashrc
cp .vimrc /home/$username/.vimrc
cp .tmux.conf /home/$username/.tmux.conf
cp -r nvim /home/$username/.config
cp -r i3 /home/$username/.config
cp keepassxc /opt/appimages/keepassxc
chown -R $username:$username /home/$username

# Block for Root User
mkdir -p /root/.config

cp .bashrc /root/.bashrc
cp .vimrc /root/.vimrc
cp .tmux.conf /root/.tmux.conf
cp -r nvim /root/.config
cp -r i3 /root/.config

chown -R root:root /root

# Installing Essential Programs 
apt install sudo xorg kitty wget curl tmux build-essential dos2unix exfat-fuse exfatprogs ntfs-3g alsa-utils pulseaudio pavucontrol net-tools nmap feh gdisk gimp maim slop xclip ripgrep zathura vim vim-gtk3 lightdm i3 golang nodejs npm exiftool lshw rsync libreoffice redshift -y

# Installing the most recent Neovim version
wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -O /usr/local/bin/nvim
chmod +x /usr/local/bin/nvim

# Install Packer.nvim for Neovim ( User installation )
sudo -u $username git clone --depth 1 https://github.com/wbthomason/packer.nvim /home/$username/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install Packer.nvim for root user
git clone --depth 1 https://github.com/wbthomason/packer.nvim /root/.local/share/nvim/site/pack/packer/start/packer.nvim

# Create a symbolic link to use Neovim when typing 'vim'
ln -sf /usr/local/bin/nvim /usr/bin/vim

# install rust
su - $username -c 'curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y'


# for pdf viewing
# zathura

# for ss and pic viewing and editing
# gimp maim slop

# for formatting:
# exfat-fuse exfatprogs
# ntfs-3g
# gdisk for switching partitioning scheme
# 
# for audio:
# alsa-utils pulseaudio pavucontrol
#
# for quick image viewing:
# feh
#
# for removing metadata:
# exiftool
#
# for reading hardware:
# lshw ( use sudo lshw -short )
#
# for night-mode:
# redshift {commands:   redshift -O 3500    (night-mode)
#                       redshift -x         (back to default)
#          }
