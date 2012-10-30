Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-175.synserver.de ([212.40.185.175]:1304 "EHLO
	smtp-out-175.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758214Ab2J3K0b (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Oct 2012 06:26:31 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] staging:iio:adis16400: Remove now duplicated chip_table entry
Date: Tue, 30 Oct 2012 11:26:26 +0100
Message-Id: <1351592787-2934-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1351592787-2934-1-git-send-email-lars@metafoo.de>
References: <1351592787-2934-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ADIS1360 and ADIS13605 are very similar and do have the same software
interface. The only difference is the contents of the PROD_ID register. Since we
now read the product id from the device name instead of the chip_info struct we
can use the same chip_table entry for both the ADIS1360 and ADIS13605.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400_core.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 608bb69..b49858e 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -38,7 +38,6 @@ enum adis16400_chip_variant {
 	ADIS16360,
 	ADIS16362,
 	ADIS16364,
-	ADIS16365,
 	ADIS16400,
 };
 
@@ -1185,18 +1184,6 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
 	},
-	[ADIS16365] = {
-		.channels = adis16350_channels,
-		.num_channels = ARRAY_SIZE(adis16350_channels),
-		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE,
-		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
-		.accel_scale_micro = IIO_G_TO_M_S_2(1000), /* 1 mg */
-		.temp_scale_nano = 136000000, /* 0.136 C */
-		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
-		.default_scan_mask = 0x7FF,
-		.set_freq = adis16400_set_freq,
-		.get_freq = adis16400_get_freq,
-	},
 	[ADIS16400] = {
 		.channels = adis16400_channels,
 		.num_channels = ARRAY_SIZE(adis16400_channels),
@@ -1309,7 +1296,7 @@ static const struct spi_device_id adis16400_id[] = {
 	{"adis16360", ADIS16360},
 	{"adis16362", ADIS16362},
 	{"adis16364", ADIS16364},
-	{"adis16365", ADIS16365},
+	{"adis16365", ADIS16360},
 	{"adis16400", ADIS16400},
 	{"adis16405", ADIS16400},
 	{}
-- 
1.8.0

