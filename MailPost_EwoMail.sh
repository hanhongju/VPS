site=hanhongju.com
sed       -i       "s/SELINUX=.*/SELINUX=disabled/g"        /etc/sysconfig/selinux
if        [[   $(free  -m  |  awk   'NR==3{print $2}'   2>&1)    >   3000   ]]
then      echo     "已经有SWAP，无需重复配置"
else      echo     "添加SWAP空间，大小4000M"
          dd       if=/dev/zero of=/swap.img bs=1M count=4000
          mkswap   /swap.img
          swapon   /swap.img
          echo    '/swap.img  none  swap  defaults  0  0'  >>  /etc/fstab
fi
yum         -y          install        wget net-tools
wget        -c          https://github.com/hanhongju/VPS/raw/refs/heads/main/ewomail-1.15.1b.tar.gz
tar         -zxvf       ewomail-1.15.1b.tar.gz
cd          /root/ewomail/install/
sed         -i          "s/yum install epel-release.*/yum install epel-release -y/g"         start.sh
bash        start.sh    $site
echo        "127.0.0.1 mail.$site smtp.$site imap.$site"       >>       /etc/hosts
sed         -i          "s/listen.*/listen 80;/g"              /ewomail/nginx/conf/vhost/rainloop.conf
sed         -i          "s/listen.*/listen 8010;/g"            /ewomail/nginx/conf/vhost/ewomail-admin.conf
sed         -i          "/clamd/d"                             /usr/lib/systemd/system/amavisd.service
sed         -i          "/bypass_virus/d"                      /etc/amavisd/amavisd.conf
sed         -i          "/bypass_spam/d"                       /etc/amavisd/amavisd.conf
echo        "
@bypass_virus_checks_maps = (1);
@bypass_spam_checks_maps  = (1);   "                           >>       /etc/amavisd/amavisd.conf
systemctl   daemon-reload
systemctl   stop        clamd@amavisd
systemctl   disable     clamd@amavisd
systemctl   restart     postfix dovecot nginx amavisd
netstat     -plnt




directsetup () {
yum     -y    install    wget
wget    https://raw.githubusercontent.com/hanhongju/my_script/master/MailPost_EwoMail.sh    -O    setup.sh
bash    setup.sh

}




configure_repo_in_centos7 () {
rm   -f   /etc/yum.repos.d/*
echo  '
[base]
name=CentOS-$releasever - Base
baseurl=https://vault.centos.org/7.9.2009/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=1
[updates]
name=CentOS-$releasever - Updates
baseurl=https://vault.centos.org/7.9.2009/updates/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=1
[extras]
name=CentOS-$releasever - Extras
baseurl=https://vault.centos.org/7.9.2009/extras/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=1
[centosplus]
name=CentOS-$releasever - CentOSPlus
baseurl=https://vault.centos.org/7.9.2009/centosplus/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=0
'   >    /etc/yum.repos.d/CentOS-Base.repo

}




# EwoMail 安装脚本 @ CentOS 7
# 后台管理端口为8010，账户为admin，密码为ewomail123
