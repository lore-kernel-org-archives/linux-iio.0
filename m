Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:35873 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab2DVMNf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Apr 2012 08:13:35 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 01/14] staging:iio:accel switch select kconfig elements to depends.
Date: Sun, 22 Apr 2012 13:13:26 +0100
Message-Id: <1335096819-19565-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1335096819-19565-1-git-send-email-jic23@kernel.org>
References: <1335096819-19565-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As we are moving the IIO core out of staging, we need to
stop drivers in staging controlling whether elements of the
core are built.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/Kconfig |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index 5ab7167..c445575 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -6,8 +6,7 @@ menu "Accelerometers"
 config ADIS16201
 	tristate "Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer"
 	depends on SPI
-	select IIO_TRIGGER if IIO_BUFFER
-	select IIO_SW_RING if IIO_BUFFER
+	depends on !IIO_BUFFER || (IIO_TRIGGER && IIO_SW_RING)
 	help
 	  Say yes here to build support for Analog Devices adis16201 dual-axis
 	  digital inclinometer and accelerometer.
@@ -15,8 +14,7 @@ config ADIS16201
 config ADIS16203
 	tristate "Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer"
 	depends on SPI
-	select IIO_TRIGGER if IIO_BUFFER
-	select IIO_SW_RING if IIO_BUFFER
+	depends on !IIO_BUFFER || (IIO_TRIGGER && IIO_SW_RING)
 	help
 	  Say yes here to build support for Analog Devices adis16203 Programmable
 	  360 Degrees Inclinometer.
@@ -24,8 +22,7 @@ config ADIS16203
 config ADIS16204
 	tristate "Analog Devices ADIS16204 Programmable High-g Digital Impact Sensor and Recorder"
 	depends on SPI
-	select IIO_TRIGGER if IIO_BUFFER
-	select IIO_SW_RING if IIO_BUFFER
+	depends on !IIO_BUFFER || (IIO_TRIGGER && IIO_SW_RING)
 	help
 	  Say yes here to build support for Analog Devices adis16204 Programmable
 	  High-g Digital Impact Sensor and Recorder.
@@ -33,8 +30,7 @@ config ADIS16204
 config ADIS16209
 	tristate "Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer"
 	depends on SPI
-	select IIO_TRIGGER if IIO_BUFFER
-	select IIO_SW_RING if IIO_BUFFER
+	depends on !IIO_BUFFER || (IIO_TRIGGER && IIO_SW_RING)
 	help
 	  Say yes here to build support for Analog Devices adis16209 dual-axis digital inclinometer
 	  and accelerometer.
@@ -49,8 +45,7 @@ config ADIS16220
 config ADIS16240
 	tristate "Analog Devices ADIS16240 Programmable Impact Sensor and Recorder"
 	depends on SPI
-	select IIO_TRIGGER if IIO_BUFFER
-	select IIO_SW_RING if IIO_BUFFER
+	depends on !IIO_BUFFER || (IIO_TRIGGER && IIO_SW_RING)
 	help
 	  Say yes here to build support for Analog Devices adis16240 programmable
 	  impact Sensor and recorder.
@@ -65,8 +60,7 @@ config KXSD9
 config LIS3L02DQ
 	tristate "ST Microelectronics LIS3L02DQ Accelerometer Driver"
 	depends on SPI
-	select IIO_TRIGGER if IIO_BUFFER
-	depends on !IIO_BUFFER || IIO_KFIFO_BUF || IIO_SW_RING
+	depends on !IIO_BUFFER || ((IIO_KFIFO_BUF || IIO_SW_RING) && IIO_TRIGGER)
 	depends on GENERIC_GPIO
 	help
 	  Say yes here to build SPI support for the ST microelectronics
-- 
1.7.9.4

