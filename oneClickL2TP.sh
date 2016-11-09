#!/bin/bash

wget https://git.io/vpnsetup -O vpnsetup.sh

sudo VPN_IPSEC_PSK='your_ipsec_pre_shared_key' VPN_USER='your_vpn_username' VPN_PASSWORD='your_vpn_password' sh vpnsetup.sh
