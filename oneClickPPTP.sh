#!/bin/bash

sudo sed -i "s/#precedence ::ffff:0:0\/96  100/precedence ::ffff:0:0\/96i  100/g" /etc/gai.conf

echo ---sudo apt-get update---
sudo apt-get update
echo ---sudo apt-get upgrade---
sudo apt-get upgrade
echo ---sudo apt-get install pptpd---
sudo apt-get install pptpd

cat >> /etc/pptpd.conf <<EOF
localip 192.168.0.1
remoteip 192.168.0.100-200
EOF

cat >> /etc/ppp/pptpd-options <<EOF
ms-dns 8.8.8.8
ms-dns 8.8.4.4
EOF

user1="test"
password1="123456"
sudo echo "$user1 pptpd $password1 *" >> /etc/ppp/chap-secrets

sudo /etc/init.d/pptpd restart

# IPv4 forwarding
sudo sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g"  /etc/sysctl.conf
sudo sed -i "s/net.ipv4.ip_forward=0/net.ipv4.ip_forward=1/g"  /etc/sysctl.conf
sudo sysctl -p

# Use 192.168.0 for its PPTP subnet. The second rule adjusts the MTU size
sudo iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -p tcp --syn -s 192.168.0.0/24 -j TCPMSS --set-mss 1356

sudo sed "s/exit 0//g" /etc/rc.local
cat >> /etc/rc.local <<EOF
iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth0 -j MASQUERADE
iptables -A FORWARD -p tcp --syn -s 192.168.0.0/24 -j TCPMSS --set-mss 1356
/etc/init.d/pptpd restart
EOF

#reboot to enable the setting
