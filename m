Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35735 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab3CBQRl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:41 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 37/67] iio:imu:adis16400 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:16:54 +0000
Message-Id: <1362241044-3534-38-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/adis16400_core.c | 47 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index b7f215e..2111068 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -484,8 +484,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 	.indexed = 1, \
 	.channel = 0, \
 	.extend_name = name, \
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
+	.info_mask_separate = IIO_CHAN_INFO_RAW | IIO_CHAN_INFO_SCALE, \
 	.address = (addr), \
 	.scan_index = (si), \
 	.scan_type = { \
@@ -507,10 +506,10 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 	.type = IIO_ANGL_VEL, \
 	.modified = 1, \
 	.channel2 = IIO_MOD_ ## mod, \
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT | \
-		IIO_CHAN_INFO_SCALE_SHARED_BIT | \
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+		BIT(IIO_CHAN_INFO_CALIBBIAS),		  \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
 	.address = addr, \
 	.scan_index = ADIS16400_SCAN_GYRO_ ## mod, \
 	.scan_type = { \
@@ -526,10 +525,10 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 	.type = IIO_ACCEL, \
 	.modified = 1, \
 	.channel2 = IIO_MOD_ ## mod, \
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT | \
-		IIO_CHAN_INFO_SCALE_SHARED_BIT | \
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+		BIT(IIO_CHAN_INFO_CALIBBIAS), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
 	.address = (addr), \
 	.scan_index = ADIS16400_SCAN_ACC_ ## mod, \
 	.scan_type = { \
@@ -545,9 +544,9 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 	.type = IIO_MAGN, \
 	.modified = 1, \
 	.channel2 = IIO_MOD_ ## mod, \
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-		IIO_CHAN_INFO_SCALE_SHARED_BIT | \
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
 	.address = (addr), \
 	.scan_index = ADIS16400_SCAN_MAGN_ ## mod, \
 	.scan_type = { \
@@ -568,10 +567,11 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 	.indexed = 1, \
 	.channel = 0, \
 	.extend_name = ADIS16400_MOD_TEMP_NAME_ ## mod, \
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT | \
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT | \
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+		BIT(IIO_CHAN_INFO_OFFSET) | \
+		BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_type = \
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
 	.address = (addr), \
 	.scan_index = ADIS16350_SCAN_TEMP_ ## mod, \
 	.scan_type = { \
@@ -587,9 +587,8 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 	.type = IIO_TEMP, \
 	.indexed = 1, \
 	.channel = 0, \
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT | \
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
+	.info_mask_separate = IIO_CHAN_INFO_RAW | IIO_CHAN_INFO_OFFSET | \
+		IIO_CHAN_INFO_SCALE, \
 	.address = (addr), \
 	.scan_index = ADIS16350_SCAN_TEMP_X, \
 	.scan_type = { \
@@ -605,8 +604,8 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 	.type = IIO_INCLI, \
 	.modified = 1, \
 	.channel2 = IIO_MOD_ ## mod, \
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-		IIO_CHAN_INFO_SCALE_SHARED_BIT, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
 	.address = (addr), \
 	.scan_index = ADIS16300_SCAN_INCLI_ ## mod, \
 	.scan_type = { \
@@ -646,8 +645,8 @@ static const struct iio_chan_spec adis16448_channels[] = {
 	ADIS16400_MAGN_CHAN(Z, ADIS16400_ZMAGN_OUT, 16),
 	{
 		.type = IIO_PRESSURE,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = ADIS16448_BARO_OUT,
 		.scan_index = ADIS16400_SCAN_BARO,
 		.scan_type = IIO_ST('s', 16, 16, 0),
-- 
1.8.1.4

