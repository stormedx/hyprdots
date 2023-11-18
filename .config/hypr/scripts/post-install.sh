#!/bin/bash

# This is a post-install script I created for simply automating my boring post-installation programs & preferences. More will come later.

echo "Updating system..."
sudo pacman -Syu

echo "setting keyboard repeat rate"
sudo pacman -S glib2
# Set keyboard repeat rate for X11
sudo xset r rate 300 50
# Set keyboard repeat rate for Wayland (Gnome/gsettings)
echo "setting keyboard repeat rate"
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 300
gsettings set org.gnome.desktop.peripherals.keyboard delay 50

echo "Installing yay..."
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si

echo "Installing programs, applications, etc..."
sudo pacman -S --noconfirm discord kitty steam neofetch htop vim vlc firefox ranger python-pip wget curl flatpak kdeconnect
yay -S --noconfirm brave-bin nomacs telegram-desktop-bin ranger
echo "Applications installed. Updating..."
sudo pacman -Syu

echo "Installing Hyprland..."
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
sudo pacman -S --noconfirm "$selected_package"
echo "Finished! Now installing additional software for Hyprland..."

# Dependencies from my repo, more to be added as I get this better configured.
yay -S --noconfirm dunst wofi swaybg swayidle swaylock swaylock-effects waybar 
echo "Applications installed! Updating..."
yay -Syu

# Cloning and applying my dotfiles
echo "installing & applying dotfiles..."
sudo chmod -R 755 ~/.config/
git clone https://github.com/stormedx/hyprdots.git ~/temp_dots
cd ~/temp_dots || exit
sudo cp -r .config/* ~/.config
sudo rm -rf ~/temp_dots
echo "dotfiles installed!"

echo "Done for now :^)"