# uHelper

**Ubuntu 系统与网络管理工具**

uHelper 是一个面向 Ubuntu 服务器的交互式 Bash 工具，整合了 DNS 管理、
软件包安装、网络诊断、镜像和仓库测试、Docker 与 Docker Compose 安装、
安全工具以及常用服务器维护功能。

- 作者：[farshidsar](https://github.com/farshidsar)
- 仓库：[github.com/farshidsar/uHelper](https://github.com/farshidsar/uHelper)
- 主脚本：[`uHelper.sh`](./uHelper.sh)
- 语言：[English](./README.md) · [فارسی](./README.fa.md) · [العربية](./README.ar.md) · [Русский](./README.ru.md)

> **重要提示：** 此脚本会修改网络、DNS、防火墙、服务、软件包和仓库设置。
> 请先在测试服务器上检查和运行，并保留备份以及备用登录方式。

## 功能

- 系统和网络状态、连接、丢包、路由、MTU 与 IP 健康检查
- 可编辑 DNS provider 切换、DNS 重置与测速
- 通过 systemd-resolved、NetworkManager 或 `/etc/resolv.conf` 应用 DNS
- IPv6、BBR、HYBLA、CUBIC、sysctl 和 traffic control 管理
- 自动检测 package manager，并集中安装依赖
- Ubuntu APT 镜像测速和应用最快镜像
- 原生集成 Mirava 功能，运行时不依赖外部 Mirava 文件
- 安装 Docker Engine、Buildx 和 Docker Compose，并提供发行版软件包 fallback
- 测试 Docker Registry 镜像延迟，并将最快镜像写入
  `/etc/docker/daemon.json`
- 防火墙、Fail2ban、Lynis、恶意软件/rootkit 检查工具
- Caddy、Certbot、TX-UI、3X-UI、Xray 和 WARP 工具
- CPU、内存、磁盘、网络监控，Swap 管理和系统清理

### 完整菜单功能

- **网络：** BBR/HYBLA/CUBIC、sysctl、QLEEN/MTU、traffic control、WhatsApp
  时间修复、DNS 切换和测速、IPv6、MTR/丢包、anti-sanction DNS、APT 与
  Docker Registry 镜像测速、Mirava、IP 健康检查和 WARP。
- **安全：** UFW 与 ping、root 登录、SSH 端口和密码、abuse defense、Xray
  自动重启、定时重启、端口扫描、malware/rootkit、Lynis、GeoIP、WARP
  和 Arvan 网段扫描。
- **高级工具：** Docker、容器、Compose、Caddy、Certbot、TX-UI 和 3X-UI。
- **监控与系统：** btop/htop、ncdu、iftop、Swap、系统清理、软件包更新和
  依赖安装。

## 要求与安装

建议使用 Ubuntu 20.04 或更新版本、Bash 4+、root 权限、互联网和可用的软件包管理器。

### 快速安装

```bash
curl -fsSL https://raw.githubusercontent.com/farshidsar/uHelper/refs/heads/main/uHelper.sh -o uHelper.sh
chmod +x uHelper.sh
sudo ./uHelper.sh
```

直接下载脚本并以 root 权限运行。

### 从 Git 安装

```bash
git clone https://github.com/farshidsar/uHelper.git
cd uHelper
chmod +x uHelper.sh
sudo bash ./uHelper.sh
```

安装依赖时默认选择 **Yes**。直接按 Enter 确认安装，输入 `n` 或 `no`
即可跳过。

只加载函数而不启动菜单：

```bash
source ./uHelper.sh
```

## 配置

可编辑配置位于 [`uHelper.sh`](./uHelper.sh) 文件开头，包括：
`CORE_PACKAGES`、`DOCKER_PACKAGES`、`APT_MIRRORS`、
`DOCKER_REGISTRY_MIRRORS`、`TARGET_DNS`、`DNS_SWITCHER_PROVIDERS`、
`DNS_SWITCHER_SERVERS` 和 `PROJECT_GITHUB_URL`。

不要直接添加未经验证的仓库、密钥、软件包或 URL。

## 日志与验证

- 日志：`/var/log/network_optimizer.log`
- 备份：`/var/backups/network_optimizer`
- 持久化配置：`/etc/irnet`

## 开发计划

计划包括在保留单文件 portable launcher 的同时模块化 Bash，增加 dry-run
和非交互模式、JSON 日志、带 freshness/TLS 检查的镜像目录、DNS/APT/Docker/
防火墙/SSH 的事务回滚、ShellCheck/Bats/CI 测试、更多发行版的明确支持、
配置导入导出、签名发布和 changelog。

```bash
bash -n ./uHelper.sh
bash -c 'source ./uHelper.sh; package_command dnsutils; command_exists bash'
```

完整说明请查看[英文 README](./README.md)。

## 许可证

当前项目尚未包含许可证文件。重新发布或商业使用前，请联系仓库所有者。
可通过 `DOCKER_REGISTRY_MIRRORS`、`DOCKER_MIRROR_TIMEOUT` 和
`DOCKER_DAEMON_CONFIG` 配置 Docker 镜像列表、测试超时和 Docker 配置路径。
