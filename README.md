# uHelper

**Ubuntu System and Network Administration Toolkit**

uHelper is an interactive Bash toolkit for Ubuntu server administration, network
diagnostics, DNS management, package installation, security utilities, Docker,
repository/mirror testing, and common server maintenance tasks.

- Author: [farshidsar](https://github.com/farshidsar)
- Repository: [github.com/farshidsar/uHelper](https://github.com/farshidsar/uHelper)
- Main script: [`uHelper.sh`](./uHelper.sh)
- Languages: [فارسی](./README.fa.md) · [العربية](./README.ar.md) · [Русский](./README.ru.md) · [简体中文](./README.zh-CN.md)

> **Important:** This script changes system networking, package, firewall, DNS,
> service, and repository configuration. Review the code and test it on a
> disposable server before using it in production. Always keep a backup and an
> out-of-band access path.

## Features

### Network and DNS

- Network and system status overview
- Connectivity, packet-loss, route, MTU, and IP health diagnostics
- DNS provider switcher with editable providers and server lists
- Persistent DNS configuration through `systemd-resolved`, NetworkManager, or
  a `/etc/resolv.conf` fallback
- DNS benchmarking and reset-to-system-default support
- IPv6 management and TCP congestion-control profiles
- BBR, HYBLA, CUBIC, MTU, `sysctl`, and traffic-control helpers
- SSH port management and automatic reboot scheduling

### Packages, repositories, and mirrors

- Central package configuration near the top of `uHelper.sh`
- Detection of `apt`, `dnf`, `yum`, and `apk` where supported by the shared
  package helpers
- Core dependency installation with command/package-name mapping
- Ubuntu mirror benchmarking and optional fastest-mirror application
- Integrated Mirava mirror/catalog capabilities without requiring external
  Mirava files at runtime
- Atomic backups and safer package-manager lock handling

The current feature set is primarily designed and tested for Ubuntu/Debian
systems. Distribution-specific actions may still require manual review.

### Docker

- Official Docker repository setup
- Docker Engine, Buildx, and Docker Compose plugin installation
- Distribution-package fallback when official packages are unavailable
- Docker service enable/start and Compose verification
- Editable Docker registry mirror catalog

### Security and server tools

- Firewall management
- Fail2ban, malware scanners, Rootkit Hunter, ClamAV-related utilities, and
  Lynis audit integration where available
- GeoIP and abuse-defense helpers
- Xray, TX-UI, 3X-UI, WARP scanner, and related assistant integrations
- Caddy and Certbot helpers

### Monitoring and maintenance

- htop/btop, ncdu, iftop, disk, memory, CPU, and network monitoring
- Swap management
- System cleanup
- Service status checks
- Structured log output and temporary-file cleanup

## Requirements

- Ubuntu 20.04 or newer is recommended.
- Root privileges (`sudo` or a root shell).
- Bash 4+.
- Internet access for package, key, repository, and release downloads.
- A working package manager.
- `curl` or `wget` for some optional integrations.

## Installation

Clone the repository and enter its directory:

```bash
git clone https://github.com/farshidsar/uHelper.git
cd uHelper
chmod +x uHelper.sh
```

Run it as root:

```bash
sudo bash ./uHelper.sh
```

The script intentionally does not run its menu when it is sourced, so helper
functions can be inspected or tested safely:

```bash
source ./uHelper.sh
```

## Configuration

The editable configuration is near the beginning of [`uHelper.sh`](./uHelper.sh).
Review it before the first run. Important variables include:

| Variable | Purpose |
|---|---|
| `PROJECT_GITHUB_URL` | Project URL displayed by the program |
| `CORE_PACKAGES` | Base packages checked/installed by the dependency workflow |
| `DOCKER_PACKAGES` | Official Docker package names |
| `DOCKER_REPOSITORY_URL` | Docker APT repository |
| `DOCKER_GPG_URL` | Docker signing-key URL |
| `APT_MIRRORS` | Ubuntu mirrors used for benchmarking |
| `DOCKER_REGISTRY_MIRRORS` | Docker registry mirror catalog |
| `TARGET_DNS` | Default DNS target list |
| `DNS_SWITCHER_PROVIDERS` | DNS provider names |
| `DNS_SWITCHER_SERVERS` | Provider-to-server mappings |
| `AUTO_INSTALL_DOCKER` | Whether the dependency workflow offers Docker installation |

Do not blindly add untrusted repositories, keys, packages, or shell URLs.

## Main menu

The main menu currently provides:

1. Network and connection optimization
2. Security and access
3. Monitoring and diagnostics
4. System and utility tools
5. Advanced and web tools
6. Update and install required packages
7. Install dependency packages
8. Install/update TX-UI
9. Install/update 3X-UI

The integrated Mirava menu reuses native uHelper functions for mirror
benchmarking, DNS management, package installation, Docker installation, and
catalog display. The original Mirava files are not required at runtime.

## Logs, backups, and generated files

- Log: `/var/log/network_optimizer.log`
- Backups: `/var/backups/network_optimizer`
- Persistent configuration: `/etc/irnet`
- Temporary files: a private directory below `/tmp`, removed on exit

## Safety notes

- Run network changes from a console or keep an existing SSH session open.
- DNS, firewall, SSH-port, repository, and kernel tuning changes can disconnect
  you or affect existing services.
- Package installation may restart services.
- Verify the selected mirror and repository before applying it.
- Do not run the script with unreviewed third-party modifications.
- Test backups and recovery procedures before production use.

## Validation

Basic syntax validation:

```bash
bash -n ./uHelper.sh
```

Source-only smoke test:

```bash
bash -c 'source ./uHelper.sh; package_command dnsutils; command_exists bash'
```

## Contributing

1. Create a feature branch.
2. Keep configuration values centralized and editable.
3. Preserve explicit error logging and safe cleanup.
4. Run `bash -n uHelper.sh`.
5. Document behavior changes in the README files.
6. Open a pull request at [farshidsar/uHelper](https://github.com/farshidsar/uHelper).

## License

No license file is currently included. Ask the repository owner before
redistributing or incorporating this project into another product.
