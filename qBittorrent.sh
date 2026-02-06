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
ExecStart=/usr/bin/qbittorrent-nox --webui-port=8088
Restart=on-failure
[Install]
WantedBy=multi-user.target
'           >          /etc/systemd/system/qbittorrent-nox.service
systemctl   daemon-reload
systemctl   enable     qbittorrent-nox
systemctl   stop       qbittorrent-nox
rm          -f         /.config/qBittorrent/qBittorrent.conf
echo    '
[BitTorrent]
Session\Port=51291
Session\QueueingSystemEnabled=false
[Meta]
MigrationVersion=4
[Network]
Cookies=@Invalid()
[Preferences]
WebUI\Port=8088
WebUI\Username=hhj
WebUI\Password_PBKDF2="@ByteArray(vMQ1gRacoWeG9CCWbQes1Q==:A63s5lX9y+Agutul89glKcA7ttZzvnNi0xhfLksSdZb0zdxQfKpZFXpLtI3mOMdFB1NsGngImB/Q6zLg2AVrQg==)"
'           >           /.config/qBittorrent/qBittorrent.conf
systemctl   restart     qbittorrent-nox
sleep       1s
netstat     -plnt
crontab     -l
echo        "用户名hhj，密码fengkuang，默认下载目录/Downloads/"




uninstall () {
systemctl   disable    qbittorrent-nox
systemctl   stop       qbittorrent-nox
apt    -y   purge      qbittorrent-nox
apt    -y   autoremove
rm          -rf        /.config/qBittorrent/
netstat     -plnt

}




# CentOS 7
yum     -y    makecache
yum     -y    install       qbittorrent-nox net-tools
systemctl     stop          firewalld
systemctl     disable       firewalld
echo    '
0 1 * * *     yum    -y     makecache
0 2 * * *     yum    -y     update
0 3 * * *     yum    -y     clean    all
0 * * * *     pkill         tcrond
'       |     crontab
echo    '
[Unit]
Description=qBittorrent Command Line Client
After=network.target
[Service]
Type=forking
ExecStart=/usr/bin/qbittorrent-nox -d --webui-port=8088
Restart=on-failure
[Install]
WantedBy=multi-user.target
'           >          /etc/systemd/system/qbittorrent-nox.service
systemctl   daemon-reload
systemctl   enable     qbittorrent-nox
systemctl   stop       qbittorrent-nox
rm          -rf        /.config/qBittorrent/
systemctl   restart    qbittorrent-nox
sleep       1s
netstat     -plnt
crontab     -l
echo        "用户名admin，密码adminadmin，默认下载目录/Downloads/"




uninstall () {
systemctl   disable    qbittorrent-nox
systemctl   stop       qbittorrent-nox
yum    -y   remove     qbittorrent-nox
netstat     -plnt

}




# qBittorrent安装脚本
