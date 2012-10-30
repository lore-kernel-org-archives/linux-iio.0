Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-175.synserver.de ([212.40.185.175]:1300 "EHLO
	smtp-out-175.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758004Ab2J3K0a (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Oct 2012 06:26:30 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] staging:iio:adis16400: Fix product id check
Date: Tue, 30 Oct 2012 11:26:25 +0100
Message-Id: <1351592787-2934-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1351592787-2934-1-git-send-email-lars@metafoo.de>
References: <1351592787-2934-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The product id check currently ANDs the read id with 0xF000 and compares the
result to the product id from the chip info. Since none of the product ids in
the chip info table end in 0x000 the check will always fail. Furthermore it is
also wrong, the product id in the PROD_ID register will always match the part
number of the device.

Some of the ADIS16XXX devices are identical from a software point of
view with the product id register having a different content. If we keep the
current scheme of storing the product id in the chip info table this would
require us to have multiple almost identical chip info table entries. So instead
this patch changes the code to parse the product id from the device name.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400.h      |  1 -
 drivers/staging/iio/imu/adis16400_core.c | 13 ++++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index 07a6aea..7a105e9 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -140,7 +140,6 @@
 struct adis16400_chip_info {
 	const struct iio_chan_spec *channels;
 	const int num_channels;
-	const int product_id;
 	const long flags;
 	unsigned int gyro_scale_micro;
 	unsigned int accel_scale_micro;
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 4d03bdc..608bb69 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -415,6 +415,7 @@ static int adis16400_initial_setup(struct iio_dev *indio_dev)
 {
 	int ret;
 	u16 prod_id, smp_prd;
+	unsigned int device_id;
 	struct adis16400_state *st = iio_priv(indio_dev);
 
 	/* use low spi speed for init if the device has a slow mode */
@@ -454,8 +455,11 @@ static int adis16400_initial_setup(struct iio_dev *indio_dev)
 		if (ret)
 			goto err_ret;
 
-		if ((prod_id & 0xF000) != st->variant->product_id)
-			dev_warn(&indio_dev->dev, "incorrect id");
+		sscanf(indio_dev->name, "adis%u\n", &device_id);
+
+		if (prod_id != device_id)
+			dev_warn(&indio_dev->dev, "Device ID(%u) and product ID(%u) do not match.",
+					device_id, prod_id);
 
 		dev_info(&indio_dev->dev, "%s: prod_id 0x%04x at CS%d (irq %d)\n",
 		       indio_dev->name, prod_id,
@@ -1149,7 +1153,6 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.channels = adis16350_channels,
 		.num_channels = ARRAY_SIZE(adis16350_channels),
 		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE,
-		.product_id = 0x3FE8,
 		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
 		.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
 		.temp_scale_nano = 136000000, /* 0.136 C */
@@ -1162,7 +1165,6 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.channels = adis16350_channels,
 		.num_channels = ARRAY_SIZE(adis16350_channels),
 		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE,
-		.product_id = 0x3FEA,
 		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
 		.accel_scale_micro = IIO_G_TO_M_S_2(333), /* 0.333 mg */
 		.temp_scale_nano = 136000000, /* 0.136 C */
@@ -1175,7 +1177,6 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.channels = adis16350_channels,
 		.num_channels = ARRAY_SIZE(adis16350_channels),
 		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE,
-		.product_id = 0x3FEC,
 		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
 		.accel_scale_micro = IIO_G_TO_M_S_2(1000), /* 1 mg */
 		.temp_scale_nano = 136000000, /* 0.136 C */
@@ -1188,7 +1189,6 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.channels = adis16350_channels,
 		.num_channels = ARRAY_SIZE(adis16350_channels),
 		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE,
-		.product_id = 0x3FED,
 		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
 		.accel_scale_micro = IIO_G_TO_M_S_2(1000), /* 1 mg */
 		.temp_scale_nano = 136000000, /* 0.136 C */
@@ -1201,7 +1201,6 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.channels = adis16400_channels,
 		.num_channels = ARRAY_SIZE(adis16400_channels),
 		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE,
-		.product_id = 0x4015,
 		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
 		.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
 		.default_scan_mask = 0xFFF,
-- 
1.8.0

