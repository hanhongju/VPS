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
Type=forking
WorkingDirectory=/root/.config/qBittorrent
ExecStart=/usr/bin/qbittorrent-nox --webui-port=8080
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
apt    -y   purge      qbittorrent-nox
apt    -y   autoremove
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
