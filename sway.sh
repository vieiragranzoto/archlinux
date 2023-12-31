#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

sudo reflector -c Brazil -a 12 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm 

# Remove virtualbox-guest-utils if not needed
sudo pacman -S --noconfirm virtualbox-guest-utils sway wayland xorg-xwayland waybar swaybg alacritty rofi firefox nemo pulseaudio pulseaudio-alsa alsa-utils pulseaudio-alsa pavucontrol neofetch zsh zsh-completions ttf-fantasque-nerd ttf-jetbrains-mono-nerd grim feh slurp gtk2 gnome-themes-extra adwaita-icon-theme

systemctl enable vboxservice.service

git clone https://github.com/vieiragranzoto/dotfiles.git

cd dotfiles
mv .config ~
mv .mozilla ~
mv Images ~

cd

rm -rf dotfiles
rm -rf yay

mkdir .config/zsh

mv .config/.gtkrc-2.0 ~

yay --noconfirm -S autotiling sublime-text-4

pulseaudio -D

chsh -s /usr/bin/zsh

reboot
