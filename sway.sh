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
makepkg -si

sudo pacman -S --noconfirm sway wayland xorg-xwayland alacritty rofi firefox nemo pulseaudio pulseaudio-alsa alsa-utils pulseaudio-alsa pavucontrol neofetch zsh zsh-completions

mkdir -p ~/.config/sway
mkdir ~/.config/alacritty
mkdir ~/.config/gtk-3.0
mkdir ~/.config/rofi
