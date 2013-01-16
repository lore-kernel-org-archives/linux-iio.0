Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-069.synserver.de ([212.40.185.69]:1266 "EHLO
	smtp-out-069.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab3APMsI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2013 07:48:08 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/15] staging:iio:adis16400: Remove unused default_scan_mask
Date: Wed, 16 Jan 2013 13:48:39 +0100
Message-Id: <1358340531-31350-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1358340531-31350-1-git-send-email-lars@metafoo.de>
References: <1358340531-31350-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The chip_info struct for contains a defaul_scan_mask field. But it is never
actually used in the code, so remove it from the chip_info struct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400.h      |  1 -
 drivers/staging/iio/imu/adis16400_core.c | 15 ---------------
 2 files changed, 16 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index 7a105e9..3efafcb 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -145,7 +145,6 @@ struct adis16400_chip_info {
 	unsigned int accel_scale_micro;
 	int temp_scale_nano;
 	int temp_offset;
-	unsigned long default_scan_mask;
 	int (*set_freq)(struct iio_dev *indio_dev, unsigned int freq);
 	int (*get_freq)(struct iio_dev *indio_dev);
 };
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 7114de9..24fca10 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -1116,12 +1116,6 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.accel_scale_micro = 5884,
 		.temp_scale_nano = 140000000, /* 0.14 C */
 		.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
-		.default_scan_mask = (1 << ADIS16400_SCAN_SUPPLY) |
-		(1 << ADIS16400_SCAN_GYRO_X) | (1 << ADIS16400_SCAN_ACC_X) |
-		(1 << ADIS16400_SCAN_ACC_Y) | (1 << ADIS16400_SCAN_ACC_Z) |
-		(1 << ADIS16400_SCAN_TEMP) | (1 << ADIS16400_SCAN_ADC_0) |
-		(1 << ADIS16300_SCAN_INCLI_X) | (1 << ADIS16300_SCAN_INCLI_Y) |
-		(1 << 14),
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
 	},
@@ -1133,10 +1127,6 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.accel_scale_micro = IIO_G_TO_M_S_2(1000), /* 1 mg */
 		.temp_scale_nano = 67850000, /* 0.06785 C */
 		.temp_offset = 25000000 / 67850, /* 25 C = 0x00 */
-		.default_scan_mask = (1 << ADIS16400_SCAN_GYRO_X) |
-		(1 << ADIS16400_SCAN_GYRO_Y) | (1 << ADIS16400_SCAN_GYRO_Z) |
-		(1 << ADIS16400_SCAN_ACC_X) | (1 << ADIS16400_SCAN_ACC_Y) |
-		(1 << ADIS16400_SCAN_ACC_Z),
 		.set_freq = adis16334_set_freq,
 		.get_freq = adis16334_get_freq,
 	},
@@ -1147,7 +1137,6 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.accel_scale_micro = IIO_G_TO_M_S_2(2522), /* 0.002522 g */
 		.temp_scale_nano = 145300000, /* 0.1453 C */
 		.temp_offset = 25000000 / 145300, /* 25 C = 0x00 */
-		.default_scan_mask = 0x7FF,
 		.flags = ADIS16400_NO_BURST | ADIS16400_HAS_SLOW_MODE,
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
@@ -1160,7 +1149,6 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
 		.temp_scale_nano = 136000000, /* 0.136 C */
 		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
-		.default_scan_mask = 0x7FF,
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
 	},
@@ -1172,7 +1160,6 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.accel_scale_micro = IIO_G_TO_M_S_2(333), /* 0.333 mg */
 		.temp_scale_nano = 136000000, /* 0.136 C */
 		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
-		.default_scan_mask = 0x7FF,
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
 	},
@@ -1184,7 +1171,6 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.accel_scale_micro = IIO_G_TO_M_S_2(1000), /* 1 mg */
 		.temp_scale_nano = 136000000, /* 0.136 C */
 		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
-		.default_scan_mask = 0x7FF,
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
 	},
@@ -1194,7 +1180,6 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE,
 		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
 		.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
-		.default_scan_mask = 0xFFF,
 		.temp_scale_nano = 140000000, /* 0.14 C */
 		.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
-- 
1.8.0

