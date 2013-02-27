Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59134 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759401Ab3B0UkT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:19 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 38/67] iio:imu:adis16480 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:44 +0000
Message-Id: <1361997553-31058-39-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/adis16480.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 8c26a5f..f68680c 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -591,15 +591,15 @@ static int adis16480_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
-#define ADIS16480_MOD_CHANNEL(_type, _mod, _address, _si, _info, _bits) \
+#define ADIS16480_MOD_CHANNEL(_type, _mod, _address, _si, _info_sep, _bits) \
 	{ \
 		.type = (_type), \
 		.modified = 1, \
 		.channel2 = (_mod), \
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-			IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT | \
-			IIO_CHAN_INFO_SCALE_SHARED_BIT | \
-			_info, \
+		.info_mask_separate = IIO_CHAN_INFO_RAW | \
+			IIO_CHAN_INFO_CALIBBIAS | \
+			_info_sep, \
+		.info_mask_shared_by_type = IIO_CHAN_INFO_SCALE,	\
 		.address = (_address), \
 		.scan_index = (_si), \
 		.scan_type = { \
@@ -613,21 +613,21 @@ static int adis16480_write_raw(struct iio_dev *indio_dev,
 #define ADIS16480_GYRO_CHANNEL(_mod) \
 	ADIS16480_MOD_CHANNEL(IIO_ANGL_VEL, IIO_MOD_ ## _mod, \
 	ADIS16480_REG_ ## _mod ## _GYRO_OUT, ADIS16480_SCAN_GYRO_ ## _mod, \
-	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SEPARATE_BIT | \
-	IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT, \
+	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY | \
+	IIO_CHAN_INFO_CALIBSCALE, \
 	32)
 
 #define ADIS16480_ACCEL_CHANNEL(_mod) \
 	ADIS16480_MOD_CHANNEL(IIO_ACCEL, IIO_MOD_ ## _mod, \
 	ADIS16480_REG_ ## _mod ## _ACCEL_OUT, ADIS16480_SCAN_ACCEL_ ## _mod, \
-	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SEPARATE_BIT | \
-	IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT, \
+	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY | \
+	IIO_CHAN_INFO_CALIBSCALE, \
 	32)
 
 #define ADIS16480_MAGN_CHANNEL(_mod) \
 	ADIS16480_MOD_CHANNEL(IIO_MAGN, IIO_MOD_ ## _mod, \
 	ADIS16480_REG_ ## _mod ## _MAGN_OUT, ADIS16480_SCAN_MAGN_ ## _mod, \
-	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SEPARATE_BIT, \
+	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY, \
 	16)
 
 #define ADIS16480_PRESSURE_CHANNEL() \
@@ -635,9 +635,9 @@ static int adis16480_write_raw(struct iio_dev *indio_dev,
 		.type = IIO_PRESSURE, \
 		.indexed = 1, \
 		.channel = 0, \
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-			IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT | \
-			IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
+		.info_mask_separate = IIO_CHAN_INFO_RAW | \
+			IIO_CHAN_INFO_CALIBBIAS | \
+			IIO_CHAN_INFO_SCALE, \
 		.address = ADIS16480_REG_BAROM_OUT, \
 		.scan_index = ADIS16480_SCAN_BARO, \
 		.scan_type = { \
@@ -652,9 +652,9 @@ static int adis16480_write_raw(struct iio_dev *indio_dev,
 		.type = IIO_TEMP, \
 		.indexed = 1, \
 		.channel = 0, \
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-			IIO_CHAN_INFO_SCALE_SEPARATE_BIT | \
-			IIO_CHAN_INFO_OFFSET_SEPARATE_BIT, \
+		.info_mask_separate = IIO_CHAN_INFO_RAW | \
+			IIO_CHAN_INFO_SCALE | \
+			IIO_CHAN_INFO_OFFSET, \
 		.address = ADIS16480_REG_TEMP_OUT, \
 		.scan_index = ADIS16480_SCAN_TEMP, \
 		.scan_type = { \
-- 
1.8.1.1

