# xsystems-router

## Usage

1. Configure the OpenWRT router to use IP address `192.168.1.1`
2. Provide the [required secrets](#secrets)
3. Run `./router.sh`


## Secrets

The location of the following items are indicated at the [structure section](#structure).

1. DNS configuration, i.e. domain names, with each line having the following format:
    ```
    192.168.1.42     my.domain.name.org
    ```
2. DHCP configuration, i.e. static leases and hostnames, with each line having the following format:
    ```
    01:23:45:67:89:AB    192.168.1.42     my-hostname
    ```
3. Environment Variables containing Secrets
    | Environment Variable  | Description                               |
    | --------------------- | ----------------------------------------- |
    | ROUTER_ROOT_PASSWORD  | The password used for the `root` account  |
    | ROUTER_WIFI_KEY       | The WIFI password                         |
4. xSystems VPN Secrets


## Scripts

Script filenames have the following syntax in Backus–Naur form:

```bnf
<script-file-name> ::= <priority> "_" <execution-target> "_" <name> ".sh"
<priority>         ::= <digit> <digit>
<execution-target> ::= "l" | "r"
<name>             ::= "" | <letter> <name>
```

Where `priority` indicates the order in which the scripts should be run i.e. scripts with lower `priority` values are executed before scripts with higher `priority` values.

Where `execution-target` indicates where the script should be excuted:

| Value   | Description                    |
| ------- | ------------------------------ |
| _**l**_ | Excute on the `local` machine  |
| _**r**_ | Excute on the `remote` machine |

Where `name` is a human-readable description of the script.


## Structure

```
xsystems-router
├── environment
│   ├── hostnames.dat                   (1)
│   ├── secrets.sh                      (2)
│   ├── static_leases.dat               (3)
│   └── variables.sh
├── files
│   └── etc
│       ├── dropbear
│       │   └── authorized_keys
│       └── openvpn
│           ├── xvpn_ca.crt             (4)
│           ├── xvpn_server.crt         (4)
│           └── xvpn_server.key         (4)
├── .gitignore
├── README.md
├── router.sh
└── scripts
    ├── 00_r_wan_t-mobile.sh
    ├── 10_r_init.sh
    ├── 20_l_files.sh
    ├── 30_r_ssh.sh
    ├── 40_r_root_passwd.sh
    ├── 50_r_wireless.sh
    ├── 60_r_dnsmasq.sh
    ├── 70_r_xvpn.sh
    └── 80_r_luci.sh
```
