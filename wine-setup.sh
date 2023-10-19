#!/bin/bash

# Initialize and populate the keyring
pacman-key --init
pacman-key --populate

# Install required packages
pacman -Syu glibc gcc-libs-glibc termux-x11-nightly glibc-runner coreutils-glibc util-linux-glibc libxxf86vm-glibc linux-api-headers-glibc libxml2-utils-glibc libxcb-glibc libx11-glibc libdrm-glibc xkeyboard-config vulkan-headers-glibc xcb-proto-glibc xorg-util-macros-glibc xorgproto-glibc freetype-glibc fontconfig-utils-glibc wget

# Configure environment variables in ~/.bashrc
echo 'export DISPLAY=:0' >> ~/.bashrc
echo 'export PULSE_SERVER=127.0.0.1' >> ~/.bashrc
echo 'export MESA_LOADER_DRIVER_OVERRIDE=zink' >> ~/.bashrc
echo 'export GALLIUM_HUD=simple,fps' >> ~/.bashrc
echo 'export ENABLE_GAMESCOPE_WSI=1' >> ~/.bashrc
echo 'export MESA_VK_WSI_PRESENT_MODE=immediate' >> ~/.bashrc
echo 'export USE_HEAP=1' >> ~/.bashrc
echo 'export vblank_mode=0' >> ~/.bashrc
echo 'termux-x11 :0 &>/dev/null & pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1 &>/dev/null' >> ~/.bashrc

# Set up Termux storage
termux-setup-storage

sleep 5

# Download and extract Wine
wget https://github.com/eirkkk/TeurmWine/releases/download/wine-termux/wine.tar.xz
tar -xf wine.tar.xz

# Copy Wine files to appropriate directories
cp -r wine-hangover/bin/* /data/data/com.termux/files/usr/glibc/bin/
cp -r wine-hangover/include/* /data/data/com.termux/files/usr/glibc/include/
cp -r wine-hangover/lib/* /data/data/com.termux/files/usr/glibc/lib
cp -r wine-hangover/opt /data/data/com.termux/files/usr/glibc/
cp -r wine-hangover/share/* /data/data/com.termux/files/usr/glibc/share/
 
cd $HOME

# Download and extract libwine
wget https://raw.githubusercontent.com/eirkkk/TeurmWine/main/libwine.zip
unzip libwine.zip
cd libwine

# Copy libwine files
cp -r * /data/data/com.termux/files/usr/glibc/lib

cd $HOME
rm -rf *wine*
# Set library paths and interpreters for Wine and Wineserver
patchelf --set-rpath /data/data/com.termux/files/usr/glibc/lib --set-interpreter /data/data/com.termux/files/usr/glibc/lib/ld-linux-aarch64.so.1 /data/data/com.termux/files/usr/glibc/bin/wine
patchelf --set-rpath /data/data/com.termux/files/usr/glibc/lib --set-interpreter /data/data/com.termux/files/usr/glibc/lib/ld-linux-aarch64.so.1 /data/data/com.termux/files/usr/glibc/bin/wineserver


