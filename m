Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-108.synserver.de ([212.40.185.108]:1146 "EHLO
	smtp-out-108.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab3AaO1P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2013 09:27:15 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/11] staging:iio: Move adxrs450 driver out of staging
Date: Thu, 31 Jan 2013 15:27:58 +0100
Message-Id: <1359642478-9622-11-git-send-email-lars@metafoo.de>
In-Reply-To: <1359642478-9622-1-git-send-email-lars@metafoo.de>
References: <1359642478-9622-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The adxrs450 is in a reasonable shape now. It follows the IIO ABI and non of the
standard code checker tools report any issue, so move it out of staging.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/gyro/Kconfig                  | 10 ++++++++++
 drivers/iio/gyro/Makefile                 |  1 +
 drivers/{staging => }/iio/gyro/adxrs450.c |  0
 drivers/staging/iio/gyro/Kconfig          | 10 ----------
 drivers/staging/iio/gyro/Makefile         |  2 --
 5 files changed, 11 insertions(+), 12 deletions(-)
 rename drivers/{staging => }/iio/gyro/adxrs450.c (100%)

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index bbcb7ae..6227cbb 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -26,6 +26,16 @@ config ADIS16136
 	  Say yes here to build support for the Analog Devices ADIS16133, ADIS16135,
 	  ADIS16136 gyroscope devices.
 
+config ADXRS450
+	tristate "Analog Devices ADXRS450/3 Digital Output Gyroscope SPI driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices ADXRS450 and ADXRS453
+	  programmable digital output gyroscope.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called adxrs450.
+
 config HID_SENSOR_GYRO_3D
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
index 8410a76..94eba8d 100644
--- a/drivers/iio/gyro/Makefile
+++ b/drivers/iio/gyro/Makefile
@@ -5,4 +5,5 @@
 obj-$(CONFIG_ADIS16080) += adis16080.o
 obj-$(CONFIG_ADIS16130) += adis16130.o
 obj-$(CONFIG_ADIS16136) += adis16136.o
+obj-$(CONFIG_ADXRS450) += adxrs450.o
 obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
diff --git a/drivers/staging/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
similarity index 100%
rename from drivers/staging/iio/gyro/adxrs450.c
rename to drivers/iio/gyro/adxrs450.c
diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
index 073bfdc..b433371 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -22,14 +22,4 @@ config ADIS16260
 	  This driver can also be built as a module.  If so, the module
 	  will be called adis16260.
 
-config ADXRS450
-	tristate "Analog Devices ADXRS450/3 Digital Output Gyroscope SPI driver"
-	depends on SPI
-	help
-	  Say yes here to build support for Analog Devices ADXRS450 and ADXRS453
-	  programmable digital output gyroscope.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called adxrs450.
-
 endmenu
diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Makefile
index ad35e57..975f95b 100644
--- a/drivers/staging/iio/gyro/Makefile
+++ b/drivers/staging/iio/gyro/Makefile
@@ -7,5 +7,3 @@ obj-$(CONFIG_ADIS16060) += adis16060.o
 
 adis16260-y             := adis16260_core.o
 obj-$(CONFIG_ADIS16260) += adis16260.o
-
-obj-$(CONFIG_ADXRS450) += adxrs450.o
-- 
1.8.0

