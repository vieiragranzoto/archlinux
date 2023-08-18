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

rm -rf yay

sudo pacman -S --noconfirm sway wayland xorg-xwayland alacritty rofi firefox nemo pulseaudio pulseaudio-alsa alsa-utils pulseaudio-alsa pavucontrol neofetch zsh zsh-completions

git clone https://github.com/vieiragranzoto/dotfiles.git

chsh -s /usr/bin/zsh

zsh

q

mkdir -p Images/Wallpapers

cd dotfiles
mv .zshrc ~
mv .gtk-2.0 ~
mv .config ~
mv .mozilla ~

cd

rm -rf dotfiles
