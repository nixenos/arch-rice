!#!/bin/bash

echo -e "Cloning needed repository"
git clone https://git.nixenos.ovh/nixen/arch-rice.git
cd arch-rice

cp -r ./configs/BetterDiscord ~/.config/
cp -r ./configs/mpv ~/.config/
cp -r ./configs/rofi ~/.config/
cp -r ./configs/dunst ~/.config/
cp -r ./configs/newsboat ~/.config/
cp -r ./configs/ranger ~/.config/
cp -r ./configs/networkmanager-dmenu ~/.config/

mkdir -p ~/.install

echo "Installing nvchad"
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
mkdir -p ~/.config/nvim/lua/custom
cp -r ./configs/nvim-lua-custom/* ~/.config/nvim/lua/custom/

echo "Copying wallpapers"
mkdir -p ~/Pictures/Wallpapers/
cp ./Wallpapers/* ~/Pictures/Wallpapers/

echo "Installing ohmyzsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Copying .zshrc"
cp ./configs/.zshrc ~/

echo "Prepare .local/bin" 
mkdir -p ~/.local/bin
cp ./local-binaries/* ~/.local/bin/

echo "Install doom emacs"
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install
cp ./configs/emacs/* ~/.doom.d/

echo "Copy dwm autostart script"
mkdir ~/.dwm
cp ./configs/autostart.sh ~/.dwm/

echo "Copy X config files"
cp ./configs/.xinitrc ~/.xinitrc

echo "Install nerdfonts"
mkdir -p ~/.install
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git ~/.install/nerd-fonts
~/.install/nerd-fonts/install.sh

echo "Install suckless suite"
git clone https://github.com/nixenos/nixst.git ~/.install/nixst
cd ~/.install/nixst
git checkout new-base
make
sudo make install
git clone https://github.com/nixenos/nixdwm.git ~/.install/nixdwm
cd ~/.install/nixdwm
make
sudo make install
git clone https://github.com/nixenos/nixdmenu.git ~/.install/nixdmenu
cd ~/.install/nixdmenu
make
sudo make install
git clone https://github.com/nixenos/nixdwmblocks.git ~/.install/nixdwmblocks
cd ~/.install/nixdwmblocks/
make
sudo make install

echo "Installing muttwizard"
git clone https://github.com/LukeSmithxyz/mutt-wizard ~/.install/mutt-wizard
cd ~/.install/mutt-wizard/
sudo make install

echo "All packages installed, all configs are in place!"
