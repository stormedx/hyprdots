#!/bin/bash

# This is a post-install script I created for simply automating my boring post-installation programs & preferences. More will come later.

echo "Updating system..."
sudo pacman -Syu --needed --noconfirm git vim nano wget curl glib2

# Set keyboard repeat rate for X11
sudo xset r rate 300 50
# Set keyboard repeat rate for Wayland (Gnome/gsettings)
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 300
gsettings set org.gnome.desktop.peripherals.keyboard delay 50

# Install yay
echo "Installing yay..."
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si --needed --noconfirm

# Install general wayland, system dependencies & programs
echo "Installing Wayland, general system dependencies & programs..."
sleep 1
sudo pacman -S --needed --noconfirm wayland wayland-protocols xorg-server-xwayland
sudo pacman -S --needed --noconfirm kitty nerd-fonts python-pip flatpak wget curl neofetch openssh samba nfs-utils ufw
yay -S --needed --noconfirm ranger ttf-ms-fonts ttf-roboto-mono ttf-roboto ttf-roboto-slab ttf-ubuntu-font-family ttf-joypixels ttf-twemoji-color ttf-symbola ttf-weather-icons ttf-material-design-icons-extended ttf-material-design-icons ttf-font-awesome-4 ttf-font-awesome ttf-hack ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-cascadia-code ttf-cascadia-code-pl ttf-cascadia-mono ttf-cascadia-mono-pl ttf-cascadia-sans ttf-cascadia-sans-pl ttf-cascadia-sans-mono ttf-cascadia-sans-mono-pl ttf-cascadia-code-jetbrains-mono ttf-cascadia-code-jetbrains-mono-pl ttf-cascadia-code-jetbrains-mono-mono ttf-cascadia-code-jetbrains-mono-mono-pl ttf-cascadia-code-jetbrains-mono-sans ttf-cascadia-code-jetbrains-mono-sans-pl ttf-cascadia-code-jetbrains-mono-sans-mono ttf-cascadia-code-jetbrains-mono-sans-mono-pl ttf-cascadia-code-jetbrains-mono-slab ttf-cascadia-code-jetbrains-mono-slab-pl ttf-cascadia-code-jetbrains-mono-slab-mono ttf-cascadia-code-jetbrains-mono-slab-mono-pl ttf-cascadia-code-jetbrains-mono-italic ttf-cascadia-code-jetbrains-mono-italic-pl ttf-cascadia-code-jetbrains-mono-italic-mono ttf-cascadia-code-jetbrains-mono-italic-mono-pl ttf-cascadia-code-jetbrains-mono-sans-italic ttf-cascadia-code-jetbrains-mono-sans-italic-pl ttf-cascadia-code-jetbrains-mono-sans-italic-mono ttf-cascadia-code-jetbrains-mono-sans-italic-mono-pl ttf-cascadia-code-jetbrains-mono-slab-italic ttf-cascadia-code-jetbrains-mono-slab-italic-pl ttf-cascadia-code-jetbrains-mono-slab-italic-mono ttf-cascadia-code-jetbrains-mono-slab-italic-mono-pl ttf-cascadia-code-jetbrains-mono-italic-sans ttf-cascadia-code-jetbrains-mono-italic-sans 
# Installing additional Hyprland-related packages I use
yay -S --needed --noconfirm dunst wofi swaybg swayidle swaylock swaylock-effects waybar
sudo pacman -Syu
yay -Syu

# Optional applications
echo "Install additional applications (discord, steam, etc.) (Y/n)"
read -r install_apps
# Default is yes
install_apps=${install_apps:-y}

if [[ $install_apps = ~[Yy]$ ]]
then    echo "Installing applications..."
        sudo pacman -S --needed --noconfirm discord steam vlc firefox nomacs kdeconnect visual-studio-code-bin 
        yay -S --needed --noconfirm brave-bin telegram-desktop-bin 
        echo "Applications installed. Updating..."
        sudo pacman -Syu
else    echo "Skipping applications..."
fi
echo "programs installed!"
sleep 1

# firewall configurartion
echo "Configuring firewall..."
sudo ufw enable
sudo ufw allow 22
sudo ufw allow 24
sudo ufw --force reload
echo "Enabled ssh & ftp!"
sleep 1

# Hyprland installation
# Menu Selection
packages=("hyprland" "hyprland-nvidia")
echo "1) Install Hyprland"
echo "2) Install Hyprland with Nvidia Support"
echo "3) Exit"
echo -n "Please select an option (1 or 2, press Enter for default): "
read -r choice
# Choice-based selection, defaults to 1
choice=${choice:-1}
selected_package=""
case "$choice" in
    1)
        selected_package=${packages[0]}
        ;;
    2)
        selected_package=${packages[1]}
        ;;
    3)
        echo "Exit"
        exit
        ;;
    *)
        echo "Exiting..."
        exit
        ;;
esac
echo "Installing $selected_package..."
sudo pacman -Syu --needed --noconfirm "$selected_package"
echo "Finished installing Hyprland & Hyprland accessories."
sleep 1

# Cloning and applying my dotfiles
echo "installing & applying dotfiles..."
sudo chmod -R 755 ~/.config/
git clone https://github.com/stormedx/hyprdots.git ~/temp_dots
sudo cp -r ~/temp_dots/.config/* ~/.config
sudo rm -rf ~/temp_dots
echo "dotfiles installed!"

echo "Done for now :^)"
sleep 2