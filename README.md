# archlinux

In this repository you will find scripts for the base install of Arch Linux and Sway.
Remember that the first part of the Arch Linux install is manual, that is you will have to partition, format and mount the disk yourself. Install the base packages and make sure to inlcude git so that you can clone the repository in chroot.

## Arch Linux Install

- loadkeys and timedatectl
- gdisk /disk-name
- Partition 1: n, Partition number=default, First sector=default, Last sector=+1G, Hex code or GUID= eff00
- Partition 2: n, Partition number=default, First sector=default, Last sector=+1G, Hex code or GUID= 8200
- Partition 3: n, Partition number=default, First sector=default, Last sector=default, Hex code or GUID=default
- w
- Y
- mkfs.fat -F 32 /dev/partition1-name
- mkswap /dev/partition2-name
- swapon /dev/partition2-name
- cryptsetup luksFormat /dev/parition3-name
- YES
- cryptsetup luksOpen /dev/parition3-name cryptroot
- mkfs.btrfs /dev/mapper/cryptroot
- mount /dev/mapper/cryptroot /mnt
- cd /mnt
- btrfs subvolume create @
- btrfs subvolume create @home
- cd
- umount /mnt
- mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/mapper/cryptroot /mnt
- mkdir /mnt/home
- mkdir /mnt/boot
- mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/mapper/cryptroot /mnt/home
- mount /dev/partition1-name /mnt/boot
- lsblk
- pacstrap -K /mnt base linux linux-firmware amd-ucode btrfs-progs neovim git
- genfstab -U /mnt >> /mnt/etc/fstab
- arch-chroot /mnt
- git clone https://github.com/vieiragranzoto/archlinux.git
- cd archlinux
- chmod +x base.sh
- cd /
- ./archlinux/base.sh
- Remove iptables? y
- Y
- rm -rf archlinux
- nvim /etc/mkinitcpio.conf
- add btrfs in MODULES()
- add encrypt in HOOKS() before filesystems
- save and quit
- mkinitcpio -p linux
- type blkid and copy the /dev/partition3-name UUID
- nvim /etc/default/grub
- GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet cryptdevice=UUID=paste-uuid:cryptroot root=/dev/mapper/cryptroot video=1366x768"
- save and exit
- grub-mkconfig -o /boot/grub/grub.cfg
- exit
- reboot
- su -
- swapoff /dev/partition2-name
- mkfs.ext2 -L cryptswap /dev/partition2-name 1M
- nvim /etc/crypttab
- remove hashtag in swap change device name to LABEL=cryptswap change the options to swap,offset=2048,cipher=aes-xts-plain64,size=512
- save and exit
- nvim /etc/fstab
- in /dev/partition2-name change de UUID to /dev/mapper/swap
- save and exit
- mount -a
- reboot
- lsblk
- change user and root passwd
- git clone https://github.com/vieiragranzoto/archlinux.git
- cd archlinux
- chmod +x sway.sh
- cd 
- ./archlinux/sway.sh system will reboot after that
- Option 0
- rm -rf archlinux
- cp .config/.zshrc ~/.zshrc
- reboot
- Open terminal $mod+Return
- sudo nvim /etc/locale.gen
- uncomment en_US.UTF-8 UTF-8
- save and exit
- sudo locale-gen
- sudo pacman -Syy
