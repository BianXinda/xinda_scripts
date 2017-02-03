#!/bin/bash

cat <<EOF
Please setup:
Your server ip address
Your server port (default 8888)
Your local port(default 1080)
Your password(default 888888)
Your timeout value(default 600)
Your encrypt method(default aes-256-cfb)

before you run this script.
EOF

exit #Remove this line when values are all setup

server_ip="" #At lease you need to change this value !
server_port=8888
local_port=1080
password=888888
timeout=600
encrypt_method="aes-256-cfb"

sudo sed -i "s/#precedence ::ffff:0:0\/96  100/precedence ::ffff:0:0\/96i  100/g" /etc/gai.conf

echo ---sudo apt-get update---
sudo apt-get update
echo ---sudo apt-get upgrade---
sudo apt-get upgrade
echo ---sudo apt-get install python-gevent---
sudo apt-get install python-gevent
echo ---sudo apt-get install python-pip---
sudo apt-get install python-pip
echo ---sudo pip install shadowsocks---
export LC_ALL=C # To avoid pip install locale error
sudo pip install shadowsocks
echo ---sudo apt-get install python-m2crypto---
sudo apt-get install python-m2crypto


cat >> ~/config.json <<EOF
{  
    "server":"$server_ip",
    "server_port":$server_port,
    "local_port":$local_port,
    "password":"$password",
    "timeout":$timeout,
    "method":"$encrypt_method"
}
EOF

sudo nohup ssserver -c ~/config.json  > ~/log &

sudo echo /usr/local/bin/ssserver -c ~/config.json >> /etc/rc.local
