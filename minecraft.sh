apt      -y      install      wget default-jdk
wget     -c      https://piston-data.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar     -P     /root/mcserverjava/
echo     'eula=true'      >       /root/mcserverjava/eula.txt
echo     ' 
[Unit]
Description=Minecraft server
[Service]
Type=simple
WorkingDirectory=/root/mcserverjava/
ExecStart=java     -jar    /root/mcserverjava/server.jar     nogui
Restart=on-failure
[Install]
WantedBy=multi-user.target
'             >            /etc/systemd/system/mcserver.service
systemctl     daemon-reload
systemctl     enable       mcserver
systemctl     restart      mcserver




#备份服务器
tar           --create       --file          /root/mcjava.tar     --directory    /root/    ./mcserverjava/
#还原服务器
tar           --extract      --file          /root/mcjava.tar     --directory    /root/




# MineCraft JAVA版服务器搭建脚本 @ Debian
# 官网下载地址
# https://www.minecraft.net/zh-hans/download/server
