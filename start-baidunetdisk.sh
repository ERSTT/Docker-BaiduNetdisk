#!/bin/sh

baidunetdisk="/usr/local/baidunetdisk_installed"

if [ ! -f "$baidunetdisk" ]; then
    sudo curl -L -o /tmp/baidunetdisk_4.17.7_amd64.deb \
        https://issuepcdn.baidupcs.com/issue/netdisk/LinuxGuanjia/4.17.7/baidunetdisk_4.17.7_amd64.deb && \
    sudo apt-get install -y /tmp/baidunetdisk_4.17.7_amd64.deb && \
    sudo rm -rf /tmp/baidunetdisk_4.17.7_amd64.deb

    sudo touch "$baidunetdisk"
fi

/opt/baidunetdisk/baidunetdisk --no-sandbox > /dev/null 2>&1 &

#todo
#/opt/baidunetdisk/baidunetdisk --no-sandbox --disable-gpu > /dev/null 2>&1 &
