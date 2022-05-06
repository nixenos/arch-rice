#!/bin/bash

echo "Copy .config directories"

cp -r ~/.config/bspwm ~/rice/void-rice/
cp -r ~/.config/dunst ~/rice/void-rice/
cp -r ~/.config/alacritty ~/rice/void-rice/
cp -r ~/.config/rofi ~/rice/void-rice/
cp -r ~/.config/sxhkd ~/rice/void-rice/
cp -r ~/.config/nvim/lua/custom ~/rice/void-rice/nvim-lua-custom
cp -r ~/.config/picom.conf ~/rice/void-rice/
cp -r ~/.config/polybar ~/rice/void-rice/

echo "Copy local scripts"

cp -r ~/.local/bin ~/rice/void-rice/local-bin

echo "Copy xorg/zsh configs"

cp ~/.zshrc ~/rice/void-rice/
cp ~/.xinitrc ~/rice/void-rice/
cp ~/.Xresources ~/rice/void-rice/
