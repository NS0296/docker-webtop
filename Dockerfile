FROM exwjk/kasm:baseimage-kasmvnc

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"
ARG DEBIAN_FRONTEND="noninteractive"

# title
ENV TITLE="Ubuntu KDE"

# prevent Ubuntu's firefox stub from being installed
COPY /root/etc/apt/preferences.d/firefox-no-snap /etc/apt/preferences.d/firefox-no-snap

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/webtop-logo.png && \
  echo "**** install packages ****" && \
  add-apt-repository -y ppa:mozillateam/ppa && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
  apt-get install --no-install-recommends -y \
    dolphin \
    firefox \
    gwenview \
    kde-config-gtk-style \
    kdialog \
    kfind \
    khotkeys \
    kio-extras \
    knewstuff-dialog \
    konsole \
    ksystemstats \
    kubuntu-settings-desktop \
    kubuntu-wallpapers \
    kubuntu-web-shortcuts \
    kwin-addons \
    kwin-x11 \
    kwrite \
    plasma-desktop \
    plasma-workspace \
    plymouth-theme-kubuntu-logo \
    qml-module-qt-labs-platform \
    qbittorrent \
    systemsettings && \
  echo "**** kde tweaks ****" && \
  sed -i \
    's/applications:org.kde.discover.desktop,/applications:org.kde.konsole.desktop,/g' \
    /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /config/.launchpadlib \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*
# 添加火狐浏览器桌面图标以abc用户运行，因为root用户不允许运行火狐浏览器
# 创建桌面快捷方式文件
RUN echo "[Desktop Entry]\n\
Version=1.0\n\
Name=Firefox (Run as abc)\n\
Comment=Run Firefox as abc user\n\
Exec=sudo -u abc firefox\n\
Icon=firefox\n\
Terminal=false\n\
Type=Application\n\
Categories=Network;WebBrowser;" > ~/Desktop/firefox-abc.desktop

# 设置快捷方式文件的权限
RUN chmod +x ~/Desktop/firefox-abc.desktop


# add local files
COPY /root /

# ports and volumes
EXPOSE 3000
VOLUME /config
