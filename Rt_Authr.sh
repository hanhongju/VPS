echo    "root:fengkuang"   |   chpasswd
mkdir   --parents     /root/.ssh/
sed     -i    "/PermitRootLogin/d"             /etc/ssh/sshd_config
sed     -i    "/PasswordAuthentication/d"      /etc/ssh/sshd_config
echo    'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII645EjCCRKn2xs9mpL2HiiLAQYKHOA+nyESQ0qf3VBR'       >     /root/.ssh/authorized_keys
echo    '
PermitRootLogin yes
PasswordAuthentication yes
'       >>    /etc/ssh/sshd_config
systemctl     restart     sshd




# 更改root密码，开启密码登录 @ all systems
