#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)
home_dir="/home/$user01"

# Update packages list and update system
apt update
apt upgrade -y

# Making .config and Moving config files
cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/screenshots
mkdir -p /home/user01/github/ssh/githubenjoyer1337
mkdir -p /home/$username/.config/alacritty
mkdir -p /opt/appimages
cp .zshrc /home/$username/.zshrc
cp .tmux.conf /home/$username/.tmux.conf
cp -r nvim /home/$username/.config
cp -r i3 /home/$username/.config
cp -r alacritty.yml /home/$username/.config/alacritty/alacritty.yml
cp keepassxc /opt/appimages/keepassxc
chown -R $username:$username /home/$username

# Block for Root User
mkdir -p /root/.config

cp .zshrc /root/.zshrc
cp .tmux.conf /root/.tmux.conf
cp -r nvim /root/.config
cp -r i3 /root/.config

chown -R root:root /root

# Installing Essential Programs 
apt install sudo xorg kitty wget curl tmux build-essential dos2unix exfat-fuse exfatprogs ntfs-3g alsa-utils pulseaudio pavucontrol net-tools nmap feh gdisk gimp maim slop xclip ripgrep zathura vim vim-gtk3 sddm i3 golang nodejs npm exiftool lshw rsync libreoffice redshift e2fsprogs alacritty zsh pkg-config acl libssl-dev -y

# Install Oh My Zsh for user
su - $username -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'

# Install Oh My Zsh for root
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install Zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Set Zsh as default shell for user and root
chsh -s $(which zsh) $username
chsh -s $(which zsh) root

# Installing the most recent Neovim version
wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -O /usr/local/bin/nvim
chmod +x /usr/local/bin/nvim

# Ensure $PATH includes the directories for binaries
export PATH=$PATH:/usr/local/bin:$home_dir/.local/bin:$home_dir/bin

# Install Packer.nvim for Neovim ( User installation )
sudo -u $username git clone --depth 1 https://github.com/wbthomason/packer.nvim /home/$username/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install Packer.nvim for root user
git clone --depth 1 https://github.com/wbthomason/packer.nvim /root/.local/share/nvim/site/pack/packer/start/packer.nvim

# Create a symbolic link to use Neovim when typing 'vim'
ln -sf /usr/local/bin/nvim /usr/bin/vim

# install rust
su - $username -c 'curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y'

# Add additional paths to ensure mason can find npm and go binaries
echo 'export PATH=$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/bin' | sudo -u $username tee -a $home_dir/.zshrc
echo 'export PATH=$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/bin' | sudo tee -a /root/.zshrc

# Ensure permissions for user home directory
chown -R $username:$username $home_dir

# Source the updated .zshrc for changes to take effect
sudo -u $username zsh -c 'source $HOME/.zshrc'
source /root/.zshrc





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
#
#
# for immutable files (for instance: making resolv.conf immutable (chattr is part of the e2fsprogs package)):
# chattr +i <filepath> ( make immutable )
# chattr -i <filepath> ( remove immutability )
#
#
#
# for advanced permissions(acl):
# getfacl: view acls
# setfacl: set acls
