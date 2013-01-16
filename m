Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-069.synserver.de ([212.40.185.69]:1135 "EHLO
	smtp-out-069.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab3APMsX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2013 07:48:23 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/15] staging:iio: Move adis16400 out of staging
Date: Wed, 16 Jan 2013 13:48:47 +0100
Message-Id: <1358340531-31350-11-git-send-email-lars@metafoo.de>
In-Reply-To: <1358340531-31350-1-git-send-email-lars@metafoo.de>
References: <1358340531-31350-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adis16400 driver is in pretty good shape now, so move it out of staging.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/Kconfig                                 | 11 +++++++++++
 drivers/iio/imu/Makefile                                |  3 +++
 drivers/{staging => }/iio/imu/adis16400.h               |  0
 .../imu/adis16400_ring.c => iio/imu/adis16400_buffer.c} |  0
 drivers/{staging => }/iio/imu/adis16400_core.c          |  0
 drivers/staging/iio/Kconfig                             |  1 -
 drivers/staging/iio/Makefile                            |  1 -
 drivers/staging/iio/imu/Kconfig                         | 17 -----------------
 drivers/staging/iio/imu/Makefile                        |  7 -------
 9 files changed, 14 insertions(+), 26 deletions(-)
 rename drivers/{staging => }/iio/imu/adis16400.h (100%)
 rename drivers/{staging/iio/imu/adis16400_ring.c => iio/imu/adis16400_buffer.c} (100%)
 rename drivers/{staging => }/iio/imu/adis16400_core.c (100%)
 delete mode 100644 drivers/staging/iio/imu/Kconfig
 delete mode 100644 drivers/staging/iio/imu/Makefile

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 3d79a40..47f66ed 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -3,6 +3,17 @@
 #
 menu "Inertial measurement units"
 
+config ADIS16400
+	tristate "Analog Devices ADIS16400 and similar IMU SPI driver"
+	depends on SPI
+	select IIO_ADIS_LIB
+	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
+	help
+	  Say yes here to build support for Analog Devices adis16300, adis16344,
+	  adis16350, adis16354, adis16355, adis16360, adis16362, adis16364,
+	  adis16365, adis16400 and adis16405 triaxial inertial sensors
+	  (adis16400 series also have magnetometers).
+
 config ADIS16480
 	tristate "Analog Devices ADIS16480 and similar IMU driver"
 	depends on SPI
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index cfe5763..019b717 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -2,6 +2,9 @@
 # Makefile for Inertial Measurement Units
 #
 
+adis16400-y             := adis16400_core.o
+adis16400-$(CONFIG_IIO_BUFFER) += adis16400_buffer.o
+obj-$(CONFIG_ADIS16400) += adis16400.o
 obj-$(CONFIG_ADIS16480) += adis16480.o
 
 adis_lib-y += adis.o
diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/iio/imu/adis16400.h
similarity index 100%
rename from drivers/staging/iio/imu/adis16400.h
rename to drivers/iio/imu/adis16400.h
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/iio/imu/adis16400_buffer.c
similarity index 100%
rename from drivers/staging/iio/imu/adis16400_ring.c
rename to drivers/iio/imu/adis16400_buffer.c
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
similarity index 100%
rename from drivers/staging/iio/imu/adis16400_core.c
rename to drivers/iio/imu/adis16400_core.c
diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index ca56c75..94d60d5 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -32,7 +32,6 @@ source "drivers/staging/iio/cdc/Kconfig"
 source "drivers/staging/iio/frequency/Kconfig"
 source "drivers/staging/iio/gyro/Kconfig"
 source "drivers/staging/iio/impedance-analyzer/Kconfig"
-source "drivers/staging/iio/imu/Kconfig"
 source "drivers/staging/iio/light/Kconfig"
 source "drivers/staging/iio/magnetometer/Kconfig"
 source "drivers/staging/iio/meter/Kconfig"
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index fa6937d..468b7f8 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -20,7 +20,6 @@ obj-y += cdc/
 obj-y += frequency/
 obj-y += gyro/
 obj-y += impedance-analyzer/
-obj-y += imu/
 obj-y += light/
 obj-y += magnetometer/
 obj-y += meter/
diff --git a/drivers/staging/iio/imu/Kconfig b/drivers/staging/iio/imu/Kconfig
deleted file mode 100644
index 096afc8..0000000
--- a/drivers/staging/iio/imu/Kconfig
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# IIO imu drivers configuration
-#
-menu "Inertial measurement units"
-
-config ADIS16400
-	tristate "Analog Devices ADIS16400 and similar IMU SPI driver"
-	depends on SPI
-	select IIO_ADIS_LIB
-	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
-	help
-	  Say yes here to build support for Analog Devices adis16300, adis16344,
-	  adis16350, adis16354, adis16355, adis16360, adis16362, adis16364,
-	  adis16365, adis16400 and adis16405 triaxial inertial sensors
-	  (adis16400 series also have magnetometers).
-
-endmenu
diff --git a/drivers/staging/iio/imu/Makefile b/drivers/staging/iio/imu/Makefile
deleted file mode 100644
index c9988f6..0000000
--- a/drivers/staging/iio/imu/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Makefile for Inertial Measurement Units
-#
-
-adis16400-y             := adis16400_core.o
-adis16400-$(CONFIG_IIO_BUFFER) += adis16400_ring.o
-obj-$(CONFIG_ADIS16400) += adis16400.o
-- 
1.8.0

