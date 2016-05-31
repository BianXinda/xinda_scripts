Tested on Linode@Fremont, Ubuntu 16.04 LTS. Please first get the script:
```bash
git clone https://github.com/BianXinda/xinda_scripts.git
```
# PPTP setup
* How to use
You can add extra user and password to /etc/ppp/chap-secrets as format in the script. Then:
```bash
bash oneClickShadowsocks.sh
```

# Shadowsocks setup
* How to use
```bash
bash oneClickShadowsocks.sh
```
You will see below:
```
Please setup:
Your server ip address
Your server port (default 8080)
Your local port(default 1080)
Your password(default 888888)
Your timeout value(default 600)
Your encrypt method(default aes-256-cfb)

before you run this script.
```
Then you need to modify the script with your server address, and remove the exit statement in the script. Then re-run the script.

* FAQ
Stuck when apt-get update:
Please refer to [solution](https://zach-adams.com/2015/01/apt-get-cant-connect-to-security-ubuntu-fix/) this guy provided. Thanks to him!
