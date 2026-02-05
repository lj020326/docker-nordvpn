
# Testing nordvpn container setup

```shell
root@media02:[docker]$ docker compose --file=docker-compose.yml up --detach
root@media02:[docker]$ docker network create --scope=local --attachable --subnet=192.168.12.0/24 traefik_public
root@media02:[docker]$ docker network create --scope=local --attachable --subnet=192.168.13.0/24 vpn
root@media02:[docker]$ docker-compose logs openvpn
root@media02:[docker]$ docker-compose logs openvpn
openvpn  | /package/admin/s6-overlay/libexec/preinit: info: container permissions: uid=0 (root), euid=0, gid=0 (root), egid=0
openvpn  | /package/admin/s6-overlay/libexec/preinit: info: /run permissions: uid=0 (root), gid=0 (root), perms=oxorgxgruxuwur
openvpn  | s6-rc: info: service s6rc-oneshot-runner: starting
openvpn  | s6-rc: info: service s6rc-oneshot-runner successfully started
openvpn  | s6-rc: info: service fix-attrs: starting
openvpn  | s6-rc: info: service init-environment: starting
openvpn  | s6-rc: info: service init-adduser: starting
openvpn  | s6-rc: info: service fix-attrs successfully started
openvpn  | s6-rc: info: service legacy-cont-init: starting
openvpn  | s6-rc: info: service legacy-cont-init successfully started
openvpn  | [INFO] run=>main() Initializing shared container environment
openvpn  | [INFO] run=>main() Starting user initialization
openvpn  | [INFO] run=>main() User initialization completed
openvpn  | s6-rc: info: service init-adduser successfully started
openvpn  | [INFO] init-environment=>main() Initializing environment
openvpn  | [INFO] backend-functions=>main:pick_ipv4_backend() Kernel: 6.8.0-90-generic
openvpn  | [INFO] backend-functions=>main:pick_ipv4_backend() Using iptables backend: iptables
openvpn  | [INFO] backend-functions=>main:pick_ipv6_backend() Using ip6tables backend: ip6tables
openvpn  | [INFO] init-environment=>main() Wrote IPT=iptables to s6 container environment at /var/run/s6/container_environment
openvpn  | [INFO] init-environment=>main() Using IPv4 backend: iptables
openvpn  | [INFO] init-environment=>main() Shared environment written (/var/run/s6/container_environment)
openvpn  | [INFO] run=>main() Shared backend container environment configured successfully
openvpn  | s6-rc: info: service init-environment successfully started
openvpn  | s6-rc: info: service init-metadata: starting
openvpn  | s6-rc: info: service init-createauth: starting
openvpn  | [INFO] run=>main() Refreshing NordVPN API definitions...
openvpn  | [INFO] run=>main() Refresh metadata complete.
openvpn  | s6-rc: info: service init-metadata successfully started
openvpn  | [INFO] run=>main() Starting authentication setup
openvpn  | s6-rc: info: service init-firewall: starting
openvpn  | [INFO] run=>main() Creating VPN authentication file
openvpn  | [INFO] run=>main() Authentication setup completed
openvpn  | s6-rc: info: service init-createauth successfully started
openvpn  | [INFO] run=>main() Initializing firewall
openvpn  | [INFO] init-firewall=>main() Starting firewall initialization
openvpn  | [INFO] init-firewall=>main() Using API IP: 104.16.208.203 104.19.159.190 for bootstrap rules
openvpn  | [INFO] init-firewall=>main() If we chose legacy for a family, clear any existing nft rules
openvpn  | [INFO] init-firewall=>main() Applying security rules - all traffic blocked by default
openvpn  | [INFO] init-firewall=>main() Set default DROP policies
openvpn  | [INFO] init-firewall=>main() Flush existing rules and delete custom chains
openvpn  | [INFO] init-firewall=>main() Allow loopback (critical for internal plumbing)
openvpn  | [INFO] init-firewall=>main() Allow DNS for resolution
openvpn  | [INFO] init-firewall=>main() Allow HTTPS for API calls
openvpn  | [INFO] init-firewall=>main() Allowing NordVPN API access for IPs: 104.16.208.203 104.19.159.190
openvpn  | [INFO] init-firewall=>main() Run API connection tests for IPs: 104.16.208.203;104.19.159.190
openvpn  | [SUCCESS] api-connection-tests=>main:run_ping_test() ICMP to API IP successful
openvpn  | [SUCCESS] api-connection-tests=>main:run_curl_ip_test() Direct IP Connectivity successful
openvpn  | [SUCCESS] api-connection-tests=>main:run_curl_host_test() Direct IP Connectivity successful
openvpn  | [SUCCESS] api-connection-tests=>main:run_ping_test() ICMP to API IP successful
openvpn  | [SUCCESS] api-connection-tests=>main:run_curl_ip_test() Direct IP Connectivity successful
openvpn  | [SUCCESS] api-connection-tests=>main:run_curl_host_test() Direct IP Connectivity successful
openvpn  | [INFO] api-connection-tests=>main() API Connection tests completed
openvpn  | [INFO] init-firewall=>main() Allowing access to custom networks: 192.168.13.0/24 192.168.12.0/24
openvpn  | [INFO] init-firewall=>main() Allowing access to custom network: 192.168.13.0/24
openvpn  | [INFO] init-firewall=>main() Adding route to custom network [192.168.13.0/24] gateway: 192.168.12.1
openvpn  | [INFO] init-firewall=>main() Allowing access to custom network: 192.168.12.0/24
openvpn  | [INFO] init-firewall=>main() Adding route to custom network [192.168.12.0/24] gateway: 192.168.12.1
openvpn  | [INFO] init-firewall=>main() Configuring firewall to route all traffic through VPN
openvpn  | [INFO] init-firewall=>main() Firewall initialization complete
openvpn  | [INFO] run=>main() Firewall initialization completed
openvpn  | s6-rc: info: service init-firewall successfully started
openvpn  | s6-rc: info: service init-vpn-config: starting
openvpn  | s6-rc: info: service init-setupcron: starting
openvpn  | [INFO] run=>main() Initialize NordVPN service configuration
openvpn  | [INFO] run=>main() Starting cron configuration
openvpn  | [INFO] init-vpn-config=>main() Starting VPN configuration
openvpn  | [INFO] init-vpn-config=>main() Run API connection tests for IPs: 104.16.208.203;104.19.159.190
openvpn  | [INFO] run=>main() VPN recreation cron: 5 */3 * * * (minute 5 at every 3 hours)
openvpn  | [INFO] run=>main() Health check cron: */5 * * * * (every 5 minutes)
openvpn  | [INFO] run=>main() Cron configuration completed
openvpn  | s6-rc: info: service init-setupcron successfully started
openvpn  | s6-rc: info: service svc-cron: starting
openvpn  | s6-rc: info: service svc-cron successfully started
openvpn  | [INFO] run=>main() Starting cron service
openvpn  | [SUCCESS] api-connection-tests=>main:run_ping_test() ICMP to API IP successful
openvpn  | [SUCCESS] api-connection-tests=>main:run_curl_ip_test() Direct IP Connectivity successful
openvpn  | [SUCCESS] api-connection-tests=>main:run_curl_host_test() Direct IP Connectivity successful
openvpn  | [SUCCESS] api-connection-tests=>main:run_ping_test() ICMP to API IP successful
openvpn  | [SUCCESS] api-connection-tests=>main:run_curl_ip_test() Direct IP Connectivity successful
openvpn  | [SUCCESS] api-connection-tests=>main:run_curl_host_test() Direct IP Connectivity successful
openvpn  | [INFO] api-connection-tests=>main() API Connection tests completed
openvpn  | [INFO] init-vpn-config=>main() S_COUNTRIES=CA
openvpn  | [INFO] init-vpn-config=>main() S_GROUP=11
openvpn  | [INFO] init-vpn-config=>main() S_CITIES=Toronto;Montreal
openvpn  | [INFO] init-vpn-config=>main() S_TOP=10
openvpn  | [INFO] init-vpn-config=>main() S_TECH=openvpn_udp
openvpn  | [INFO] init-vpn-config=>main() S_SERVER_ID=
openvpn  | [INFO] init-vpn-config=>main() Derived Protocol: udp, Port: 1194 from Technology: openvpn_udp
openvpn  | [INFO] init-vpn-config=>main() OVPN_TEMPLATE_FILE: /usr/local/share/nordvpn/data/template.ovpn
openvpn  | [INFO] init-vpn-config=>main() OVPN_FILE: /run/xt/nordvpn.ovpn
openvpn  | [INFO] init-vpn-config=>main() Fetching recommendations for Country:38, Group:11, Tech:3
openvpn  | [INFO] init-vpn-config=>main() Selected: Canada #1668 (ca1668.nordvpn.com) at 62.3.36.122 (Load: 15%)
openvpn  | [INFO] init-vpn-config=>main() Writing OVPN config to /run/xt/nordvpn.ovpn
openvpn  | [INFO] init-vpn-config=>main() Configuring VPN settings (IP: 62.3.36.122, PORT: 1194, Protocol: udp)
openvpn  | [INFO] init-vpn-config=>main() VPN configuration completed
openvpn  | [INFO] run=>main() NordVPN configuration completed
openvpn  | s6-rc: info: service init-vpn-config successfully started
openvpn  | s6-rc: info: service svc-nordvpn: starting
openvpn  | s6-rc: info: service svc-nordvpn successfully started
openvpn  | s6-rc: info: service legacy-services: starting
openvpn  | s6-rc: info: service legacy-services successfully started
openvpn  | [INFO] run=>main() Run the motd
openvpn  | ==================================================================================
openvpn  | 🚀 NordVPN OpenVPN Docker Container
openvpn  | ==================================================================================
openvpn  | 📋 Description: Docker container for NordVPN with OpenVPN and advanced networking
openvpn  | 👤 Author: Lee Johnson <ljohnson@dettonville.com>
openvpn  | 🔗 Repository: https://github.com/lj020326/nordvpn
openvpn  | 📚 Documentation: https://github.com/lj020326/nordvpn#readme
openvpn  | 🏷  Image Version: eb172cbb0355242461880c9cc835e8ceeb954cc4
openvpn  | 🏷  Build ID: build-27
openvpn  | 📅 Build Date: 20260205
openvpn  | 📅 NordVPN API IP: 104.16.208.203;104.19.159.190
openvpn  | 🏷  OpenVPN Version: OpenVPN 2.6.16 x86_64-alpine-linux-musl [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD]
openvpn  | ==================================================================================
openvpn  | [INFO] run=>main() Starting NordVPN service - 2026-02-05 17:27:12
openvpn  | [INFO] run=>main() Adding default --data-ciphers
openvpn  | [INFO] run=>main() Launching OpenVPN
openvpn  | [INFO] run=>main() Waiting for VPN connection...
openvpn  | 2026-02-05 17:27:12 OpenVPN 2.6.16 x86_64-alpine-linux-musl [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD]
openvpn  | 2026-02-05 17:27:12 library versions: OpenSSL 3.5.5 27 Jan 2026, LZO 2.10
openvpn  | 2026-02-05 17:27:12 MANAGEMENT: unix domain socket listening on /run/xt/openvpn-mgmt.sock
openvpn  | 2026-02-05 17:27:12 NOTE: the current --script-security setting may allow this configuration to call user-defined scripts
openvpn  | 2026-02-05 17:27:12 TCP/UDP: Preserving recently used remote address: [AF_INET]62.3.36.122:1194
openvpn  | 2026-02-05 17:27:12 Socket Buffers: R=[212992->212992] S=[212992->212992]
openvpn  | 2026-02-05 17:27:12 UDPv4 link local: (not bound)
openvpn  | 2026-02-05 17:27:12 UDPv4 link remote: [AF_INET]62.3.36.122:1194
openvpn  | 2026-02-05 17:27:12 NOTE: UID/GID downgrade will be delayed because of --client, --pull, or --up-delay
openvpn  | 2026-02-05 17:27:12 TLS: Initial packet from [AF_INET]62.3.36.122:1194, sid=a4af15cd 9183e684
openvpn  | 2026-02-05 17:27:12 VERIFY OK: depth=2, C=PA, O=NordVPN, CN=NordVPN Root CA
openvpn  | 2026-02-05 17:27:12 VERIFY OK: depth=1, O=NordVPN, CN=NordVPN CA11
openvpn  | 2026-02-05 17:27:12 VERIFY KU OK
openvpn  | 2026-02-05 17:27:12 Validating certificate extended key usage
openvpn  | 2026-02-05 17:27:12 ++ Certificate has EKU (str) TLS Web Server Authentication, expects TLS Web Server Authentication
openvpn  | 2026-02-05 17:27:12 VERIFY EKU OK
openvpn  | 2026-02-05 17:27:12 VERIFY X509NAME OK: CN=ca1668.nordvpn.com
openvpn  | 2026-02-05 17:27:12 VERIFY OK: depth=0, CN=ca1668.nordvpn.com
openvpn  | 2026-02-05 17:27:12 Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 4096 bits RSA, signature: RSA-SHA512, peer temporary key: 253 bits X25519
openvpn  | 2026-02-05 17:27:12 [ca1668.nordvpn.com] Peer Connection Initiated with [AF_INET]62.3.36.122:1194
openvpn  | 2026-02-05 17:27:12 TLS: move_session: dest=TM_ACTIVE src=TM_INITIAL reinit_src=1
openvpn  | 2026-02-05 17:27:12 TLS: tls_multi_process: initial untrusted session promoted to trusted
openvpn  | 2026-02-05 17:27:13 SENT CONTROL [ca1668.nordvpn.com]: 'PUSH_REQUEST' (status=1)
openvpn  | 2026-02-05 17:27:13 PUSH: Received control message: 'PUSH_REPLY,redirect-gateway def1,dhcp-option DNS 103.86.96.100,dhcp-option DNS 103.86.99.100,explicit-exit-notify,comp-lzo no,route-gateway 10.100.0.1,topology subnet,ping 60,ping-restart 180,ifconfig 10.100.0.2 255.255.0.0,peer-id 23,cipher AES-256-GCM'
openvpn  | 2026-02-05 17:27:13 OPTIONS IMPORT: --ifconfig/up options modified
openvpn  | 2026-02-05 17:27:13 OPTIONS IMPORT: route options modified
openvpn  | 2026-02-05 17:27:13 OPTIONS IMPORT: route-related options modified
openvpn  | 2026-02-05 17:27:13 OPTIONS IMPORT: --ip-win32 and/or --dhcp-option options modified
openvpn  | 2026-02-05 17:27:13 ROUTE_GATEWAY 192.168.12.1/255.255.255.0 IFACE=eth1 HWADDR=16:20:f2:07:d7:2f
openvpn  | 2026-02-05 17:27:13 TUN/TAP device tun0 opened
openvpn  | 2026-02-05 17:27:13 /sbin/ip link set dev tun0 up mtu 1500
openvpn  | 2026-02-05 17:27:13 /sbin/ip link set dev tun0 up
openvpn  | 2026-02-05 17:27:13 /sbin/ip addr add dev tun0 10.100.0.2/16 broadcast +
openvpn  | 2026-02-05 17:27:13 /etc/openvpn/up.sh tun0 1500 0 10.100.0.2 255.255.0.0 init
openvpn  | 2026-02-05 17:27:13 /sbin/ip route add 62.3.36.122/32 via 192.168.12.1
openvpn  | 2026-02-05 17:27:13 /sbin/ip route add 0.0.0.0/1 via 10.100.0.1
openvpn  | 2026-02-05 17:27:13 /sbin/ip route add 128.0.0.0/1 via 10.100.0.1
openvpn  | 2026-02-05 17:27:13 GID set to nordvpn
openvpn  | 2026-02-05 17:27:13 Initialization Sequence Completed
openvpn  | 2026-02-05 17:27:13 Data Channel: cipher 'AES-256-GCM', peer-id: 23, compression: 'stub'
openvpn  | 2026-02-05 17:27:13 Timers: ping 60, ping-restart 180
openvpn  | 2026-02-05 17:27:13 Protocol options: explicit-exit-notify 1
openvpn  | [INFO] run=>main() VPN connection established successfully
openvpn  | [INFO] run=>main() Monitoring OpenVPN process (PID: 536)
root@media02:[docker]$ 
root@media02:[docker]$ docker-compose ps
NAME              IMAGE                                          COMMAND                  SERVICE           CREATED          STATUS          PORTS
dozzle            amir20/dozzle:latest                           "/dozzle"                dozzle            13 minutes ago   Up 13 minutes   0.0.0.0:8080->8080/tcp, [::]:8080->8080/tcp
openvpn           media.johnson.int:5000/docker-nordvpn:latest   "/init"                  openvpn           11 minutes ago   Up 11 minutes   0.0.0.0:8168->8168/tcp, [::]:8168->8168/tcp
portainer         portainer/portainer-ce:sts                     "/portainer -H tcp:/…"   portainer         13 minutes ago   Up 13 minutes   8000/tcp, 9443/tcp, 0.0.0.0:9010->9000/tcp, [::]:9010->9000/tcp
portainer-agent   portainer/agent:latest                         "./agent"                portainer-agent   13 minutes ago   Up 13 minutes   
downloader        ghcr.io/linuxserver/downloader:latest         "/init"                  downloader       11 minutes ago   Up 11 minutes   
socket-proxy      tecnativa/docker-socket-proxy:latest           "docker-entrypoint.s…"   socket-proxy      13 minutes ago   Up 13 minutes   0.0.0.0:2375->2375/tcp, [::]:2375->2375/tcp
traefik           traefik:v3.6.1                                 "/entrypoint.sh trae…"   traefik           13 minutes ago   Up 13 minutes   0.0.0.0:80->80/tcp, [::]:80->80/tcp, 0.0.0.0:443->443/tcp, [::]:443->443/tcp
whoami            containous/whoami                              "/whoami"                whoami            13 minutes ago   Up 13 minutes   0.0.0.0:9080->80/tcp, [::]:9080->80/tcp
root@media02:[docker]$ 
root@media02:[docker]$ docker network inspect traefik_public | jq '.[0].IPAM.Config[0].Subnet'
"192.168.12.0/24"
root@media02:[docker]$ 
```

## Confirm Using the VPN (Most Important Check)

Run:
```shell
root@media02:[docker]$ docker exec downloader curl -s https://ifconfig.me
192.145.117.83
root@media02:[docker]$ 
root@media02:[docker]$ docker exec downloader curl -s https://ipinfo.io/json
{
  "ip": "192.145.117.83",
  "city": "Charlotte",
  "region": "North Carolina",
  "country": "US",
  "loc": "35.2271,-80.8431",
  "org": "AS141039 PacketHub S.A.",
  "postal": "28202",
  "timezone": "America/New_York",
  "readme": "https://ipinfo.io/missingauth"
}
root@media02:[docker]$ docker exec openvpn curl -s https://ifconfig.me
192.145.117.83
root@media02:[docker]$ 
```

Compare the ifconfig.me IP:

- 192.145.117.83 ← this is not your home/public IP
- In the OpenVPN logs, the connection was made to:
```text
Selected: United States #8497 (us8497.nordvpn.com) at 192.145.117.146
```

→ The remote VPN server IP is 192.145.117.146
→ Your assigned outbound IP 192.145.117.83 is clearly in the same /24 subnet as the VPN exit node.

This is evidence that traffic is exiting via NordVPN.
Most residential ISPs give you something in 100-120.x.x.x, 70-80.x.x.x, 24/50/73/ etc. ranges — not 192.145.x.x.

## Confirm downloader has no direct attachment to traefik_public

Run this:
```shell
root@media02:[docker]$ docker inspect downloader --format '{{json .NetworkSettings.Networks }}'
{}
root@media02:[docker]$
```

You should see empty object {} or just the special "service container" reference — not an entry for traefik_public (192.168.12.0/24).

Expected output looks roughly like:
```json
{}
```

or sometimes shows only loopback / internal info — but no 192.168.12.x address.

Compare with a normal container (e.g. traefik itself):

```
docker inspect traefik --format '{{json .NetworkSettings.Networks }}'
```

→ You'll see it has an IP in 192.168.12.0/24.


## Strongest / cleanest confirmation commands

Run these from the host:

1. Check public IP **from inside downloader**
```shell
docker exec downloader curl -s https://ifconfig.me
# or better — use a service that also shows geo
docker exec downloader curl -s https://ipinfo.io/json
```

Look for "org": "NordVPN" / "city", "region", etc. — should match US server.

2. Check public IP from inside openvpn container (should be same as downloader)
```shell
docker exec openvpn curl -s https://ifconfig.me
```

→ Expect exactly the same IP as downloader.

3. Check public IP from a normal container (e.g. whoami or traefik)
```
docker exec whoami wget -qO- https://ifconfig.me
# or
docker exec traefik curl -s https://ifconfig.me
```

→ This should show your real public/home IP (not the NordVPN one).

If 1 and 2 match each other → and are different from 3 → routing is working perfectly.


| Container | Network mode | Has own IP on traefik_public? | Outbound traffic goes via |
| :--- | :--- | :--- | :--- |
| openvpn | default bridge + vpn net | yes | NordVPN tunnel |
| downloader | service:openvpn | no | same net namespace as openvpn → via NordVPN |
| traefik, whoami, dozzle, etc. | default / traefik_public | yes | host → real internet |

So downloader does not have an interface on traefik_public (192.168.12.0/24) at all — it shares the network stack of the openvpn container.

## Bonus: What you should not do

Do not add downloader to the traefik_public network — it would break the VPN routing (split-tunnel / leak possible).

The current network_mode: service:openvpn + depends_on: openvpn + ports published on openvpn is the standard & correct pattern.

If you want even more certainty, just run the three curl commands above and compare the IPs — that removes any doubt.
