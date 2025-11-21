#!/bin/sh

baidunetdisk="/usr/local/baidunetdisk_installed"

CONFIG_DIR="/config"
if [ -d "$CONFIG_DIR/.cache" ]; then
    echo "Removing $CONFIG_DIR/.cache ..."
    rm -rf "$CONFIG_DIR/.cache"
fi

if [ -d "$CONFIG_DIR/.dbus" ]; then
    echo "Removing $CONFIG_DIR/.dbus ..."
    rm -rf "$CONFIG_DIR/.dbus"
fi

if [ -d "$CONFIG_DIR/.local" ]; then
    echo "Removing $CONFIG_DIR/.local ..."
    rm -rf "$CONFIG_DIR/.local"
fi

if [ -d "$CONFIG_DIR/.XDG" ]; then
    echo "Removing $CONFIG_DIR/.XDG ..."
    rm -rf "$CONFIG_DIR/.XDG"
fi

if [ -d "$CONFIG_DIR/.config/openbox" ]; then
    echo "Removing $CONFIG_DIR/.config/openbox ..."
    rm -rf "$CONFIG_DIR/.config/openbox"
fi

if [ -d "$CONFIG_DIR/.config/pulse" ]; then
    echo "Removing $CONFIG_DIR/.config/pulse ..."
    rm -rf "$CONFIG_DIR/.config/pulse"
fi

echo "Clean up complete."

if [ ! -f "$baidunetdisk" ]; then
    arch=$(uname -m)
    
    if [ "$arch" = "x86_64" ]; then
        arch="amd64"
    elif [ "$arch" = "aarch64" ] || [ "$arch" = "arm64" ]; then
        arch="arm64"
    else
        echo "Unsupported architecture: $arch"
        exit 1
    fi

    url="https://issuepcdn.baidupcs.com/issue/netdisk/LinuxGuanjia/4.17.7/baidunetdisk_4.17.7_${arch}.deb"

    echo "Downloading Baidu Netdisk for $arch..."
    sudo curl -L -o /tmp/baidunetdisk.deb "$url"
    sudo apt-get install -y /tmp/baidunetdisk.deb
    sudo rm -rf /tmp/baidunetdisk.deb

    sudo touch "$baidunetdisk"
fi

/opt/baidunetdisk/baidunetdisk --no-sandbox > /dev/null 2>&1 &

#todo
#/opt/baidunetdisk/baidunetdisk --no-sandbox --disable-gpu > /dev/null 2>&1 &
