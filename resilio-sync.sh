apt    -y    install    wget curl
wget   -c    https://download-cdn.resilio.com/stable/debian/amd64/0/resilio-sync_3.0.2.1058-1_amd64.deb
# curl       --socks5-hostname    127.0.0.1:8000     -O     https://download-cdn.resilio.com/stable/debian/amd64/0/resilio-sync_3.0.2.1058-1_amd64.deb
dpkg   -i    resilio-sync_3.0.2.1058-1_amd64.deb
echo   '
{"storage_path" : "/var/lib/resilio-sync/"
,"pid_file"     : "/var/run/resilio-sync/sync.pid"
,"webui" : {"force_https" : false
           ,"listen"      : "0.0.0.0:8888"
           }
}
'          >         /etc/resilio-sync/config.json
systemctl  enable    resilio-sync
systemctl  restart   resilio-sync
netstat    -plnt




#私有云盘resilio-sync服务器搭建 @ Debian
