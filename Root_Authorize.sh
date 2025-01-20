mkdir         /root/.ssh/
echo    '
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII645EjCCRKn2xs9mpL2HiiLAQYKHOA+nyESQ0qf3VBR
'       >     /root/.ssh/authorized_keys
sed           -i          "s/PermitRootLogin .*/PermitRootLogin yes/g"                        /etc/ssh/sshd_config
sed           -i          "s/PasswordAuthentication .*/PasswordAuthentication yes/g"          /etc/ssh/sshd_config
systemctl     restart     sshd





# 安装公钥，开启ROOT密码登录
# 添加多个公钥必须在authorized_keys中另加一行
