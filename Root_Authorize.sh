echo          "root:fengkuang" | chpasswd
sed           -i          "/PermitRootLogin*/d"                 /etc/ssh/sshd_config
sed           -i          "/PasswordAuthentication*/d"          /etc/ssh/sshd_config
echo    '
PermitRootLogin yes
PasswordAuthentication yes
'       >     /etc/ssh/sshd_config.d/convenient.conf
mkdir         /root/.ssh/
echo    '
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII645EjCCRKn2xs9mpL2HiiLAQYKHOA+nyESQ0qf3VBR
'       >     /root/.ssh/authorized_keys
systemctl     restart     sshd





# 更改root密码，安装公钥，开启ROOT密码登录
# 添加多个公钥必须在authorized_keys中另加一行
