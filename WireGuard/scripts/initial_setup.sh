#!/bin/bash

# ----- Settings -----
apt-get update
apt-get install -y wireguard

# Remove dnsmasq because it will run inside the container.
apt-get remove -y dnsmasq

# Disable systemd-resolved listener if it blocks port 53.
echo "DNSStubListener=no" >> /etc/systemd/resolved.conf
systemctl restart systemd-resolved

# Set Cloudfare DNS server.
echo nameserver 1.1.1.1 > /etc/resolv.conf
echo nameserver 1.0.0.1 >> /etc/resolv.conf

# Load modules.
modprobe wireguard
modprobe iptable_nat
modprobe ip6table_nat

# Enable modules when rebooting.
echo "wireguard" > /etc/modules-load.d/wireguard.conf
echo "iptable_nat" > /etc/modules-load.d/iptable_nat.conf
echo "ip6table_nat" > /etc/modules-load.d/ip6table_nat.conf

# Check if systemd-modules-load service is active.
systemctl status systemd-modules-load.service

# Enable IP forwarding.
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=1

# ----- Set up Docker -----
apt-get update
apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
