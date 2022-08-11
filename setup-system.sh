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

echo -e "Setup timezone"
ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
echo -e "Setup hwclock"
hwclock --systohc
echo -e "Generate locales: en_US, pl_PL, ja_JP"
echo "pl_PL.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.conf
echo "KEYMAP=pl" >> /etc/vconsole.conf
echo -e "Hostname generation"
read -p "$(echo -e "${BIGreen}Device type[T420/HUAWEI/PC (def: archbox)]: ${Color_Off}")" device_selection
hostname_name="archbox"
if [[ $device_selection = "PC" ]]; then
  $hostname_name="metatron"
  echo $hostname_name
elif [[ $device_selection = "HUAWEI" ]]; then
  $hostname_name="gabriel"
  echo $hostname_name
elif [[ $device_selection = "T420" ]]
  $hostname_name="ramiel"
  echo $hostname_name
else
  echo $hostname_name
fi

echo "${hostname_name}" > /etc/hostname

echo -e "${Red}Regenerating initramfs${Color_Off}"
mkinitcpio -P

echo -e "${BRed}Set root password${Color_Off}"
passwd

echo -e "${BBlue}Install all packages"

while read package; do
  pacman -S --noconfirm $package;
done < "installed_packages_database.txt"

echo -e "${Green}Done!${Color_Off}"

echo -e "Create user nixen"

groupadd network
groupadd adbusers
groupadd video
groupadd lp
groupadd audio
groupadd lpadmin
groupadd fanout
groupadd docker
groupadd sudo
groupadd plugdev

useradd -m -s /bin/zsh -G network,adbusers,video,lp,audio,wheel,lpadmin,fanout,docker,sudo,plugdev nixen
passwd nixen

cp install-rice.sh /home/nixen/
chown nixen:nixen /home/nixen/install-rice.sh
chmod 0755 /home/nixen/install-rice.sh

refind-install
echo -e "${BRed}Remember to update refind configuration to boot!"

echo -e "${Green}Please login as user nixen and execute install-rice.sh script to set up all configs and applications from AUR"
