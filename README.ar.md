# uHelper

**أداة إدارة نظام وشبكة Ubuntu**

uHelper هي أداة Bash تفاعلية لإدارة خوادم Ubuntu. تجمع بين إدارة DNS، تثبيت
الحزم، تشخيص الشبكة، اختبار المرايا والمستودعات، تثبيت Docker وDocker Compose،
أدوات الأمان وصيانة الخادم.

- المطور: [farshidsar](https://github.com/farshidsar)
- المستودع: [github.com/farshidsar/uHelper](https://github.com/farshidsar/uHelper)
- الملف الرئيسي: [`uHelper.sh`](./uHelper.sh)
- اللغات: [English](./README.md) · [فارسی](./README.fa.md) · [Русский](./README.ru.md) · [简体中文](./README.zh-CN.md)

> **تحذير:** يغير البرنامج إعدادات الشبكة وDNS والجدار الناري والخدمات والحزم
> والمستودعات. اختبره أولا على خادم تجريبي واحتفظ بنسخة احتياطية ووصول بديل.

## الوظائف

- عرض حالة النظام والشبكة وفحص الاتصال وفقدان الحزم وMTU وIP
- تبديل مزودي DNS القابلين للتعديل، وإعادة الضبط وقياس السرعة
- تطبيق DNS عبر systemd-resolved أو NetworkManager أو `/etc/resolv.conf`
- إدارة IPv6 وBBR وHYBLA وCUBIC وsysctl وtraffic control
- تثبيت الاعتماديات مع اكتشاف package manager وربط أسماء الحزم بالأوامر
- اختبار وتطبيق أسرع Ubuntu APT mirror
- دمج وظائف Mirava داخليا بدون الحاجة إلى ملفات Mirava أثناء التشغيل
- تثبيت Docker Engine وBuildx وDocker Compose مع بديل حزم التوزيعة
- أدوات الجدار الناري وFail2ban وLynis وفحص malware/rootkit
- أدوات Caddy وCertbot وTX-UI و3X-UI وXray وWARP
- مراقبة CPU والذاكرة والقرص والشبكة وإدارة Swap وتنظيف النظام

## المتطلبات والتثبيت

يوصى باستخدام Ubuntu 20.04 أو أحدث مع Bash 4+ وصلاحيات root واتصال إنترنت.


```bash
curl -fsSL https://raw.githubusercontent.com/farshidsar/uHelper/refs/heads/main/uHelper.sh -o uHelper.sh
chmod +x uHelper.sh
./uHelper.sh
```
أو
```bash
git clone https://github.com/farshidsar/uHelper.git
cd uHelper
chmod +x uHelper.sh
sudo bash ./uHelper.sh
```

لفحص الدوال بدون تشغيل القائمة:

```bash
source ./uHelper.sh
```

## الإعداد

الإعدادات المهمة موجودة في بداية [`uHelper.sh`](./uHelper.sh)، ومنها
`CORE_PACKAGES` و`DOCKER_PACKAGES` و`APT_MIRRORS` و`DOCKER_REGISTRY_MIRRORS`
و`TARGET_DNS` و`DNS_SWITCHER_PROVIDERS` و`DNS_SWITCHER_SERVERS` و
`PROJECT_GITHUB_URL`.

لا تضف مستودعات أو مفاتيح أو حزم أو روابط غير موثوقة.

## السجلات والتحقق

- السجل: `/var/log/network_optimizer.log`
- النسخ الاحتياطية: `/var/backups/network_optimizer`
- الإعدادات: `/etc/irnet`

```bash
bash -n ./uHelper.sh
bash -c 'source ./uHelper.sh; package_command dnsutils; command_exists bash'
```

للتفاصيل الكاملة راجع [README الإنجليزي](./README.md).

## الترخيص

لا يوجد ملف ترخيص حاليا. تواصل مع مالك المستودع قبل إعادة التوزيع أو الاستخدام
التجاري.
