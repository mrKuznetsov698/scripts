# Install WireGuard-VPN with web UI
For install VPN run this commands:
> sudo apt update
> sudo apt install wget
> wget https://raw.githubusercontent.com/mrKuznetsov698/scripts/main/WireGuard/scripts/initial_setup.sh
> wget https://raw.githubusercontent.com/mrKuznetsov698/scripts/main/WireGuard/scripts/start.sh
> chmod +x initial_setup.sh
> chmod +x start.sh
You need the domain name with A - record
> subspace.example.com
Then change start.sh file
> docker create \
>    --name subspace \
>    --restart always \
>    --network host \
>    --cap-add NET_ADMIN \
>    --volume /data:/data \
>    --env SUBSPACE_HTTP_HOST="[PAST HERE YOUR DOMAIN NAME WITH SUBDOMAIN subspace]" \
>    --env SUBSPACE_NAMESERVERS="1.1.1.1,8.8.8.8" \
>    --env SUBSPACE_LISTENPORT="51820" \
>    --env SUBSPACE_IPV4_POOL="10.99.97.0/24" \
>    --env SUBSPACE_IPV6_POOL="fd00::10:97:0/64" \
>    --env SUBSPACE_IPV4_GW="10.99.97.1" \
>    --env SUBSPACE_IPV6_GW="fd00::10:97:1" \
>    --env SUBSPACE_IPV6_NAT_ENABLED=1 \
>    --env SUBSPACE_DISABLE_DNS=0 \
>    --env SUBSPACE_PERSISTENT_KEEPALIVE=20 \
>    subspacecommunity/subspace:latest