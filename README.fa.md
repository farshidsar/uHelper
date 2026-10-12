# uHelper

**ابزار مدیریت سیستم و شبکه اوبونتو**

uHelper یک ابزار تعاملی Bash برای مدیریت سرورهای Ubuntu است و امکاناتی مانند
مدیریت DNS، نصب پکیج، بررسی شبکه، تست mirror و repository، نصب Docker و Docker
Compose، ابزارهای امنیتی و نگهداری سرور را یکپارچه می‌کند.

- نویسنده: [farshidsar](https://github.com/farshidsar)
- مخزن: [github.com/farshidsar/uHelper](https://github.com/farshidsar/uHelper)
- فایل اصلی: [`uHelper.sh`](./uHelper.sh)
- زبان‌ها: [English](./README.md) · [العربية](./README.ar.md) · [Русский](./README.ru.md) · [简体中文](./README.zh-CN.md)

> **هشدار:** این برنامه تنظیمات شبکه، DNS، فایروال، سرویس‌ها، پکیج‌ها و
> repositoryها را تغییر می‌دهد. قبل از استفاده در production کد را بررسی و روی
> یک سرور آزمایشی اجرا کنید. همیشه backup و دسترسی کنسولی جایگزین داشته باشید.

## امکانات

- نمایش وضعیت سیستم و شبکه، تست اتصال، packet loss، route، MTU و سلامت IP
- جابه‌جایی DNS بین providerهای قابل ویرایش، reset و benchmark DNS
- اعمال DNS از طریق systemd-resolved، NetworkManager یا fallback فایل
  `/etc/resolv.conf`
- مدیریت IPv6، BBR، HYBLA، CUBIC، MTU، sysctl و traffic control
- نصب dependencyها با تشخیص package manager و mapping نام package به command
- تست و اعمال سریع‌ترین Ubuntu APT mirror
- قابلیت‌های Mirava به‌صورت native و بدون نیاز به فایل خارجی هنگام اجرا
- نصب Docker Engine، Buildx و Docker Compose plugin با fallback توزیع
- تست latency آدرس‌های Docker Registry و اعمال سریع‌ترین mirror در
  `/etc/docker/daemon.json`
- مدیریت فایروال، Fail2ban، Lynis، ابزارهای malware/rootkit و ابزارهای امنیتی
- ابزارهای Caddy، Certbot، TX-UI، 3X-UI، Xray و WARP
- مانیتورینگ CPU، RAM، دیسک و ترافیک شبکه، مدیریت Swap و پاک‌سازی سیستم

### فهرست کامل منوها

- **شبکه:** پروفایل‌های BBR، HYBLA و CUBIC، تنظیمات پایدار sysctl، بهینه‌سازی
  QLEEN و MTU، traffic control، اصلاح مشکل تاریخ WhatsApp، تعویض و benchmark
  DNS، مدیریت IPv6، تست packet loss و MTR، anti-sanction DNS، benchmark
  mirrorهای APT و Docker Registry، ابزارهای Mirava، بررسی سلامت IP و WARP.
- **امنیت:** مدیریت UFW و ping، root login، تغییر پورت SSH و رمز عبور، abuse
  defense، restart خودکار Xray، reboot زمان‌بندی‌شده، port scanner، اسکن
  malware/rootkit، audit با Lynis، GeoIP، WARP و rangeهای Arvan.
- **ابزارهای پیشرفته:** Docker و containerها، Docker Compose، Caddy، Certbot،
  TX-UI، 3X-UI و ابزارهای پنل.
- **مانیتورینگ و سیستم:** btop/htop، ncdu، iftop، مدیریت Swap، cleanup،
  سرویس‌ها، update پکیج‌ها و نصب گروهی dependencyها.

## پیش‌نیازها

- Ubuntu 20.04 یا جدیدتر توصیه می‌شود.
- دسترسی root یا `sudo`
- Bash نسخه 4 یا بالاتر
- اینترنت و package manager فعال

## نصب و اجرا

### نصب سریع با یک دستور

برای دریافت مستقیم اسکریپت و اجرای آن:

```bash
curl -fsSL https://raw.githubusercontent.com/farshidsar/uHelper/refs/heads/main/uHelper.sh -o uHelper.sh
chmod +x uHelper.sh
sudo ./uHelper.sh
```

اسکریپت را مستقیماً دانلود و با دسترسی root اجرا کنید.

### نصب از طریق Git

```bash
git clone https://github.com/farshidsar/uHelper.git
cd uHelper
chmod +x uHelper.sh
sudo bash ./uHelper.sh
```

هنگام نصب dependencyها، مقدار پیش‌فرض **Yes** است؛ یعنی با زدن Enter نصب
تأیید می‌شود. برای رد کردن، `n` یا `no` وارد کنید.

برای بررسی helperها بدون اجرای منو:

```bash
source ./uHelper.sh
```

## تنظیمات

تنظیمات قابل ویرایش در ابتدای [`uHelper.sh`](./uHelper.sh) قرار دارند:

- `CORE_PACKAGES`: پکیج‌های پایه
- `DOCKER_PACKAGES`: پکیج‌های Docker
- `DOCKER_REPOSITORY_URL` و `DOCKER_GPG_URL`: repository و کلید Docker
- `APT_MIRRORS`: فهرست mirrorهای Ubuntu
- `DOCKER_REGISTRY_MIRRORS`: فهرست mirrorهای Docker
- `DOCKER_MIRROR_TIMEOUT`: زمان timeout تست mirrorهای Docker
- `DOCKER_DAEMON_CONFIG`: مسیر تنظیمات JSON مربوط به Docker
- `TARGET_DNS`: DNS پیش‌فرض
- `DNS_SWITCHER_PROVIDERS` و `DNS_SWITCHER_SERVERS`: providerها و آدرس DNS
- `PROJECT_GITHUB_URL`: آدرس نمایش‌داده‌شده داخل برنامه

به repository، کلید، package یا URL ناشناس اعتماد نکنید.

## مسیرهای مهم

- لاگ: `/var/log/network_optimizer.log`
- backup: `/var/backups/network_optimizer`
- تنظیمات پایدار: `/etc/irnet`
- temporary files: دایرکتوری خصوصی در `/tmp`

## برنامه توسعه

برنامه‌های بعدی شامل ماژولار کردن فایل Bash بدون از دست دادن launcher تک‌فایلی،
افزودن dry-run و حالت غیرتعاملی، لاگ JSON و operation ID، catalog mirror با
بررسی freshness و TLS، rollback تراکنشی برای DNS/APT/Docker/firewall/SSH،
تست‌های ShellCheck و Bats، CI، پشتیبانی مستند از توزیع‌های بیشتر، import/export
تنظیمات، releaseهای امضاشده و changelog است.

## بررسی صحت

```bash
bash -n ./uHelper.sh
bash -c 'source ./uHelper.sh; package_command dnsutils; command_exists bash'
```

برای جزئیات کامل‌تر نسخه [انگلیسی](./README.md) را ببینید.

## مشارکت

تغییرات را در branch جدا انجام دهید، تنظیمات را در ابتدای فایل نگه دارید، خطاها
را صریح log کنید و قبل از Pull Request دستور `bash -n uHelper.sh` را اجرا کنید.

## مجوز

در حال حاضر فایل License در پروژه وجود ندارد؛ برای بازنشر یا استفاده تجاری با
صاحب مخزن هماهنگ کنید.
