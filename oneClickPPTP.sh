#!/bin/bash
echo ---sudo apt-get update---
sudo apt-get update
echo ---sudo apt-get upgrade---
sudo apt-get upgrade
echo ---sudo apt-get install pptpd---
sudo apt-get install pptpd

sudo echo localip 192.168.0.1 >> /etc/pptpd.conf
sudo echo remoteip 192.168.0.100-200 >> /etc/pptpd.conf

sudo echo ms-dns 10.0.0.1 >> /etc/ppp/pptpd-options
sudo echo ms-dns 10.0.0.2 >> /etc/ppp/pptpd-options
sudo echo ms-dns 8.8.8.8 >> /etc/ppp/pptpd-options
sudo echo ms-dns 8.8.4.4 >> /etc/ppp/pptpd-options

user1="test"
password1="123456"
sudo echo "$user1    *    $password1    *" >> /etc/ppp/chap-secrets

/etc/init.d/pptpd restart

# IPv4 forwarding
sudo echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf
sudo sysctl -p
# Use 192.168.0 for its PPTP subnet. The second rule adjusts the MTU size
sudo echo iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth0 -j MASQUERADE >> /etc/rc.local
sudo echo iptables -A FORWARD -p tcp --syn -s 192.168.0.0/24 -j TCPMSS --set-mss 1356 >> /etc/rc.local

#reboot to enable the setting
