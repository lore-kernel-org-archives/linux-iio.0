Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-051.synserver.de ([212.40.185.51]:1116 "EHLO
	smtp-out-051.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727Ab3GQOoO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 10:44:14 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 15/15] staging:iio:adis16260: Move out of staging
Date: Wed, 17 Jul 2013 16:44:39 +0200
Message-Id: <1374072279-7140-15-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-1-git-send-email-lars@metafoo.de>
References: <1374072279-7140-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The drivers is in more or less good shape, conforms to the IIO ABI and none of
the default static code checker report any problems, so move it out of staging.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/gyro/Kconfig                                     | 12 ++++++++++++
 drivers/iio/gyro/Makefile                                    |  1 +
 .../iio/gyro/adis16260_core.c => iio/gyro/adis16260.c}       |  0
 drivers/staging/iio/gyro/Kconfig                             | 12 ------------
 drivers/staging/iio/gyro/Makefile                            |  3 ---
 5 files changed, 13 insertions(+), 15 deletions(-)
 rename drivers/{staging/iio/gyro/adis16260_core.c => iio/gyro/adis16260.c} (100%)

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 5913735..41c64a4 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -28,6 +28,18 @@ config ADIS16136
 	  Say yes here to build support for the Analog Devices ADIS16133, ADIS16135,
 	  ADIS16136 gyroscope devices.
 
+config ADIS16260
+	tristate "Analog Devices ADIS16260 Digital Gyroscope Sensor SPI driver"
+	depends on SPI
+	select IIO_ADIS_LIB
+	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
+	help
+	  Say yes here to build support for Analog Devices ADIS16260 ADIS16265
+	  ADIS16250 ADIS16255 and ADIS16251 programmable digital gyroscope sensors.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called adis16260.
+
 config ADXRS450
 	tristate "Analog Devices ADXRS450/3 Digital Output Gyroscope SPI driver"
 	depends on SPI
diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
index 36091d5..2f2752a 100644
--- a/drivers/iio/gyro/Makefile
+++ b/drivers/iio/gyro/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_ADIS16080) += adis16080.o
 obj-$(CONFIG_ADIS16130) += adis16130.o
 obj-$(CONFIG_ADIS16136) += adis16136.o
+obj-$(CONFIG_ADIS16260) += adis16260.o
 obj-$(CONFIG_ADXRS450) += adxrs450.o
 
 obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/iio/gyro/adis16260.c
similarity index 100%
rename from drivers/staging/iio/gyro/adis16260_core.c
rename to drivers/iio/gyro/adis16260.c
diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
index b433371..88b199b 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -10,16 +10,4 @@ config ADIS16060
 	  Say yes here to build support for Analog Devices adis16060 wide bandwidth
 	  yaw rate gyroscope with SPI.
 
-config ADIS16260
-	tristate "Analog Devices ADIS16260 Digital Gyroscope Sensor SPI driver"
-	depends on SPI
-	select IIO_ADIS_LIB
-	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
-	help
-	  Say yes here to build support for Analog Devices ADIS16260 ADIS16265
-	  ADIS16250 ADIS16255 and ADIS16251 programmable digital gyroscope sensors.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called adis16260.
-
 endmenu
diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Makefile
index 975f95b..cf22d6d 100644
--- a/drivers/staging/iio/gyro/Makefile
+++ b/drivers/staging/iio/gyro/Makefile
@@ -4,6 +4,3 @@
 
 adis16060-y             := adis16060_core.o
 obj-$(CONFIG_ADIS16060) += adis16060.o
-
-adis16260-y             := adis16260_core.o
-obj-$(CONFIG_ADIS16260) += adis16260.o
-- 
1.8.0

