# PPTP setup
It still has some bugs to fix

# Shadowsocks setup
Tested on Linode, Ubuntu 16.04 LTS.
* How to use
```bash
git clone https://github.com/BianXinda/xinda_scripts.git
```
You need to modify the script with your server address, and remove exit line. Then run the script:
```bash
bash oneClickShadowsocks.sh
```
* Possible problems and solutions
If you stuck when run apt-get update as below:
```
Connecting to security.ubuntu.com (2001:67c:1562::16)
```
Open /etc/gai.conf, then uncomment below line:
```
precedence ::ffff:0:0/96 100
```
This will allow you to still use IPv6 but sets IPv4 as the precedence so that apt-get won’t get stuck.
Thanks to [solution](https://zach-adams.com/2015/01/apt-get-cant-connect-to-security-ubuntu-fix/) this guy provided.
