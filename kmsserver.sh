apt     -y     update
apt     -y     install    wget
wget    -c     https://github.com/Wind4/vlmcsd/releases/download/svn1113/binaries.tar.gz
tar     -xf    binaries.tar.gz   -C.
cp      -f     ./binaries/Linux/intel/static/vlmcsd-x86-musl-static     /usr/bin/vlmcsd
echo    '
[Unit]
Description=KMS server
[Service]
Type=forking
PIDFile=/var/run/vlmcsd.pid
ExecStart=/usr/bin/vlmcsd -p /var/run/vlmcsd.pid
Restart=on-failure
[Install]
WantedBy=multi-user.target
'             >            /etc/systemd/system/vlmcsd.service
systemctl     daemon-reload
systemctl     enable       vlmcsd
systemctl     restart      vlmcsd
netstat       -plnt





# 参考文献
# https://www.wenzika.com/357.html
# http://www.kaixinit.com/info/maintenance/3031.html
# WINDOWS密钥https://learn.microsoft.com/zh-cn/windows-server/get-started/kms-client-activation-keys
# OFFICE密钥https://learn.microsoft.com/zh-cn/office/volume-license-activation/gvlks
# https://learn.microsoft.com/zh-cn/office/ltsc/2024/deploy
# configuration.xml can be created from https://config.office.com/deploymentsettings
