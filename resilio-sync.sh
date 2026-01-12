# Debian
apt       -y    update
apt       -y    install    curl net-tools
curl      --location       --continue-at -            \
          --remote-name    https://download-cdn.resilio.com/2.7.3.1381/Debian/resilio-sync_2.7.3.1381-1_amd64.deb
apt       -y    install    ./resilio-sync_2.7.3.1381-1_amd64.deb
mkdir     -p    /home/rslsync/
chmod     -R    777   /home/rslsync/
usermod   -aG   rslsync   hj
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




# CentOS 7
yum       -y    makecache
yum       -y    install    curl net-tools
curl      --location       --continue-at -            \
          --remote-name    https://download-cdn.resilio.com/stable/rpm/x86_64/0/resilio-sync-2.8.1.1390-1.x86_64.rpm
yum       -y    install    ./resilio-sync-2.8.1.1390-1.x86_64.rpm
systemctl       stop          firewalld
systemctl       disable       firewalld
mkdir     -p    /home/rslsync/
chmod     -R    777   /home/rslsync/
usermod   -aG   rslsync   hj
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




uninstall () {
systemctl   disable    resilio-sync
systemctl   stop       resilio-sync
netstat     -plnt

}




# 私有云盘resilio-sync服务器搭建
