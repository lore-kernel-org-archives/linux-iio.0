Return-Path: <matthias.bgg9ab33xy531gmail.com@bounce.antispameurope.com>
Message-ID: <4CB745C8.4050804@gmail.com>
Date: Thu, 14 Oct 2010 20:02:48 +0200
From: Matthias Brugger <matthias.bgg@gmail.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, matthias <mensch0815@googlemail.com>
Subject: [RFC 1/2] iio - add support for digital barometer devices
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

---
 drivers/staging/iio/Kconfig            |    1 +
 drivers/staging/iio/Makefile           |    1 +
 drivers/staging/iio/barometer/Kconfig  |    5 +++++
 drivers/staging/iio/barometer/Makefile |    4 ++++
 drivers/staging/iio/barometer/baro.h   |    8 ++++++++
 5 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/barometer/Kconfig
 create mode 100644 drivers/staging/iio/barometer/Makefile
 create mode 100644 drivers/staging/iio/barometer/baro.h

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index ed48815..d5ca09a 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -46,6 +46,7 @@ source "drivers/staging/iio/gyro/Kconfig"
 source "drivers/staging/iio/imu/Kconfig"
 source "drivers/staging/iio/light/Kconfig"
 source "drivers/staging/iio/magnetometer/Kconfig"
+source "drivers/staging/iio/barometer/Kconfig"
 
 source "drivers/staging/iio/trigger/Kconfig"
 
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index e909674..73112b2 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -16,3 +16,4 @@ obj-y += imu/
 obj-y += light/
 obj-y += trigger/
 obj-y += magnetometer/
+obj-y += barometer/
diff --git a/drivers/staging/iio/barometer/Kconfig b/drivers/staging/iio/barometer/Kconfig
new file mode 100644
index 0000000..588325c
--- /dev/null
+++ b/drivers/staging/iio/barometer/Kconfig
@@ -0,0 +1,5 @@
+#
+# IIO Digital Barometer Sensor drivers configuration
+#
+comment "Digital barometer sensors"
+
diff --git a/drivers/staging/iio/barometer/Makefile b/drivers/staging/iio/barometer/Makefile
new file mode 100644
index 0000000..2963d72
--- /dev/null
+++ b/drivers/staging/iio/barometer/Makefile
@@ -0,0 +1,4 @@
+#
+# Makefile for digital gyroscope sensor drivers
+#
+
diff --git a/drivers/staging/iio/barometer/baro.h b/drivers/staging/iio/barometer/baro.h
new file mode 100644
index 0000000..e3b73a1
--- /dev/null
+++ b/drivers/staging/iio/barometer/baro.h
@@ -0,0 +1,8 @@
+
+#include "../sysfs.h"
+
+/* Barometer types of attribute */
+
+#define IIO_DEV_ATTR_BARO_PRESSURE(_mode, _show, _store, _addr)	\
+	IIO_DEVICE_ATTR(baro_pressure, _mode, _show, NULL, _addr)
+
-- 
1.5.6.5
