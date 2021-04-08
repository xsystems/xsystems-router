# xsystems-router

## Usage

1. Configure the OpenWRT router to use IP address `192.168.1.1`
2. Provide the [required secrets](#secrets)
3. Run `./router.sh`


## Secrets

The location of the following items are indicated at the [structure section](#structure).

1. DHCP and DNS configuration, with each line having the following format:
    ```
    01:23:45:67:89:AB    192.168.1.42     my.domain.name.org      my-hostname
    ```
2. Environment Variables containing Secrets
    | Environment Variable  | Description                               |
    | --------------------- | ----------------------------------------- |
    | ROUTER_ROOT_PASSWORD  | The password used for the `root` account  |
    | ROUTER_WIFI_KEY       | The WIFI password                         |
3. xSystems VPN Secrets


## Structure

```
xsystems-router
├── config
│   ├── dnsmasq.sh
│   ├── luci.sh
│   ├── network.sh
│   ├── ssh.sh
│   └── xvpn.sh
├── environment
│   ├── dnsmasq.dat                     (1)
│   ├── secrets.sh                      (2)
│   └── variables.sh
├── files
│   └── etc
│       ├── dropbear
│       │   └── authorized_keys
│       └── openvpn
│           ├── xvpn_ca.crt             (3)
│           ├── xvpn_server.crt         (3)
│           └── xvpn_server.key         (3)
├── .gitignore
├── README.md
└── router.sh
```
