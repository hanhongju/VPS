apt     -y    update
apt     -y    install     qbittorrent-nox net-tools
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
systemctl   start      qbittorrent-nox
sleep       1s
netstat     -plnt
echo        "用户名admin，密码adminadmin，默认下载目录/Downloads/"




uninstall () {
apt   -y    purge      qbittorrent-nox
systemctl   disable    qbittorrent-nox
systemctl   stop       qbittorrent-nox
rm          -rf        /.config/qBittorrent/

}




# qBittorrent安装脚本 @ Debian 10
