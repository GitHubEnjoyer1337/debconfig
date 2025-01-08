#!/bin/bash

set -e  # Exit on error

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script" >&2
  exit 1
fi

# Function to determine the username of the main non-root user
get_username() {
    username=$(awk -F: '($3 >= 1000) && ($3 < 60000) && ($1 != "nobody") { print $1; exit }' /etc/passwd)

    if [ -z "$username" ]; then
        read -p "Enter the username of the regular user: " username
    fi

    # Check if user exists
    if ! id "$username" >/dev/null 2>&1; then
        echo "User $username does not exist."
        exit 1
    fi
}

get_username
home_dir="/home/$username"

# Check for required_files
required_files=(".zshrc" ".tmux.conf" "nvim" "i3" "alacritty.yml" "keepassxc")
for file in "${required_files[@]}"; do
    if [ ! -e "$file" ]; then
        echo "Error: Required file $file not found"
        exit 1
    fi
done

# Check for internet connection
if ! ping -c 1 google.com >/dev/null 2>&1; then
    echo "Error: No internet connection"
    exit 1
fi

create_dir() {
    if [ ! -d "$1" ]; then
        if ! mkdir -p "$1"; then
            echo "Error: Failed to create directory $1"
            exit 1
        fi
    fi
}

# Update packages list and upgrade system
apt update
apt upgrade -y

# Create directories
create_dir "$home_dir/.config"
create_dir "$home_dir/screenshots"
create_dir "$home_dir/github/ssh/githubenjoyer1337"
create_dir "$home_dir/.config/alacritty"
create_dir "/opt/appimages"
create_dir "$home_dir/.local/share/nvim/site/pack/packer/start"

# For Root User
create_dir "/root/.config"
create_dir "/root/.local/share/nvim/site/pack/packer/start"

# Install Essential Programs (excluding nodejs and npm)
apt install sudo xorg wget curl tmux build-essential dos2unix exfat-fuse exfatprogs ntfs-3g \
alsa-utils pulseaudio pavucontrol net-tools nmap feh gdisk gimp maim slop xclip ripgrep \
zathura vim vim-gtk3 sddm i3 golang exiftool lshw rsync libreoffice redshift e2fsprogs \
zsh pkg-config acl git dnsutils mpg123 libssl-dev -y


# Install Oh My Zsh for root if not already installed
if [ ! -d "/root/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh for root..."
    env HOME=/root sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh already installed for root."
fi

# Install plugins for root
if [ ! -d "/root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi
if [ ! -d "/root/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions /root/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

# Install Oh My Zsh for user if not already installed
if [ ! -d "$home_dir/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh for user..."
    su - "$username" -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'
else
    echo "Oh My Zsh already installed for user."
fi

# Install plugins for user
if [ ! -d "$home_dir/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    su - "$username" -c "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
fi
if [ ! -d "$home_dir/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    su - "$username" -c "git clone https://github.com/zsh-users/zsh-autosuggestions \${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
fi

# Set Zsh as default shell for user and root
chsh -s "$(which zsh)" "$username"
chsh -s "$(which zsh)" root

# Installing the most recent Neovim version
if [ ! -f /usr/local/bin/nvim ]; then
    wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -O /usr/local/bin/nvim
    chmod +x /usr/local/bin/nvim
else
    echo "Neovim already installed."
fi

# Install Packer.nvim for Neovim (User installation)
packer_dir="$home_dir/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [ -d "$packer_dir/.git" ]; then
    echo "Updating Packer.nvim for user..."
    su - "$username" -c "git -C \"$packer_dir\" pull"
else
    echo "Installing Packer.nvim for user..."
    su - "$username" -c "git clone --depth 1 https://github.com/wbthomason/packer.nvim '$packer_dir'"
fi

# Install Packer.nvim for root user
packer_dir_root="/root/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [ -d "$packer_dir_root/.git" ]; then
    echo "Updating Packer.nvim for root..."
    git -C "$packer_dir_root" pull
else
    echo "Installing Packer.nvim for root..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$packer_dir_root"
fi

# Install Rust (for user)
if ! su - "$username" -c 'rustc --version' >/dev/null 2>&1; then
    su - "$username" -c 'curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y'
else
    echo "Rust already installed for user."
fi

# Add additional paths to ensure mason can find npm and go binaries
if ! grep -q 'export PATH=\$PATH:/usr/local/bin:\$HOME/.local/bin:\$HOME/bin' "$home_dir/.zshrc" 2>/dev/null; then
    echo 'export PATH=$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/bin' >> "$home_dir/.zshrc"
fi
if ! grep -q 'export PATH=\$PATH:/usr/local/bin:\$HOME/.local/bin:\$HOME/bin' /root/.zshrc 2>/dev/null; then
    echo 'export PATH=$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/bin' >> /root/.zshrc
fi



# Install nvm and Node.js via nvm for root
if [ ! -d "/root/.nvm" ]; then
    echo "Installing nvm for root..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash   
    # Add nvm to .zshrc
    echo 'export NVM_DIR="/root/.nvm"' >> /root/.zshrc                               
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> /root/.zshrc          
    export NVM_DIR="/root/.nvm"                                                      
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                                 
    nvm install --lts                                                                
else
    echo "nvm already installed for root."
    export NVM_DIR="/root/.nvm"                                                      
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                                 
fi

# Install pnpm for root
echo "Installing pnpm for root..."                                                   
curl -fsSL https://get.pnpm.io/install.sh | sh -                                     

# Install nvm and Node.js via nvm for user
su - "$username" -c '
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing nvm for user..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash   
    # Add nvm to .zshrc
    echo "export NVM_DIR=\"\$HOME/.nvm\"" >> \$HOME/.zshrc                           
    echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\"" >> \$HOME/.zshrc   
    export NVM_DIR="\$HOME/.nvm"                                                     
    [ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"                               
    nvm install --lts                                                                
else
    echo "nvm already installed for user."
    export NVM_DIR="\$HOME/.nvm"                                                     
    [ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"                               
fi

# Install pnpm for user
echo "Installing pnpm for user..."                                                   
curl -fsSL https://get.pnpm.io/install.sh | sh -                                     

# Update npm and install global packages for user
npm install -g npm@latest
npm install -g vite create-vite
'


# Update npm and install global packages for root
npm install -g npm@latest
npm install -g vite create-vite

# Copy config files for user
cp .zshrc "$home_dir/.zshrc"
cp .tmux.conf "$home_dir/.tmux.conf"
cp -r nvim "$home_dir/.config/nvim"
cp -r i3 "$home_dir/.config/i3"
cp alacritty.yml "$home_dir/.config/alacritty/alacritty.yml"
cp keepassxc /opt/appimages/keepassxc

# Set correct ownership for the copied files
chown "$username:$username" "$home_dir/.zshrc" "$home_dir/.tmux.conf"
chown -R "$username:$username" "$home_dir/.config/nvim" "$home_dir/.config/i3" "$home_dir/.config/alacritty"
chown -R "$username:$username" "$home_dir/.local/share/nvim"

# Copy config files for root
cp .zshrc /root/.zshrc
cp .tmux.conf /root/.tmux.conf
cp -r nvim /root/.config/nvim
cp -r i3 /root/.config/i3

# Ensure root owns its home directory files
#chown root:root /root/.zshrc /root/.tmux.conf
#chown -R root:root /root/.config/nvim /root/.config/i3
#chown -R root:root /root/.local/share/nvim
chown -R root:root /root/


# Optionally create an alias for vim to nvim
if ! grep -q "alias vim='nvim'" "$home_dir/.zshrc" 2>/dev/null; then
    echo "alias vim='nvim'" >> "$home_dir/.zshrc"
fi
if ! grep -q "alias vim='nvim'" /root/.zshrc 2>/dev/null; then
    echo "alias vim='nvim'" >> /root/.zshrc
fi

echo "Setup complete!"


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
#
#
# for playing mp3:
# mpg123 <filename>
