apt-get update
apt-get install -y qbittorrent
apt-get install  -y vlc
apt-get install -y nano
sudo chmod -R 777 /config
sudo chmod -R 777 /defaults

# 添加火狐浏览器桌面图标以abc用户运行，因为root用户不允许运行火狐浏览器
cat <<EOL > ~/Desktop/firefox-abc.desktop
[Desktop Entry]
Version=1.0
Name=Firefox (Run as abc)
Comment=Run Firefox as abc user
Exec=sudo -u abc firefox
Icon=firefox
Terminal=false
Type=Application
Categories=Network;WebBrowser;
EOL

# 设置快捷方式文件的权限
chmod +x ~/Desktop/firefox-abc.desktop

cat <<EOL > ~/Desktop/vlc-abc.desktop
[Desktop Entry]
Version=1.0
Name=vlc (Run as abc)
Comment=Run vlc as abc user
Exec=sudo -u abc vlc
Icon=vlc
Terminal=false
Type=Application
Categories=Multimedia;Player;Video;
EOL

# 设置快捷方式文件的权限
chmod +x ~/Desktop/vlc-abc.desktop

