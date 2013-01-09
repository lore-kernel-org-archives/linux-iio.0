Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-052.synserver.de ([212.40.185.52]:1096 "EHLO
	smtp-out-052.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757811Ab3AIOAw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jan 2013 09:00:52 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/7] staging:iio:adis16080: Move out of staging
Date: Wed,  9 Jan 2013 15:01:19 +0100
Message-Id: <1357740079-12326-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1357740079-12326-1-git-send-email-lars@metafoo.de>
References: <1357740079-12326-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver is rather simple and in a good shape. It follows the IIO ABI and the
standard codechecker tools do not report any issues, so move it out of staging.

While moving it also remove one outdated 'fixme' comment.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/gyro/Kconfig                                           | 7 +++++++
 drivers/iio/gyro/Makefile                                          | 1 +
 .../{staging/iio/gyro/adis16080_core.c => iio/gyro/adis16080.c}    | 1 -
 drivers/staging/iio/gyro/Kconfig                                   | 7 -------
 drivers/staging/iio/gyro/Makefile                                  | 3 ---
 5 files changed, 8 insertions(+), 11 deletions(-)
 rename drivers/{staging/iio/gyro/adis16080_core.c => iio/gyro/adis16080.c} (99%)

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 48ed148..e8d3a56 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -3,6 +3,13 @@
 #
 menu "Digital gyroscope sensors"
 
+config ADIS16080
+	tristate "Analog Devices ADIS16080/100 Yaw Rate Gyroscope with SPI driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices ADIS16080, ADIS16100 Yaw
+	  Rate Gyroscope with SPI.
+
 config ADIS16136
 	tristate "Analog devices ADIS16136 and similar gyroscopes driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
index 702a058..9b090ee 100644
--- a/drivers/iio/gyro/Makefile
+++ b/drivers/iio/gyro/Makefile
@@ -2,5 +2,6 @@
 # Makefile for industrial I/O gyroscope sensor drivers
 #
 
+obj-$(CONFIG_ADIS16080) += adis16080.o
 obj-$(CONFIG_ADIS16136) += adis16136.o
 obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/iio/gyro/adis16080.c
similarity index 99%
rename from drivers/staging/iio/gyro/adis16080_core.c
rename to drivers/iio/gyro/adis16080.c
index 1dde3c7..ce23a23 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/iio/gyro/adis16080.c
@@ -228,7 +228,6 @@ error_ret:
 	return ret;
 }
 
-/* fixme, confirm ordering in this function */
 static int adis16080_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
index 2f9467e..b307c31 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -10,13 +10,6 @@ config ADIS16060
 	  Say yes here to build support for Analog Devices adis16060 wide bandwidth
 	  yaw rate gyroscope with SPI.
 
-config ADIS16080
-	tristate "Analog Devices ADIS16080/100 Yaw Rate Gyroscope with SPI driver"
-	depends on SPI
-	help
-	  Say yes here to build support for Analog Devices ADIS16080, ADIS16100 Yaw
-	  Rate Gyroscope with SPI.
-
 config ADIS16130
 	tristate "Analog Devices ADIS16130 High Precision Angular Rate Sensor driver"
 	depends on SPI
diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Makefile
index 1303569..8d6f60e 100644
--- a/drivers/staging/iio/gyro/Makefile
+++ b/drivers/staging/iio/gyro/Makefile
@@ -5,9 +5,6 @@
 adis16060-y             := adis16060_core.o
 obj-$(CONFIG_ADIS16060) += adis16060.o
 
-adis16080-y             := adis16080_core.o
-obj-$(CONFIG_ADIS16080) += adis16080.o
-
 adis16130-y             := adis16130_core.o
 obj-$(CONFIG_ADIS16130) += adis16130.o
 
-- 
1.8.0

