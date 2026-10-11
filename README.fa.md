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
- مدیریت فایروال، Fail2ban، Lynis، ابزارهای malware/rootkit و ابزارهای امنیتی
- ابزارهای Caddy، Certbot، TX-UI، 3X-UI، Xray و WARP
- مانیتورینگ CPU، RAM، دیسک و ترافیک شبکه، مدیریت Swap و پاک‌سازی سیستم

## پیش‌نیازها

- Ubuntu 20.04 یا جدیدتر توصیه می‌شود.
- دسترسی root یا `sudo`
- Bash نسخه 4 یا بالاتر
- اینترنت و package manager فعال

## نصب و اجرا


```bash
curl -fsSL https://raw.githubusercontent.com/farshidsar/uHelper/refs/heads/main/uHelper.sh -o uHelper.sh
chmod +x uHelper.sh
./uHelper.sh
```

یا

```bash
git clone https://github.com/farshidsar/uHelper.git
cd uHelper
chmod +x uHelper.sh
sudo bash ./uHelper.sh
```

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
- `TARGET_DNS`: DNS پیش‌فرض
- `DNS_SWITCHER_PROVIDERS` و `DNS_SWITCHER_SERVERS`: providerها و آدرس DNS
- `PROJECT_GITHUB_URL`: آدرس نمایش‌داده‌شده داخل برنامه

به repository، کلید، package یا URL ناشناس اعتماد نکنید.

## مسیرهای مهم

- لاگ: `/var/log/network_optimizer.log`
- backup: `/var/backups/network_optimizer`
- تنظیمات پایدار: `/etc/irnet`
- temporary files: دایرکتوری خصوصی در `/tmp`

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
