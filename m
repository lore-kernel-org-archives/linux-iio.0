Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:42272 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756040Ab3AFPKk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 6 Jan 2013 10:10:40 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/2] iio:accel:kxsd9 move out of staging
Date: Sun,  6 Jan 2013 15:10:17 +0000
Message-Id: <1357485017-27916-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1357485017-27916-1-git-send-email-jic23@kernel.org>
References: <1357485017-27916-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a very simple driver giving basic access to this part over an
spi bus.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/accel/Kconfig               | 7 +++++++
 drivers/iio/accel/Makefile              | 1 +
 drivers/{staging => }/iio/accel/kxsd9.c | 0
 drivers/staging/iio/accel/Kconfig       | 7 -------
 drivers/staging/iio/accel/Makefile      | 2 --
 5 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index fe4bcd7..a588764 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -13,4 +13,11 @@ config HID_SENSOR_ACCEL_3D
 	  Say yes here to build support for the HID SENSOR
 	  accelerometers 3D.
 
+config KXSD9
+	tristate "Kionix KXSD9 Accelerometer Driver"
+	depends on SPI
+	help
+	  Say yes here to build support for the Kionix KXSD9 accelerometer.
+	  Currently this only supports the device via an SPI interface.
+
 endmenu
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 5bc6855..4e1c859 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -3,3 +3,4 @@
 #
 
 obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
+obj-$(CONFIG_KXSD9)	+= kxsd9.o
diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
similarity index 100%
rename from drivers/staging/iio/accel/kxsd9.c
rename to drivers/iio/accel/kxsd9.c
diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index 2b54430..d10c7ad 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -56,13 +56,6 @@ config ADIS16240
 	  Say yes here to build support for Analog Devices adis16240 programmable
 	  impact Sensor and recorder.
 
-config KXSD9
-	tristate "Kionix KXSD9 Accelerometer Driver"
-	depends on SPI
-	help
-	  Say yes here to build support for the Kionix KXSD9 accelerometer.
-	  Currently this only supports the device via an SPI interface.
-
 config LIS3L02DQ
 	tristate "ST Microelectronics LIS3L02DQ Accelerometer Driver"
 	depends on SPI
diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
index 8e7ee03..1ed137f 100644
--- a/drivers/staging/iio/accel/Makefile
+++ b/drivers/staging/iio/accel/Makefile
@@ -20,8 +20,6 @@ obj-$(CONFIG_ADIS16220) += adis16220.o
 adis16240-y             := adis16240_core.o
 obj-$(CONFIG_ADIS16240) += adis16240.o
 
-obj-$(CONFIG_KXSD9)	+= kxsd9.o
-
 lis3l02dq-y		:= lis3l02dq_core.o
 lis3l02dq-$(CONFIG_IIO_BUFFER) += lis3l02dq_ring.o
 obj-$(CONFIG_LIS3L02DQ)	+= lis3l02dq.o
-- 
1.8.1

