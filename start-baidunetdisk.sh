#!/bin/sh

BAIDU_MARKER="/usr/local/baidunetdisk_installed"
CONFIG_DIR="/config"

CLEAN_DIRS="$CONFIG_DIR/.cache $CONFIG_DIR/.dbus $CONFIG_DIR/.local $CONFIG_DIR/.XDG $CONFIG_DIR/.config/openbox $CONFIG_DIR/.config/pulse"

for dir in $CLEAN_DIRS; do
    if [ -d "$dir" ]; then
        echo "Removing $dir ..."
        rm -rf "$dir"
    fi
done

echo "Clean up complete."

if [ ! -f "$BAIDU_MARKER" ]; then
    arch=$(uname -m)
    is_arm64=0
    
    if [ "$arch" = "x86_64" ]; then
        arch_keyword="amd64.deb"
    elif [ "$arch" = "aarch64" ] || [ "$arch" = "arm64" ]; then
        arch_keyword="arm64.deb"
        is_arm64=1
    else
        echo "Error: Unsupported architecture: $arch"
        exit 1
    fi

    echo "Fetching latest download URL from Baidu API..."

    api_response=$(curl -s "https://pan.baidu.com/disk/cmsdata?do=client")
    url=$(echo "$api_response" | grep -o -E "https?://[^\"]*${arch_keyword}" | head -n1)
    
    if [ $is_arm64 -eq 1 ]; then
        echo "Notice: ARM64 architecture detected. Using temporary fallback URL (v4.17.7)..."
        url="https://issuepcdn.baidupcs.com/issue/netdisk/LinuxGuanjia/4.17.7/baidunetdisk_4.17.7_arm64.deb"
    fi
    
    if [ -z "$url" ] || [ "$url" = "null" ]; then
        echo "Error: Failed to fetch download URL from Baidu API."
        echo "API Response was: $api_response"
        exit 1
    fi

    echo "Downloading Baidu Netdisk from: $url"
    sudo curl -L -o /tmp/baidunetdisk.deb "$url"
    
    echo "Installing Baidu Netdisk..."
    sudo apt-get install -y /tmp/baidunetdisk.deb
    sudo rm -f /tmp/baidunetdisk.deb

    sudo touch "$BAIDU_MARKER"
fi

echo "Starting Baidu Netdisk..."
if [ -f "/opt/baidunetdisk/baidunetdisk" ]; then
    /opt/baidunetdisk/baidunetdisk --no-sandbox > /dev/null 2>&1 &
else
    echo "Error: Installation file not found in /opt/baidunetdisk/"
    exit 1
fi

#todo
#/opt/baidunetdisk/baidunetdisk --no-sandbox --disable-gpu > /dev/null 2>&1 &
