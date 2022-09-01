#!/bin/bash

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

echo -e "${BGreen}Welcome to my Arch install script${Color_Off}"

efi_part=$1
boot_part=$2
swap_part=$3
root_part=$4

echo -e "EFI partition: ${efi_part}"
echo -e "BOOT partition: ${boot_part}"
echo -e "SWAP partition: ${swap_part}"
echo -e "ROOT partition: ${root_part}"

read -p "$(echo -e "${BIRed}Confirm [y/N]: ${Color_Off}")" confirmation

if [[ $confirmation = "y" || $confirmation = "Y" ]]; then
  echo -e "${Green}Partition scheme updated!${Color_Off}"
else
  echo "Exitting..."
  exit
fi

echo -e "${Blue}Formatting partitions without EFI partition${Color_Off}"

echo -e "Formatting BOOT partition to EXT4 journaled"
mkfs.ext4 -j $boot_part
echo -e "Formatting SWAP"
mkswap $swap_part
echo -e "Formatting ROOT partition to F2FS"
mkfs.f2fs -f $root_part

read -p "$(echo -e "${BIRed}Format EFI partition to FAT32? This CANNOT BE UNDONE [y/N]: ${Color_Off}")" format_efi

if [[ $format_efi = "y" || $format_efi = "Y" ]]; then
  echo -e "${BIRed}Formatting EFI as FAT32!${Color_Off}"
  mkfs.fat -F32 ${efi_part}
else
  echo -e "${Blue}Not formatting EFI${Color_Off}"
fi

mount $root_part /mnt
mkdir -p /mnt/boot
mount $boot_part /mnt/boot
mkdir -p /mnt/boot/efi
mount $efi_part /mnt/boot/efi

echo -e "${Green}Bootstrapping base arch image to destination rootfs${Color_Off}"
pacstrap /mnt base linux linux-firmware networkmanager vim emacs make cmake base-devel git xorg sudo
genfstab -U /mnt >> /mnt/etc/fstab

cp setup-system.sh /mnt/
cp install-rice.sh /mnt/
cp enabled-services.txt /mnt/
cp installed_packages_database.txt /mnt/

echo -e "${Blue}Chrooting into new system, execute setup-system.sh to install all needed packages and setup services${Color_Off}"
arch-chroot /mnt




