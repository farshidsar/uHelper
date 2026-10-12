# uHelper

**Инструментарий администрирования Ubuntu и сети**

uHelper — интерактивный Bash-инструмент для администрирования серверов Ubuntu.
Он объединяет управление DNS, установку пакетов, диагностику сети, проверку
зеркал и репозиториев, установку Docker и Docker Compose, средства
безопасности и обслуживание сервера.

- Автор: [farshidsar](https://github.com/farshidsar)
- Репозиторий: [github.com/farshidsar/uHelper](https://github.com/farshidsar/uHelper)
- Основной файл: [`uHelper.sh`](./uHelper.sh)
- Языки: [English](./README.md) · [فارسی](./README.fa.md) · [العربية](./README.ar.md) · [简体中文](./README.zh-CN.md)

> **Важно:** скрипт изменяет настройки сети, DNS, firewall, сервисов, пакетов и
> репозиториев. Сначала проверьте его на тестовом сервере и сохраните резервную
> копию и альтернативный доступ.

## Возможности

- Статус системы и сети, проверка соединения, packet loss, маршрутов, MTU и IP
- Переключение настраиваемых DNS-провайдеров, сброс и benchmark DNS
- Применение DNS через systemd-resolved, NetworkManager или `/etc/resolv.conf`
- Управление IPv6, BBR, HYBLA, CUBIC, sysctl и traffic control
- Установка зависимостей с определением package manager и mapping пакетов
- Тестирование и применение быстрого Ubuntu APT mirror
- Встроенные возможности Mirava без внешних файлов во время запуска
- Установка Docker Engine, Buildx и Docker Compose с fallback-пакетами системы
- Проверка задержки Docker Registry mirror и применение самого быстрого в
  `/etc/docker/daemon.json`
- Firewall, Fail2ban, Lynis, malware/rootkit-инструменты
- Caddy, Certbot, TX-UI, 3X-UI, Xray и WARP
- Мониторинг CPU, памяти, диска и сети, управление Swap и очистка системы

### Полный список меню

- **Сеть:** профили BBR/HYBLA/CUBIC, sysctl, QLEEN/MTU, traffic control,
  исправление времени WhatsApp, переключение и benchmark DNS, IPv6, MTR и
  packet loss, anti-sanction DNS, APT и Docker Registry mirrors, Mirava,
  проверка IP и WARP.
- **Безопасность:** UFW и ping, root login, SSH-порт и пароль, abuse defense,
  автоперезапуск Xray, плановый reboot, port scanner, malware/rootkit, Lynis,
  GeoIP, WARP и диапазоны Arvan.
- **Расширенные инструменты:** Docker, контейнеры, Compose, Caddy, Certbot,
  TX-UI и 3X-UI.
- **Мониторинг и система:** btop/htop, ncdu, iftop, Swap, очистка, обновление
  пакетов и установка зависимостей.

## Требования и установка

Рекомендуется Ubuntu 20.04+ с Bash 4+, root-доступом, интернетом и рабочим
package manager.

### Быстрая установка

```bash
curl -fsSL https://raw.githubusercontent.com/farshidsar/uHelper/refs/heads/main/uHelper.sh -o uHelper.sh
chmod +x uHelper.sh
sudo ./uHelper.sh
```

Скачайте скрипт и запустите его с root-правами.

### Установка через Git

```bash
git clone https://github.com/farshidsar/uHelper.git
cd uHelper
chmod +x uHelper.sh
sudo bash ./uHelper.sh
```

При установке зависимостей значение по умолчанию — **Да**. Нажмите Enter для
подтверждения или введите `n`/`no`, чтобы пропустить установку.

Проверка функций без запуска меню:

```bash
source ./uHelper.sh
```

## Настройка

Редактируемые настройки находятся в начале [`uHelper.sh`](./uHelper.sh):
`CORE_PACKAGES`, `DOCKER_PACKAGES`, `APT_MIRRORS`,
`DOCKER_REGISTRY_MIRRORS`, `TARGET_DNS`, `DNS_SWITCHER_PROVIDERS`,
`DNS_SWITCHER_SERVERS` и `PROJECT_GITHUB_URL`.

Не добавляйте непроверенные репозитории, ключи, пакеты или URL.

## Логи и проверка

- Лог: `/var/log/network_optimizer.log`
- Резервные копии: `/var/backups/network_optimizer`
- Конфигурация: `/etc/irnet`

## План развития

План включает модульную структуру Bash с сохранением portable launcher,
dry-run и non-interactive режимы, JSON-логи, актуальный mirror catalog с
проверкой freshness/TLS, транзакционный rollback DNS/APT/Docker/firewall/SSH,
ShellCheck/Bats/CI, документированную поддержку дополнительных дистрибутивов,
import/export конфигурации, подписанные релизы и changelog.

```bash
bash -n ./uHelper.sh
bash -c 'source ./uHelper.sh; package_command dnsutils; command_exists bash'
```

Полная документация доступна в [английском README](./README.md).

## Лицензия

Файл лицензии пока не добавлен. Перед распространением или коммерческим
использованием свяжитесь с владельцем репозитория.
Список зеркал, таймаут и путь конфигурации Docker настраиваются через
`DOCKER_REGISTRY_MIRRORS`, `DOCKER_MIRROR_TIMEOUT` и `DOCKER_DAEMON_CONFIG`.
