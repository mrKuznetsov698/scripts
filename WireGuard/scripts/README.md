# Install WireGuard VPN with web ui
## * All scripts from [subspacecommunity/subspace](https://github.com/subspacecommunity/subspace) *
## * I use this for quick install subspace *

For install:
```bash
sudo apt update && sudo apt install wget
wget https://github.com/mrKuznetsov698/scripts/raw/main/WireGuard/scripts/initial_setup.sh
wget https://github.com/mrKuznetsov698/scripts/raw/main/WireGuard/scripts/start.sh
chmod +x initial_setup.sh
chmod +x start.sh
# You need domain with A record: subspace.example.com
HTTP_HOST="YOUR HTTP HOST WITH SUBDOMAIN: subspace"
sudo ./initial_setup.sh
sudo ./start.sh
```
