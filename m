Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-072.synserver.de ([212.40.185.72]:1212 "EHLO
	smtp-out-072.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756640Ab2JDNdD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Oct 2012 09:33:03 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio: Remove unused DRIVER_NAME defines
Date: Thu,  4 Oct 2012 15:33:55 +0200
Message-Id: <1349357635-19910-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some drivers define a DRIVER_NAME, but never use the define. This patch removes
defines.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/adis16203_core.c |    2 --
 drivers/staging/iio/accel/adis16204_core.c |    2 --
 drivers/staging/iio/accel/adis16209_core.c |    2 --
 drivers/staging/iio/accel/adis16220_core.c |    2 --
 drivers/staging/iio/accel/adis16240_core.c |    2 --
 drivers/staging/iio/gyro/adis16260_core.c  |    2 --
 drivers/staging/iio/meter/ade7753.h        |    2 --
 drivers/staging/iio/meter/ade7754.h        |    2 --
 drivers/staging/iio/meter/ade7758.h        |    3 ---
 drivers/staging/iio/meter/ade7759.h        |    2 --
 drivers/staging/iio/meter/ade7854.h        |    2 --
 11 files changed, 23 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 002fa9d..2064710 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -21,8 +21,6 @@
 
 #include "adis16203.h"
 
-#define DRIVER_NAME		"adis16203"
-
 /**
  * adis16203_spi_write_reg_8() - write single byte to a register
  * @indio_dev: iio device associated with child of actual device
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 05bdb7c..bd99d90 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -24,8 +24,6 @@
 
 #include "adis16204.h"
 
-#define DRIVER_NAME		"adis16204"
-
 /**
  * adis16204_spi_write_reg_8() - write single byte to a register
  * @dev: device associated with child of actual device (iio_dev or iio_trig)
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index b7333bf..693f65d 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -22,8 +22,6 @@
 
 #include "adis16209.h"
 
-#define DRIVER_NAME		"adis16209"
-
 /**
  * adis16209_spi_write_reg_8() - write single byte to a register
  * @indio_dev: iio device associated with actual device
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index c755089..adf70b7 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -20,8 +20,6 @@
 
 #include "adis16220.h"
 
-#define DRIVER_NAME		"adis16220"
-
 /**
  * adis16220_spi_write_reg_8() - write single byte to a register
  * @indio_dev: iio device associated with child of actual device
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 0fc26a4..9f48611 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -25,8 +25,6 @@
 
 #include "adis16240.h"
 
-#define DRIVER_NAME		"adis16240"
-
 static int adis16240_check_status(struct iio_dev *indio_dev);
 
 /**
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 9571c03..9e22a50 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -24,8 +24,6 @@
 
 #include "adis16260.h"
 
-#define DRIVER_NAME		"adis16260"
-
 static int adis16260_check_status(struct iio_dev *indio_dev);
 
 /**
diff --git a/drivers/staging/iio/meter/ade7753.h b/drivers/staging/iio/meter/ade7753.h
index 3f059d3..a9d93cc 100644
--- a/drivers/staging/iio/meter/ade7753.h
+++ b/drivers/staging/iio/meter/ade7753.h
@@ -55,8 +55,6 @@
 #define ADE7753_SPI_BURST	(u32)(1000 * 1000)
 #define ADE7753_SPI_FAST	(u32)(2000 * 1000)
 
-#define DRIVER_NAME		"ade7753"
-
 /**
  * struct ade7753_state - device instance specific data
  * @us:			actual spi_device
diff --git a/drivers/staging/iio/meter/ade7754.h b/drivers/staging/iio/meter/ade7754.h
index 6121125..e42ffc3 100644
--- a/drivers/staging/iio/meter/ade7754.h
+++ b/drivers/staging/iio/meter/ade7754.h
@@ -73,8 +73,6 @@
 #define ADE7754_SPI_BURST	(u32)(1000 * 1000)
 #define ADE7754_SPI_FAST	(u32)(2000 * 1000)
 
-#define DRIVER_NAME		"ade7754"
-
 /**
  * struct ade7754_state - device instance specific data
  * @us:			actual spi_device
diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
index 1e11ad5..0731820 100644
--- a/drivers/staging/iio/meter/ade7758.h
+++ b/drivers/staging/iio/meter/ade7758.h
@@ -105,9 +105,6 @@
 #define AD7758_APP_PWR		4
 #define AD7758_WT(p, w)		(((w) << 2) | (p))
 
-#define DRIVER_NAME		"ade7758"
-
-
 /**
  * struct ade7758_state - device instance specific data
  * @us:			actual spi_device
diff --git a/drivers/staging/iio/meter/ade7759.h b/drivers/staging/iio/meter/ade7759.h
index c81d23d..f9ff1f8 100644
--- a/drivers/staging/iio/meter/ade7759.h
+++ b/drivers/staging/iio/meter/ade7759.h
@@ -36,8 +36,6 @@
 #define ADE7759_SPI_BURST	(u32)(1000 * 1000)
 #define ADE7759_SPI_FAST	(u32)(2000 * 1000)
 
-#define DRIVER_NAME		"ade7759"
-
 /**
  * struct ade7759_state - device instance specific data
  * @us:			actual spi_device
diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index 2c96e86..0653457 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -142,8 +142,6 @@
 #define ADE7854_SPI_BURST	(u32)(1000 * 1000)
 #define ADE7854_SPI_FAST	(u32)(2000 * 1000)
 
-#define DRIVER_NAME		"ade7854"
-
 /**
  * struct ade7854_state - device instance specific data
  * @spi:			actual spi_device
-- 
1.7.10.4

