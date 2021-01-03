# xsystems-router

## Usage

1. Configure the OpenWRT router to use IP address `192.168.1.1`
2. Provide the [required secrets](#secrets)
3. Run `./router.sh`


## Secrets

The location of the following items are indicated at the [structure section](#structure).

1. Environment Variables containing Secrets
    | Environment Variable  | Description                               |
    | --------------------- | ----------------------------------------- |
    | ROUTER_ROOT_PASSWORD  | The password used for the `root` account  |
    | ROUTER_WIFI_KEY       | The WIFI password                         |
2. NordVPN Secrets
3. xSystems VPN Secrets


## Structure

```
xsystems-router
├── config
│   ├── luci.sh
│   ├── network.sh
│   ├── nordvpn.sh.disabled
│   ├── ssh.sh
│   └── xvpn.sh
├── environment
│   ├── secrets.sh                      (1)
│   └── variables.sh
├── files
│   └── etc
│       ├── dropbear
│       │   └── authorized_keys
│       └── openvpn
│           ├── nordvpn_ca.crt          (3)
│           ├── nordvpn.credentials     (3)
│           ├── nordvpn_ta.key          (3)
│           ├── xvpn_ca.crt             (2)
│           ├── xvpn_dh.pem             (2)
│           ├── xvpn_server.crt         (2)
│           └── xvpn_server.key         (2)
├── README.md
└── router.sh
```