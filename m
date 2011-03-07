Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk, manuel.stahl@iis.fraunhofer.de
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] IIO: IMU: ADIS16400: Fix miscellaneous issues
Date: Mon, 7 Mar 2011 12:30:51 +0100
Message-ID: <1299497451-31554-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Fix up SPI messages cs_change behavior
Add delay after self test
Fix product ID check, skip embedded revision number.
Fix addresses of GYRO and ACCEL calibration offset.
Make sure only enabled scan_elements are pushed into the ring

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/imu/adis16400.h      |    5 +++--
 drivers/staging/iio/imu/adis16400_core.c |   23 +++++++++++------------
 drivers/staging/iio/imu/adis16400_ring.c |   14 +++++++++-----
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index 6ff33e1..172b09c 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -17,7 +17,8 @@
 #ifndef SPI_ADIS16400_H_
 #define SPI_ADIS16400_H_
 
-#define ADIS16400_STARTUP_DELAY	220 /* ms */
+#define ADIS16400_STARTUP_DELAY	290 /* ms */
+#define ADIS16400_MTEST_DELAY 90 /* ms */
 
 #define ADIS16400_READ_REG(a)    a
 #define ADIS16400_WRITE_REG(a) ((a) | 0x80)
@@ -67,7 +68,7 @@
 #define ADIS16400_AUX_DAC   0x4A /* Auxiliary DAC data */
 
 #define ADIS16400_PRODUCT_ID 0x56 /* Product identifier */
-#define ADIS16400_PRODUCT_ID_DEFAULT 0x4015	/* Datasheet says 0x4105, I get 0x4015 */
+#define ADIS16400_PRODUCT_ID_DEFAULT 0x4000
 
 #define ADIS16400_ERROR_ACTIVE			(1<<14)
 #define ADIS16400_NEW_DATA			(1<<14)
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index cfb108a..1f9fff6 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -6,6 +6,7 @@
  *
  * Copyright (c) 2009 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
  * Copyright (c) 2007 Jonathan Cameron <jic23@cam.ac.uk>
+ * Copyright (c) 2011 Analog Devices Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -88,12 +89,10 @@ static int adis16400_spi_write_reg_16(struct device *dev,
 			.tx_buf = st->tx,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 		}, {
 			.tx_buf = st->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 		},
 	};
 
@@ -132,12 +131,10 @@ static int adis16400_spi_read_reg_16(struct device *dev,
 			.tx_buf = st->tx,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 		}, {
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 		},
 	};
 
@@ -375,7 +372,7 @@ static int adis16400_self_test(struct device *dev)
 		dev_err(dev, "problem starting self test");
 		goto err_ret;
 	}
-
+	msleep(ADIS16400_MTEST_DELAY);
 	adis16400_check_status(dev);
 
 err_ret:
@@ -454,6 +451,7 @@ static int adis16400_initial_setup(struct adis16400_state *st)
 		goto err_ret;
 	}
 
+
 	/* Read status register to check the result */
 	ret = adis16400_check_status(dev);
 	if (ret) {
@@ -471,10 +469,11 @@ static int adis16400_initial_setup(struct adis16400_state *st)
 	if (ret)
 		goto err_ret;
 
-	if (prod_id != ADIS16400_PRODUCT_ID_DEFAULT)
+	if ((prod_id & 0xF000) != ADIS16400_PRODUCT_ID_DEFAULT)
 		dev_warn(dev, "unknown product id");
 
-	printk(KERN_INFO DRIVER_NAME ": prod_id 0x%04x at CS%d (irq %d)\n",
+
+	dev_info(dev, ": prod_id 0x%04x at CS%d (irq %d)\n",
 			prod_id, st->us->chip_select, st->us->irq);
 
 	/* use high spi speed if possible */
@@ -497,12 +496,12 @@ err_ret:
 			_reg)
 
 static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_X, ADIS16400_XGYRO_OFF);
-static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_Y, ADIS16400_XGYRO_OFF);
-static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_Z, ADIS16400_XGYRO_OFF);
+static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_Y, ADIS16400_YGYRO_OFF);
+static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_Z, ADIS16400_ZGYRO_OFF);
 
 static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_X, ADIS16400_XACCL_OFF);
-static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_Y, ADIS16400_XACCL_OFF);
-static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_Z, ADIS16400_XACCL_OFF);
+static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_Y, ADIS16400_YACCL_OFF);
+static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_Z, ADIS16400_ZACCL_OFF);
 
 
 static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply, adis16400_read_14bit_signed,
@@ -647,7 +646,7 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 
 	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
 	if (ret) {
-		printk(KERN_ERR "failed to initialize the ring\n");
+		dev_err(&spi->dev, "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
 	}
 
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 33293fb..5a04e38 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -122,12 +122,10 @@ static int adis16400_spi_read_burst(struct device *dev, u8 *rx)
 			.tx_buf = st->tx,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 0,
 		}, {
 			.rx_buf = rx,
 			.bits_per_word = 8,
 			.len = 24,
-			.cs_change = 1,
 		},
 	};
 
@@ -162,9 +160,10 @@ static void adis16400_trigger_bh_to_ring(struct work_struct *work_s)
 			       work_trigger_to_ring);
 	struct iio_ring_buffer *ring = st->indio_dev->ring;
 
-	int i = 0;
+	int i = 0, j;
 	s16 *data;
 	size_t datasize = ring->access.get_bytes_per_datum(ring);
+	unsigned long mask = ring->scan_mask;
 
 	data = kmalloc(datasize , GFP_KERNEL);
 	if (data == NULL) {
@@ -174,9 +173,14 @@ static void adis16400_trigger_bh_to_ring(struct work_struct *work_s)
 
 	if (ring->scan_count)
 		if (adis16400_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < ring->scan_count; i++)
+			for (; i < ring->scan_count; i++) {
+				j = __ffs(mask);
+				mask &= ~(1 << j);
 				data[i]	= be16_to_cpup(
-					(__be16 *)&(st->rx[i*2]));
+					(__be16 *)&(st->rx[j*2]));
+
+			}
+
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
-- 
1.6.0.2
