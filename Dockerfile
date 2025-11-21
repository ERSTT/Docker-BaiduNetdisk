FROM lsiobase/selkies:debiantrixie

ENV TITLE="Baidu Netdisk"
ENV LC_ALL=zh_CN.UTF-8
ENV NO_GAMEPAD=true

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        libgtk-3-0 \
        libnotify4 \
        libnss3 \
        libxss1 \
        libxtst6 \
        xdg-utils \
        libatspi2.0-0 \
        libuuid1 \
        libsecret-1-0 \
        libappindicator3-1 \
        chromium \
        chromium-l10n && \
    mkdir -p /defaults && \
    curl -L -o /defaults/menu.xml \
        https://raw.githubusercontent.com/ERSTT/Docker-BaiduNetdisk/refs/heads/main/menu.xml && \
    curl -L -o /usr/share/selkies/www/icon.png \
        https://raw.githubusercontent.com/ERSTT/Docker-BaiduNetdisk/refs/heads/main/baidunetdisk.png && \
    curl -L -o /usr/bin/start-baidunetdisk.sh \
        https://raw.githubusercontent.com/ERSTT/Docker-BaiduNetdisk/refs/heads/main/start-baidunetdisk.sh && \
    curl -L -o /usr/local/baidunetdisk-icon.png \
        https://raw.githubusercontent.com/ERSTT/Docker-BaiduNetdisk/refs/heads/main/baidunetdisk-icon.png && \
    chmod +x /usr/bin/start-baidunetdisk.sh && \
    echo "/usr/bin/start-baidunetdisk.sh" > /defaults/autostart && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
