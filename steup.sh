#!/bin/bash

echo "Initialize and populate the Pacman keyring"
pacman-key --init
pacman-key --populate

echo "Update the system and install required packages"
pacman -Syu --noconfirm  glibc gcc-libs-glibc glibc-runner coreutils-glibc util-linux-glibc libxxf86vm-glibc linux-api-headers-glibc libxml2-utils-glibc libxcb-glibc libx11-glibc libdrm-glibc xkeyboard-config vulkan-headers-glibc xcb-proto-glibc xorg-util-macros-glibc xorgproto-glibc freetype-glibc fontconfig-utils-glibc termux-x11-nightly libxfixes-glibc libxshmfence-glibc libxxf86vm-glibc linux-api-headers-glibc libxml2-utils-glibc libxcb-glibc libx11-glibc libdrm-glibc xkeyboard-config vulkan-headers-glibc xcb-proto-glibc xorg-util-macros-glibc xorgproto-glibc freetype-glibc fontconfig-utils-glibc wget pulseaudio 

echo "Change to the home directory and set up Termux storage"
cd
termux-setup-storage

echo "Download required files"
wget https://github.com/eirkkk/TeurmWine/releases/download/TeurmWine/pkgs.tar.xz
wget https://github.com/eirkkk/TeurmWine/releases/download/TeurmWine/glibc-pfx.tar.xz
wget https://github.com/eirkkk/TeurmWine/releases/download/TeurmWine/terumwine.tar.xz
wget https://github.com/eirkkk/TeurmWine/releases/download/TeurmWine/wine-8.14-amd64.tar.xz

echo "Extract downloaded files"
tar -xf pkgs.tar.xz

echo "Install packages using Pacman"
cd pkgs
pacman -U --noconfirm *
cd
rm -rf pkgs

echo "Extract glibc"
tar -xf glibc-pfx.tar.xz -C /data/data/com.termux/files/usr/glibc
rm glibc-pfx.tar.xz

echo "Extract terumwine.tar.xz"
tar -xf terumwine.tar.xz

echo "Copy necessary files to Termux installation directory"
cp -r $HOME/.fix/start /data/data/com.termux/files/usr/bin/
cp -r $HOME/.fix/fix /data/data/com.termux/files/usr/bin/
cp -r $HOME/.fix/box /data/data/com.termux/files/usr/bin/

echo "Set execute permissions"
cd /data/data/com.termux/files/usr/bin/
chmod +x box start fix
cd

echo "Extract wine"
tar -xf wine-8.14-amd64.tar.xz -C /data/data/com.termux/files/usr/
cd /data/data/com.termux/files/usr/
mv wine-8.14-amd64 wine
cd
rm Pacman.sh  pkgs.tar.xz wine-8.14-amd64.tar.xz steup.sh terumwine.tar.xz pkgs
echo "Execute your custom 'fix' command"
fix
