#!/bin/bash

termux-change-repo
pkg upgrade -y
pkg install x11-repo tur-repo -y
pkg install pulseaudio git virglrenderer-android mesa wget fontconfig freetype libpng termux-x11-nightly cabextract zenity openbox file xorg-xrandr xterm iconv termux-exec nnn -y 
echo "Change to the home directory and set up Termux storage"
cd
termux-setup-storage
mkdir -p $HOME/.local/cache
mkdir -p $HOME/.fonts
echo "Download required files"
wget https://github.com/eirkkk/TeurmWine/releases/download/TeurmWine/glibc-pfx.tar.xz
wget https://github.com/eirkkk/TeurmWine/releases/download/TeurmWine/terumwine.tar.xz
wget https://github.com/eirkkk/TeurmWine/releases/download/TeurmWine/wine-8.14-amd64.tar.xz

echo "Extract glibc"
tar -xf glibc-pfx.tar.xz -C $PREFIX
rm glibc-pfx.tar.xz

echo "Extract terumwine.tar.xz"
tar -xf terumwine.tar.xz

echo "Copy necessary files to Termux installation directory"
cd $HOME/.fix/Script/
chmod +x *
cp -r $HOME/.fix/Script/* $PREFIX/bin/
cp -r $HOME/.fix/opt $PREFIX/glibc/

echo "Extract wine"
tar -xf wine-8.14-amd64.tar.xz -C $PREFIX
cd $PREFIX
mv wine-8.14-amd64 wine
cd
clear
echo "Mesa version"
echo "(Mesa 23.2.1 stable)"
echo "(Mesa 23.3.0 devl Default )"

read -p "Enter your choice (1 or 2): " choice

if [ "$choice" == "1" ]; then
    wget https://raw.githubusercontent.com/eirkkk/TeurmWine/main/mesa-glibc/lib32.zip
    wget https://raw.githubusercontent.com/eirkkk/TeurmWine/main/mesa-glibc/lib64.zip
    unzip lib32.zip
    cp -r lib32/libvulkan_freedreno.so /data/data/com.termux/files/usr/glibc/lib32
    cp -r lib32/freedreno_icd.armhf.json /data/data/com.termux/files/usr/glibc/share/vulkan/icd.d
    unzip lib64.zip
    cd
    cp -r lib64/libvulkan_freedreno.so /data/data/com.termux/files/usr/glibc/lib
    cp -r lib64/freedreno_icd.aarch64.json /data/data/com.termux/files/usr/glibc/share/vulkan/icd.d
    echo "You chose version 1."
elif [ "$choice" == "2" ]; then
    echo "You chose version 2 (Default)."
    # You can add additional actions for this option here.
else
    echo "Invalid choice. Please enter 1 or 2."
fi

rm -f  wine-8.14-amd64.tar.xz terumwine.tar.xz lib32* lib64* steup.sh
echo "Execute your custom 'fix' command"
# Replace the following line with the actual command you want to run
clear 
fix

