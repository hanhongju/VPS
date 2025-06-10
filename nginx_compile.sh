apt      -y      purge nginx
apt              update
apt      -y      install  libpcre3 libpcre3-dev build-essential zlib1g-dev openssl libssl-dev
wget     -c      https://nginx.org/download/nginx-1.28.0.tar.gz
tar      -zxvf   nginx-1.28.0.tar.gz
cd               nginx-1.28.0
./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf \
            --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log \
            --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp \
            --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
            --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
            --user=www --group=www --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module \
            --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module \
            --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module \
            --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module \
            --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module \
            --with-stream_ssl_module --with-stream_ssl_preread_module
make
make install
useradd  www
mkdir    -p   /var/cache/nginx/client_temp
mkdir    -p   /etc/nginx/modules-enabled/
sed      -i                "/modules-enabled/d"                  /etc/nginx/nginx.conf
echo     'include /etc/nginx/modules-enabled/*.conf;    '   >>   /etc/nginx/nginx.conf
echo '
stream {
    server {
        listen 8443;
        proxy_pass alihk.hanhongju.com:443;
    }
}
'   >   /etc/nginx/modules-enabled/stream.conf
nginx         -t
systemctl     restart      nginx
netstat       -plnt




# nginx编译安装，带stream模块
# 参考文献https://cloud.tencent.com/developer/article/1834769

