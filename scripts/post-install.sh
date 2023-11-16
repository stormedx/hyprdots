#!/bin/bash

# This is a post-install script I created for simply automating my extremely boring post-installation programs & preferences. More will come later.

echo "Updating system..."
sudo pacman -Syu

echo "setting keyboard repeat rate"
xset r rate 300 50

echo "enabling NetworkManager..."
sudo systemctl enable NetworkManager

echo "Installing yay..."
git clone https://aur.arch.linux.org/yay.git
cd yay
makepkg -si

echo "Installing programs, applications, etc..."
sudo pacman -S --noconfirm discord kitty steam neofetch htop
yay -S --noconfirm brave-bin nomacs swww waybar visual-studio-code-bin nerd-fonts telegram-desktop-bin
echo "Done. Updating."

sudo pacman -Syu
echo "Done for now :^)"
