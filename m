Return-Path: <vapier@gentoo.org>
From: Mike Frysinger <vapier@gentoo.org>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Cc: device-drivers-devel@blackfin.uclinux.org,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 02/36] staging: iio: gyro: make sure grep can find the ADIS16265 support
Date: Tue, 26 Oct 2010 14:17:12 -0400
Message-Id: <1288117066-18055-3-git-send-email-vapier@gentoo.org>
In-Reply-To: <1288117066-18055-1-git-send-email-vapier@gentoo.org>
References: <1288117066-18055-1-git-send-email-vapier@gentoo.org>
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/staging/iio/gyro/Kconfig          |    7 +++++--
 drivers/staging/iio/gyro/adis16260_core.c |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
index c404361..d1dde82 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -4,10 +4,13 @@
 comment "Digital gyroscope sensors"
 
 config ADIS16260
-	tristate "Analog Devices ADIS16260/5 Digital Gyroscope Sensor SPI driver"
+	tristate "Analog Devices ADIS16260 ADIS16265 Digital Gyroscope Sensor SPI driver"
 	depends on SPI
 	select IIO_TRIGGER if IIO_RING_BUFFER
 	select IIO_SW_RING if IIO_RING_BUFFER
 	help
-	  Say yes here to build support for Analog Devices adis16260/5
+	  Say yes here to build support for Analog Devices ADIS16260 ADIS16265
 	  programmable digital gyroscope sensor.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called adis16260.
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 7d7716e..8190c0f 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -1,5 +1,5 @@
 /*
- * ADIS16260 Programmable Digital Gyroscope Sensor Driver
+ * ADIS16260/ADIS16265 Programmable Digital Gyroscope Sensor Driver
  *
  * Copyright 2010 Analog Devices Inc.
  *
-- 
1.7.3.2
