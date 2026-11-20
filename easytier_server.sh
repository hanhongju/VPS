apt    update
apt    install   -y    unzip curl
curl   -sL       "https://github.com/EasyTier/EasyTier/releases/download/v2.6.4/easytier-linux-x86_64-v2.6.4.zip"   -o   easytier-linux-x86_64.zip
unzip            easytier-linux-x86_64.zip
cp     -r        ./easytier-linux-x86_64/.      /usr/local/bin/


echo '
[Unit]
Description=EasyTier Service
After=network.target syslog.target
Wants=network.target
[Service]
Type=simple
ExecStart=/usr/local/bin/easytier-core
Restart=always
RestartSec=3
LimitNOFILE=1048576
Environment=TOKIO_CONSOLE=1
[Install]
WantedBy=multi-user.target
'  >   /etc/systemd/system/easytier.service
systemctl     daemon-reload
systemctl     restart      easytier
sleep   1s
netstat       -plnt




# host-public-server
# 参考文献：https://easytier.cn/guide/network/host-public-server.html
