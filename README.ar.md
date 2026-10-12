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
- قياس زمن استجابة مرايا Docker Registry وتطبيق الأسرع في
  `/etc/docker/daemon.json`
- أدوات الجدار الناري وFail2ban وLynis وفحص malware/rootkit
- أدوات Caddy وCertbot وTX-UI و3X-UI وXray وWARP
- مراقبة CPU والذاكرة والقرص والشبكة وإدارة Swap وتنظيف النظام

### الفهرس الكامل للقوائم

- **الشبكة:** ملفات BBR وHYBLA وCUBIC، sysctl وMTU وtraffic control، إصلاح
  وقت WhatsApp، تبديل وقياس DNS، IPv6، MTR وفقدان الحزم، anti-sanction DNS،
  قياس مرايا APT وDocker Registry، أدوات Mirava وفحص IP وWARP.
- **الأمان:** UFW وping، دخول root، منفذ وكلمة مرور SSH، abuse defense،
  إعادة تشغيل Xray، إعادة تشغيل مجدولة، فحص المنافذ وmalware/rootkit وLynis،
  GeoIP وفحص WARP ونطاقات Arvan.
- **الأدوات المتقدمة:** Docker والحاويات وCompose وCaddy وCertbot وTX-UI و3X-UI.
- **المراقبة والنظام:** btop/htop وncdu وiftop وSwap والتنظيف وتحديث الحزم
  وتثبيت الاعتماديات.

## المتطلبات والتثبيت

يوصى باستخدام Ubuntu 20.04 أو أحدث مع Bash 4+ وصلاحيات root واتصال إنترنت.

### التثبيت السريع

```bash
curl -fsSL https://raw.githubusercontent.com/farshidsar/uHelper/refs/heads/main/uHelper.sh -o uHelper.sh
chmod +x uHelper.sh
sudo ./uHelper.sh
```

قم بتنزيل البرنامج وتشغيله مباشرة بصلاحيات root.

### التثبيت من Git

```bash
git clone https://github.com/farshidsar/uHelper.git
cd uHelper
chmod +x uHelper.sh
sudo bash ./uHelper.sh
```

عند طلب تثبيت الاعتماديات، تكون الإجابة الافتراضية **نعم**. اضغط Enter
للموافقة، أو اكتب `n` أو `no` للرفض.

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

## خطة التطوير

تشمل الخطة تقسيم Bash إلى وحدات قابلة للاختبار مع الحفاظ على launcher واحد،
وضع dry-run وغير تفاعلي، سجلات JSON، catalog مرايا مع freshness وTLS، rollback
لإعدادات DNS وAPT وDocker وfirewall وSSH، اختبارات ShellCheck وBats وCI، دعم
موثق لتوزيعات إضافية، import/export للإعدادات وإصدارات موقعة.

```bash
bash -n ./uHelper.sh
bash -c 'source ./uHelper.sh; package_command dnsutils; command_exists bash'
```

للتفاصيل الكاملة راجع [README الإنجليزي](./README.md).

## الترخيص

لا يوجد ملف ترخيص حاليا. تواصل مع مالك المستودع قبل إعادة التوزيع أو الاستخدام
التجاري.
يمكن تعديل قائمة مرايا Docker ومدة الاختبار ومسار إعداد Docker من خلال
`DOCKER_REGISTRY_MIRRORS` و`DOCKER_MIRROR_TIMEOUT` و`DOCKER_DAEMON_CONFIG`.
