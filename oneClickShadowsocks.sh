#!/bin/bash

echo -e "Please setup:\n------\nYour server ip address\nYour server port (default 8080)\nYour local port(default 1080)\nYour password(default 888888)\nYour timeout value(default 600)\nYour encrypt method(default aes-256-cfb)\n------\nbefore you run this script."
exit #Remove this line when values are all setup

server_ip="1.1.1.1" #At lease you need to change this value !
server_port=8080
local_port=1080
password=888888
timeout=600
encrypt_method="aes-256-cfb"


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


echo -e "{\n  \"server\":\"$server_ip\",\n  \"server_port\":$server_port,\n  \"local_port\":$local_port,\n  \"password\":\"$password\",\n  \"timeout\":$timeout,\n  \"method\":\"$encrypt_method\"\n}" > ~/config.json

nohup ssserver -c ~/config.json  > ~/log &

sudo echo /usr/local/bin/ssserver -c ~/config.json >> /etc/rc.local
