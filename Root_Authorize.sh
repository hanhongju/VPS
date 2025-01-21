echo          "root:fengkuang"     |     chpasswd
sed           -i          "/PermitRootLogin*/d"                 /etc/ssh/sshd_config
sed           -i          "/PasswordAuthentication*/d"          /etc/ssh/sshd_config
echo    '
PermitRootLogin yes
PasswordAuthentication yes
'       >     /etc/ssh/sshd_config.d/convenient.conf
systemctl     restart     sshd




installpubkey () {
mkdir         /root/.ssh/
echo    '
ssh-ed25519   AAAAC3NzaC1lZDI1NTE5AAAAII645EjCCRKn2xs9mpL2HiiLAQYKHOA+nyESQ0qf3VBR
'       >     /root/.ssh/authorized_keys
systemctl     restart     sshd

}




privatekey () {
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACCOuORIwgkSp9sbPZqS9h4oiwEGChzgPp8hEkNKn91QUQAAAJjKfYlMyn2J
TAAAAAtzc2gtZWQyNTUxOQAAACCOuORIwgkSp9sbPZqS9h4oiwEGChzgPp8hEkNKn91QUQ
AAAEBDHycSYAJSY4vLoINg9KdbGLK2FDEuNd160t/i2zGWDI645EjCCRKn2xs9mpL2HiiL
AQYKHOA+nyESQ0qf3VBRAAAAFHJvb3RAYWxpeXVuZ3Vhbmd6aG91AQ==
-----END OPENSSH PRIVATE KEY-----

}





# 更改root密码，安装公钥，开启ROOT密码登录
# 添加多个公钥必须在authorized_keys中另加一行
