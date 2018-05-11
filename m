Return-Path: <SRS0=6Xdg=H6=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	drew.paterson@ams.com
Subject: [PATCH v3 9/9] staging: iio: tsl2x7x/tsl2772: move out of staging
Date: Thu, 10 May 2018 20:12:23 -0400
Message-Id: <20180511001223.12378-10-masneyb@onstation.org>
In-Reply-To: <20180511001223.12378-1-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

Move the tsl2772 driver out of staging and into mainline.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/iio/light/Kconfig                                  |  8 ++++++++
 drivers/iio/light/Makefile                                 |  1 +
 drivers/{staging => }/iio/light/tsl2772.c                  |  2 +-
 drivers/staging/iio/Kconfig                                |  1 -
 drivers/staging/iio/Makefile                               |  1 -
 drivers/staging/iio/light/Kconfig                          | 14 --------------
 drivers/staging/iio/light/Makefile                         |  5 -----
 .../iio/light => include/linux/platform_data}/tsl2772.h    |  0
 8 files changed, 10 insertions(+), 22 deletions(-)
 rename drivers/{staging => }/iio/light/tsl2772.c (99%)
 delete mode 100644 drivers/staging/iio/light/Kconfig
 delete mode 100644 drivers/staging/iio/light/Makefile
 rename {drivers/staging/iio/light => include/linux/platform_data}/tsl2772.h (100%)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 074e50657366..c7ef8d1862d6 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -409,6 +409,14 @@ config TSL2583
 	 Provides support for the TAOS tsl2580, tsl2581 and tsl2583 devices.
 	 Access ALS data via iio, sysfs.
 
+config TSL2772
+	tristate "TAOS TSL/TMD2x71 and TSL/TMD2x72 Family of light and proximity sensors"
+	depends on I2C
+	help
+	 Support for: tsl2571, tsl2671, tmd2671, tsl2771, tmd2771, tsl2572, tsl2672,
+	 tmd2672, tsl2772, tmd2772 devices.
+	 Provides iio_events and direct access via sysfs.
+
 config TSL4531
 	tristate "TAOS TSL4531 ambient light sensors"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index f1777036d4f8..80943af5d627 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_ST_UVIS25_SPI)	+= st_uvis25_spi.o
 obj-$(CONFIG_TCS3414)		+= tcs3414.o
 obj-$(CONFIG_TCS3472)		+= tcs3472.o
 obj-$(CONFIG_TSL2583)		+= tsl2583.o
+obj-$(CONFIG_TSL2772)		+= tsl2772.o
 obj-$(CONFIG_TSL4531)		+= tsl4531.o
 obj-$(CONFIG_US5182D)		+= us5182d.o
 obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
diff --git a/drivers/staging/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
similarity index 99%
rename from drivers/staging/iio/light/tsl2772.c
rename to drivers/iio/light/tsl2772.c
index a59bf39c28d4..34d42a2504c9 100644
--- a/drivers/staging/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -19,7 +19,7 @@
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include "tsl2772.h"
+#include <linux/platform_data/tsl2772.h>
 
 /* Cal defs */
 #define PROX_STAT_CAL			0
diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 8abc1ab3c0c7..ca001510782d 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -11,7 +11,6 @@ source "drivers/staging/iio/cdc/Kconfig"
 source "drivers/staging/iio/frequency/Kconfig"
 source "drivers/staging/iio/gyro/Kconfig"
 source "drivers/staging/iio/impedance-analyzer/Kconfig"
-source "drivers/staging/iio/light/Kconfig"
 source "drivers/staging/iio/meter/Kconfig"
 source "drivers/staging/iio/resolver/Kconfig"
 source "drivers/staging/iio/trigger/Kconfig"
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 455bffc29649..5c168403b873 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -10,7 +10,6 @@ obj-y += cdc/
 obj-y += frequency/
 obj-y += gyro/
 obj-y += impedance-analyzer/
-obj-y += light/
 obj-y += meter/
 obj-y += resolver/
 obj-y += trigger/
diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
deleted file mode 100644
index dfa37386ad2c..000000000000
--- a/drivers/staging/iio/light/Kconfig
+++ /dev/null
@@ -1,14 +0,0 @@
-#
-# Light sensors
-#
-menu "Light sensors"
-
-config TSL2772
-	tristate "TAOS TSL/TMD2x71 and TSL/TMD2x72 Family of light and proximity sensors"
-	depends on I2C
-	help
-	 Support for: tsl2571, tsl2671, tmd2671, tsl2771, tmd2771, tsl2572, tsl2672,
-	 tmd2672, tsl2772, tmd2772 devices.
-	 Provides iio_events and direct access via sysfs.
-
-endmenu
diff --git a/drivers/staging/iio/light/Makefile b/drivers/staging/iio/light/Makefile
deleted file mode 100644
index e7e77a11f02a..000000000000
--- a/drivers/staging/iio/light/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-#
-# Makefile for industrial I/O Light sensors
-#
-
-obj-$(CONFIG_TSL2772)	+= tsl2772.o
diff --git a/drivers/staging/iio/light/tsl2772.h b/include/linux/platform_data/tsl2772.h
similarity index 100%
rename from drivers/staging/iio/light/tsl2772.h
rename to include/linux/platform_data/tsl2772.h
-- 
2.14.3
