site=8.138.172.34
apt        -y      update    
apt        -y      install                        vsftpd net-tools
cat        /etc/vsftpd.conf                 >>    /etc/vsftpd.conf.bak
printf     "\n\n$(date)\n\n\n\n\n\n\n\n"    >>    /etc/vsftpd.conf.bak
sed        -i      '/write_enable=/d'             /etc/vsftpd.conf
sed        -i      '/listen=/d'                   /etc/vsftpd.conf
sed        -i      '/listen_ipv6=/d'              /etc/vsftpd.conf
sed        -i      '/pasv_address=/d'             /etc/vsftpd.conf
echo       "
write_enable=YES
listen=YES
listen_ipv6=NO
pasv_address=$site
"           >>        /etc/vsftpd.conf
useradd     -m        hhj         -d      /home/hhj/
echo        "hhj:fengkuang"       |       chpasswd
systemctl   enable    vsftpd
systemctl   restart   vsftpd
netstat     -plnt




# Ftp服务器安装脚本 @ Debian 10 or Ubuntu 20.04
