Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-232.synserver.de ([212.40.185.232]:1123 "EHLO
	smtp-out-230.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751797AbbHENij (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2015 09:38:39 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/9] iio: adis16400: Add ADIS16367 support
Date: Wed,  5 Aug 2015 15:38:19 +0200
Message-Id: <1438781901-28000-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1438781901-28000-1-git-send-email-lars@metafoo.de>
References: <1438781901-28000-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ADIS16367 is mostly register compatible to the ADIS16360. The only
difference is the scale factor for the gyroscope output.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/adis16400_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index e4cc2ec..a9f4043 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -139,6 +139,7 @@ enum adis16400_chip_variant {
 	ADIS16360,
 	ADIS16362,
 	ADIS16364,
+	ADIS16367,
 	ADIS16400,
 	ADIS16448,
 };
@@ -764,6 +765,18 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
 	},
+	[ADIS16367] = {
+		.channels = adis16350_channels,
+		.num_channels = ARRAY_SIZE(adis16350_channels),
+		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
+				ADIS16400_HAS_SERIAL_NUMBER,
+		.gyro_scale_micro = IIO_DEGREE_TO_RAD(2000), /* 0.2 deg/s */
+		.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
+		.temp_scale_nano = 136000000, /* 0.136 C */
+		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
+		.set_freq = adis16400_set_freq,
+		.get_freq = adis16400_get_freq,
+	},
 	[ADIS16400] = {
 		.channels = adis16400_channels,
 		.num_channels = ARRAY_SIZE(adis16400_channels),
@@ -936,6 +949,7 @@ static const struct spi_device_id adis16400_id[] = {
 	{"adis16362", ADIS16362},
 	{"adis16364", ADIS16364},
 	{"adis16365", ADIS16360},
+	{"adis16367", ADIS16367},
 	{"adis16400", ADIS16400},
 	{"adis16405", ADIS16400},
 	{"adis16448", ADIS16448},
-- 
2.1.4

