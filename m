Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-046.synserver.de ([212.40.185.46]:1602 "EHLO
	smtp-out-044.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753040Ab2EULk2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 May 2012 07:40:28 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 18/18] staging:iio: Move DAC drivers out of staging
Date: Mon, 21 May 2012 13:43:07 +0200
Message-Id: <1337600587-19848-18-git-send-email-lars@metafoo.de>
In-Reply-To: <1337600587-19848-1-git-send-email-lars@metafoo.de>
References: <1337600587-19848-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO DAC drivers are in a reasonably good shape. They all make use of channel
spec and non of them provides non-documented sysfs attributes. Code style should
be OK as well, both checkpatch and coccicheck only report trivial issues.

So lets move the whole folder out of staging.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/Kconfig                                 |    1 +
 drivers/iio/Makefile                                |    1 +
 drivers/{staging => }/iio/dac/Kconfig               |    0
 drivers/{staging => }/iio/dac/Makefile              |    0
 drivers/{staging => }/iio/dac/ad5064.c              |    0
 drivers/{staging => }/iio/dac/ad5360.c              |    0
 drivers/{staging => }/iio/dac/ad5380.c              |    0
 drivers/{staging => }/iio/dac/ad5421.c              |    2 +-
 drivers/{staging => }/iio/dac/ad5446.c              |    0
 drivers/{staging => }/iio/dac/ad5446.h              |    0
 drivers/{staging => }/iio/dac/ad5504.c              |    3 +--
 drivers/{staging => }/iio/dac/ad5624r.h             |    0
 drivers/{staging => }/iio/dac/ad5624r_spi.c         |    0
 drivers/{staging => }/iio/dac/ad5686.c              |    0
 drivers/{staging => }/iio/dac/ad5764.c              |    0
 drivers/{staging => }/iio/dac/ad5791.c              |    3 +--
 drivers/{staging => }/iio/dac/max517.c              |    3 +--
 drivers/staging/iio/Kconfig                         |    1 -
 drivers/staging/iio/Makefile                        |    1 -
 {drivers/staging => include/linux}/iio/dac/ad5421.h |    4 ----
 {drivers/staging => include/linux}/iio/dac/ad5504.h |    4 ----
 {drivers/staging => include/linux}/iio/dac/ad5791.h |    4 ----
 {drivers/staging => include/linux}/iio/dac/max517.h |    4 ----
 23 files changed, 6 insertions(+), 25 deletions(-)
 rename drivers/{staging => }/iio/dac/Kconfig (100%)
 rename drivers/{staging => }/iio/dac/Makefile (100%)
 rename drivers/{staging => }/iio/dac/ad5064.c (100%)
 rename drivers/{staging => }/iio/dac/ad5360.c (100%)
 rename drivers/{staging => }/iio/dac/ad5380.c (100%)
 rename drivers/{staging => }/iio/dac/ad5421.c (99%)
 rename drivers/{staging => }/iio/dac/ad5446.c (100%)
 rename drivers/{staging => }/iio/dac/ad5446.h (100%)
 rename drivers/{staging => }/iio/dac/ad5504.c (99%)
 rename drivers/{staging => }/iio/dac/ad5624r.h (100%)
 rename drivers/{staging => }/iio/dac/ad5624r_spi.c (100%)
 rename drivers/{staging => }/iio/dac/ad5686.c (100%)
 rename drivers/{staging => }/iio/dac/ad5764.c (100%)
 rename drivers/{staging => }/iio/dac/ad5791.c (99%)
 rename drivers/{staging => }/iio/dac/max517.c (99%)
 rename {drivers/staging => include/linux}/iio/dac/ad5421.h (92%)
 rename {drivers/staging => include/linux}/iio/dac/ad5504.h (74%)
 rename {drivers/staging => include/linux}/iio/dac/ad5791.h (87%)
 rename {drivers/staging => include/linux}/iio/dac/max517.h (76%)

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 56eecef..62fda86 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -50,5 +50,6 @@ config IIO_CONSUMERS_PER_TRIGGER
 
 source "drivers/iio/adc/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
+source "drivers/iio/dac/Kconfig"
 
 endif # IIO
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index e425afd..30a9144 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
 
 obj-y += adc/
 obj-y += amplifiers/
+obj-y += dac/
diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
similarity index 100%
rename from drivers/staging/iio/dac/Kconfig
rename to drivers/iio/dac/Kconfig
diff --git a/drivers/staging/iio/dac/Makefile b/drivers/iio/dac/Makefile
similarity index 100%
rename from drivers/staging/iio/dac/Makefile
rename to drivers/iio/dac/Makefile
diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
similarity index 100%
rename from drivers/staging/iio/dac/ad5064.c
rename to drivers/iio/dac/ad5064.c
diff --git a/drivers/staging/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
similarity index 100%
rename from drivers/staging/iio/dac/ad5360.c
rename to drivers/iio/dac/ad5360.c
diff --git a/drivers/staging/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
similarity index 100%
rename from drivers/staging/iio/dac/ad5380.c
rename to drivers/iio/dac/ad5380.c
diff --git a/drivers/staging/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
similarity index 99%
rename from drivers/staging/iio/dac/ad5421.c
rename to drivers/iio/dac/ad5421.c
index ea2f83b..cdbc5bf 100644
--- a/drivers/staging/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -19,7 +19,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
-#include "ad5421.h"
+#include <linux/iio/dac/ad5421.h>
 
 
 #define AD5421_REG_DAC_DATA		0x1
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
similarity index 100%
rename from drivers/staging/iio/dac/ad5446.c
rename to drivers/iio/dac/ad5446.c
diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/iio/dac/ad5446.h
similarity index 100%
rename from drivers/staging/iio/dac/ad5446.h
rename to drivers/iio/dac/ad5446.h
diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
similarity index 99%
rename from drivers/staging/iio/dac/ad5504.c
rename to drivers/iio/dac/ad5504.c
index 012c187..49f71cb 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -19,8 +19,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
-
-#include "ad5504.h"
+#include <linux/iio/dac/ad5504.h>
 
 #define AD5505_BITS			12
 #define AD5504_RES_MASK			((1 << (AD5505_BITS)) - 1)
diff --git a/drivers/staging/iio/dac/ad5624r.h b/drivers/iio/dac/ad5624r.h
similarity index 100%
rename from drivers/staging/iio/dac/ad5624r.h
rename to drivers/iio/dac/ad5624r.h
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
similarity index 100%
rename from drivers/staging/iio/dac/ad5624r_spi.c
rename to drivers/iio/dac/ad5624r_spi.c
diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
similarity index 100%
rename from drivers/staging/iio/dac/ad5686.c
rename to drivers/iio/dac/ad5686.c
diff --git a/drivers/staging/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
similarity index 100%
rename from drivers/staging/iio/dac/ad5764.c
rename to drivers/iio/dac/ad5764.c
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
similarity index 99%
rename from drivers/staging/iio/dac/ad5791.c
rename to drivers/iio/dac/ad5791.c
index 5de28c2..2bd2e37 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -19,8 +19,7 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-
-#include "ad5791.h"
+#include <linux/iio/dac/ad5791.h>
 
 #define AD5791_RES_MASK(x)		((1 << (x)) - 1)
 #define AD5791_DAC_MASK			AD5791_RES_MASK(20)
diff --git a/drivers/staging/iio/dac/max517.c b/drivers/iio/dac/max517.c
similarity index 99%
rename from drivers/staging/iio/dac/max517.c
rename to drivers/iio/dac/max517.c
index 403e06f..92c77c8 100644
--- a/drivers/staging/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -27,8 +27,7 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-
-#include "max517.h"
+#include <linux/iio/dac/max517.h>
 
 #define MAX517_DRV_NAME	"max517"
 
diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 3c8e5ec..04cd6ec 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -29,7 +29,6 @@ source "drivers/staging/iio/accel/Kconfig"
 source "drivers/staging/iio/adc/Kconfig"
 source "drivers/staging/iio/addac/Kconfig"
 source "drivers/staging/iio/cdc/Kconfig"
-source "drivers/staging/iio/dac/Kconfig"
 source "drivers/staging/iio/frequency/Kconfig"
 source "drivers/staging/iio/gyro/Kconfig"
 source "drivers/staging/iio/impedance-analyzer/Kconfig"
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 6a46d5a..fa6937d 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -17,7 +17,6 @@ obj-y += accel/
 obj-y += adc/
 obj-y += addac/
 obj-y += cdc/
-obj-y += dac/
 obj-y += frequency/
 obj-y += gyro/
 obj-y += impedance-analyzer/
diff --git a/drivers/staging/iio/dac/ad5421.h b/include/linux/iio/dac/ad5421.h
similarity index 92%
rename from drivers/staging/iio/dac/ad5421.h
rename to include/linux/iio/dac/ad5421.h
index cd2bb84..8fd8f05 100644
--- a/drivers/staging/iio/dac/ad5421.h
+++ b/include/linux/iio/dac/ad5421.h
@@ -1,10 +1,6 @@
 #ifndef __IIO_DAC_AD5421_H__
 #define __IIO_DAC_AD5421_H__
 
-/*
- * TODO: This file needs to go into include/linux/iio
- */
-
 /**
  * enum ad5421_current_range - Current range the AD5421 is configured for.
  * @AD5421_CURRENT_RANGE_4mA_20mA: 4 mA to 20 mA (RANGE1,0 pins = 00)
diff --git a/drivers/staging/iio/dac/ad5504.h b/include/linux/iio/dac/ad5504.h
similarity index 74%
rename from drivers/staging/iio/dac/ad5504.h
rename to include/linux/iio/dac/ad5504.h
index d4980bf..4389537 100644
--- a/drivers/staging/iio/dac/ad5504.h
+++ b/include/linux/iio/dac/ad5504.h
@@ -9,10 +9,6 @@
 #ifndef SPI_AD5504_H_
 #define SPI_AD5504_H_
 
-/*
- * TODO: struct ad5504_platform_data needs to go into include/linux/iio
- */
-
 struct ad5504_platform_data {
 	u16				vref_mv;
 };
diff --git a/drivers/staging/iio/dac/ad5791.h b/include/linux/iio/dac/ad5791.h
similarity index 87%
rename from drivers/staging/iio/dac/ad5791.h
rename to include/linux/iio/dac/ad5791.h
index 87a6c92..45ee281 100644
--- a/drivers/staging/iio/dac/ad5791.h
+++ b/include/linux/iio/dac/ad5791.h
@@ -9,10 +9,6 @@
 #ifndef SPI_AD5791_H_
 #define SPI_AD5791_H_
 
-/*
- * TODO: struct ad5791_platform_data needs to go into include/linux/iio
- */
-
 /**
  * struct ad5791_platform_data - platform specific information
  * @vref_pos_mv:	Vdd Positive Analog Supply Volatge (mV)
diff --git a/drivers/staging/iio/dac/max517.h b/include/linux/iio/dac/max517.h
similarity index 76%
rename from drivers/staging/iio/dac/max517.h
rename to include/linux/iio/dac/max517.h
index 8106cf2..f6d1d25 100644
--- a/drivers/staging/iio/dac/max517.h
+++ b/include/linux/iio/dac/max517.h
@@ -8,10 +8,6 @@
 #ifndef IIO_DAC_MAX517_H_
 #define IIO_DAC_MAX517_H_
 
-/*
- * TODO: struct max517_platform_data needs to go into include/linux/iio
- */
-
 struct max517_platform_data {
 	u16				vref_mv[2];
 };
-- 
1.7.10

