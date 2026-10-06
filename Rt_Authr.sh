echo    "root:fengkuang"   |   chpasswd
mkdir   -p    /root/.ssh/
sed     -i    "/PermitRootLogin/d"             /etc/ssh/sshd_config
sed     -i    "/PasswordAuthentication/d"      /etc/ssh/sshd_config
echo    '
PermitRootLogin yes
PasswordAuthentication yes
'       >>    /etc/ssh/sshd_config
echo    'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII645EjCCRKn2xs9mpL2HiiLAQYKHOA+nyESQ0qf3VBR'       >     /root/.ssh/authorized_keys
systemctl     restart     sshd

# 阻止阿里安全软件运行
ps        aux |  grep Ali
apt       -y     install psmisc
killall   -9     AliYunDun AliYunDunUpdate AliYunDunMonitor AliSecCheck
rm        -rf    /usr/local/aegis/




# 更改root密码，开启密码登录
