# Debian 10
apt     -y    update
apt     -y    install       qbittorrent-nox net-tools
echo    '
0 1 * * *     apt    -y     update
0 2 * * *     apt    -y     full-upgrade
0 3 * * *     apt    -y     autoremove
'       |     crontab
echo    '
[Unit]
Description=qBittorrent Command Line Client
After=network.target
[Service]
Type=simple
ExecStart=/usr/bin/qbittorrent-nox
Restart=on-failure
[Install]
WantedBy=multi-user.target
'           >          /etc/systemd/system/qbittorrent-nox.service
systemctl   daemon-reload
systemctl   enable     qbittorrent-nox
systemctl   start      qbittorrent-nox
sleep       1s
systemctl   stop       qbittorrent-nox
echo    '
[Preferences]
WebUI\Port=8088
WebUI\Username=hhj
WebUI\Password_PBKDF2="@ByteArray(vMQ1gRacoWeG9CCWbQes1Q==:A63s5lX9y+Agutul89glKcA7ttZzvnNi0xhfLksSdZb0zdxQfKpZFXpLtI3mOMdFB1NsGngImB/Q6zLg2AVrQg==)"
'           >           /.config/qBittorrent/qBittorrent.conf
systemctl   restart     qbittorrent-nox
crontab     -l
netstat     -plnt
echo        "用户名hhj，密码fengkuang，默认下载目录/Downloads/"




uninstall () {
systemctl   disable    qbittorrent-nox
systemctl   stop       qbittorrent-nox
apt    -y   purge      qbittorrent-nox
apt    -y   autoremove
rm          -rf        /.config/qBittorrent/
netstat     -plnt

}




# qBittorrent安装脚本
