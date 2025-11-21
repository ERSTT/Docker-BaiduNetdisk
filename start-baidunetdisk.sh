#!/bin/sh

baidunetdisk="/usr/local/baidunetdisk_installed"

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
