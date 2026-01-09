# apt -y update && DEBIAN_FRONTEND=noninteractive apt-get -y full-upgrade && apt -y autoremove
apt     -y    update
apt     -y    install       wget curl zip unzip nginx net-tools mariadb-server python3-pip
apt     -y    install       php-fpm php-mysql php-xml php-curl php-imagick php-mbstring php-zip php-gd php-intl
echo    '
0 1 * * *     apt    -y     update
0 2 * * *     apt    -y     full-upgrade
0 3 * * *     apt    -y     autoremove
0 4 * * *     mysqldump     -uroot         -pfengkuang     wordpress       >        /srv/wordpress/wordpress.sql
0 5 * * *     mkdir         -p             /root/wordpressbackup/
0 6 * * *     tar           --file         /root/wordpressbackup/$(date +\%Y-\%m-\%d)-wordpress.tar      --directory     /srv/     --create    ./wordpress/
0 7 * * *     certbot       renew
0 * * * *     pkill         tcrond
'       |     crontab
echo '
server {
listen 80;
listen [::]:80;
root      /srv/wordpress/;
index     index.php index.html index.htm;
location ~ \.php$ {
fastcgi_pass   unix:/run/php/php8.2-fpm.sock;     #遇到502 Bad Gateway时使用php -v查看版本，确认php-fpm.sock版本为8.2
fastcgi_index  index.php;
fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
include        fastcgi_params;
}
location / {
if (-f  $request_filename/index.html) {rewrite (.*) $1/index.html break;}
if (-f  $request_filename/index.php)  {rewrite (.*) $1/index.php;}
if (!-f $request_filename)            {rewrite (.*)   /index.php;}
}
rewrite /wp-admin$ $scheme://$host$uri/ permanent;
}
'            >            /etc/nginx/sites-enabled/default
sed          -i           "/post_max_size/d"                   /etc/php/8.2/fpm/php.ini
sed          -i           "/upload_max_filesize/d"             /etc/php/8.2/fpm/php.ini
sed          -i           "/memory_limit/d"                    /etc/php/8.2/fpm/php.ini
sed          -i           "/max_execution_time/d"              /etc/php/8.2/fpm/php.ini
echo         "
upload_max_filesize   = 0
post_max_size         = 0
memory_limit          = 0
max_execution_time    = 0
"             >>           /etc/php/8.2/fpm/php.ini
echo          "
client_header_buffer_size      2048k;
large_client_header_buffers 10 2048k;
client_max_body_size           500M;
"             >            /etc/nginx/conf.d/http_params.conf
systemctl     enable       nginx php8.2-fpm
systemctl     restart      nginx php8.2-fpm
nginx         -t
sysctl        -p
crontab       -l
netstat       -plnt
mysql_secure_installation




setupLNMP () {
apt     -y    install    wget
wget    https://raw.githubusercontent.com/hanhongju/VPS/refs/heads/main/wordpress.sh    -O    setup.sh
bash    setup.sh

}




directbackup () {
mysqldump     -uroot         -pfengkuang     wordpress       >        /srv/wordpress/wordpress.sql
tar           --file         /root/wordpress.tar      --directory     /srv/     --create    ./wordpress/

}




importbackup () {
tar           --file         /root/wordpress.tar     --directory      /srv/     --extract
mysql         -uroot         -pfengkuang     -e      "update mysql.user set plugin='mysql_native_password' where User='root'"
mysql         -uroot         -pfengkuang     -e      "DROP DATABASE wordpress"
mysql         -uroot         -pfengkuang     -e      "CREATE DATABASE wordpress"
mysql         -uroot         -pfengkuang     -e      "SHOW DATABASEs"
systemctl     enable         mariadb
systemctl     restart        mariadb
mysql         -uroot         -pfengkuang     wordpress   <    /srv/wordpress/wordpress.sql

}




installanewsite () {
wget          -c             https://cn.wordpress.org/latest-zh_CN.tar.gz
rm            -rf            /srv/wordpress/
tar           --file         latest-zh_CN.tar.gz     --directory      /srv/     --extract
# 网页文件授权，否则会出现无法创建wp配置文件或无法安装主题的问题
chmod         --recursive    777            /srv/wordpress/
chown         --recursive    www-data       /srv/wordpress/

}




reverse_proxy_host () {
apt    -y    update
apt    -y    install      nginx net-tools
rm     -f    /etc/nginx/sites-enabled/default
echo         '
server{
server_name     www.hanhongju.com;
resolver        8.8.8.8;
set $proxy_name 8.138.172.34:80;
listen 80;
listen [::]:80;
location /          {
proxy_pass       http://$proxy_name;
proxy_set_header Host   $proxy_name:$server_port;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header Referer $http_referer;
proxy_set_header Accept-Encoding "";
}
}
'           >           /etc/nginx/sites-enabled/www
systemctl   enable      nginx
systemctl   restart     nginx
nginx       -t
netstat     -plnt

}




# Wordpress安装脚本 @ Debian 11
# cron任务须由crontab安装，直接修改配置文件无效
# wget的-O参数和-cP参数只能二选一
