Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-069.synserver.de ([212.40.185.69]:1189 "EHLO
	smtp-out-069.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757163Ab3APMsP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2013 07:48:15 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/15] staging:iio:adis16400: Add helper macros for channel declaration
Date: Wed, 16 Jan 2013 13:48:42 +0100
Message-Id: <1358340531-31350-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1358340531-31350-1-git-send-email-lars@metafoo.de>
References: <1358340531-31350-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Most of the channels declared in the adis16400 driver look quite similar. This
patch adds a bunch of helper macros to initialize the channel spec for this
driver. This allows us to drastically reduce the number of lines of code needed
for the channel spec declaration.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400_core.c | 557 ++++++++-----------------------
 1 file changed, 140 insertions(+), 417 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index c545cd9..f1d747a 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -375,436 +375,159 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+#define ADIS16400_VOLTAGE_CHAN(addr, bits, name, si) { \
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.channel = 0, \
+	.extend_name = name, \
+	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
+	.address = (addr), \
+	.scan_index = (si), \
+	.scan_type = IIO_ST('u', (bits), 16, 0), \
+}
+
+#define ADIS16400_SUPPLY_CHAN(addr, bits) \
+	ADIS16400_VOLTAGE_CHAN(addr, bits, "supply", ADIS16400_SCAN_SUPPLY)
+
+#define ADIS16400_AUX_ADC_CHAN(addr, bits) \
+	ADIS16400_VOLTAGE_CHAN(addr, bits, NULL, ADIS16400_SCAN_ADC)
+
+#define ADIS16400_GYRO_CHAN(mod, addr, bits) { \
+	.type = IIO_ANGL_VEL, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_ ## mod, \
+	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
+		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT | \
+		IIO_CHAN_INFO_SCALE_SHARED_BIT | \
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT, \
+	.address = addr, \
+	.scan_index = ADIS16400_SCAN_GYRO_ ## mod, \
+	.scan_type = IIO_ST('s', (bits), 16, 0), \
+}
+
+#define ADIS16400_ACCEL_CHAN(mod, addr, bits) { \
+	.type = IIO_ACCEL, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_ ## mod, \
+	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
+		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT | \
+		IIO_CHAN_INFO_SCALE_SHARED_BIT | \
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT, \
+	.address = (addr), \
+	.scan_index = ADIS16400_SCAN_ACC_ ## mod, \
+	.scan_type = IIO_ST('s', (bits), 16, 0), \
+}
+
+#define ADIS16400_MAGN_CHAN(mod, addr, bits) { \
+	.type = IIO_MAGN, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_ ## mod, \
+	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
+		IIO_CHAN_INFO_SCALE_SHARED_BIT | \
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT, \
+	.address = (addr), \
+	.scan_index = ADIS16400_SCAN_MAGN_ ## mod, \
+	.scan_type = IIO_ST('s', (bits), 16, 0), \
+}
+
+#define ADIS16400_MOD_TEMP_NAME_X "x"
+#define ADIS16400_MOD_TEMP_NAME_Y "y"
+#define ADIS16400_MOD_TEMP_NAME_Z "z"
+
+#define ADIS16400_MOD_TEMP_CHAN(mod, addr, bits) { \
+	.type = IIO_TEMP, \
+	.indexed = 1, \
+	.channel = 0, \
+	.extend_name = ADIS16400_MOD_TEMP_NAME_ ## mod, \
+	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
+		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT | \
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT | \
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT, \
+	.address = (addr), \
+	.scan_index = ADIS16350_SCAN_TEMP_ ## mod, \
+	.scan_type = IIO_ST('s', (bits), 16, 0), \
+}
+
+#define ADIS16400_TEMP_CHAN(addr, bits) { \
+	.type = IIO_TEMP, \
+	.indexed = 1, \
+	.channel = 0, \
+	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
+		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT | \
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
+	.address = (addr), \
+	.scan_index = ADIS16350_SCAN_TEMP_X, \
+	.scan_type = IIO_ST('s', (bits), 16, 0), \
+}
+
+#define ADIS16400_INCLI_CHAN(mod, addr, bits) { \
+	.type = IIO_INCLI, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_ ## mod, \
+	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
+		IIO_CHAN_INFO_SCALE_SHARED_BIT, \
+	.address = (addr), \
+	.scan_index = ADIS16300_SCAN_INCLI_ ## mod, \
+	.scan_type = IIO_ST('s', (bits), 16, 0), \
+}
+
 static const struct iio_chan_spec adis16400_channels[] = {
-	{
-		.type = IIO_VOLTAGE,
-		.indexed = 1,
-		.channel = 0,
-		.extend_name = "supply",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = ADIS16400_SUPPLY_OUT,
-		.scan_index = ADIS16400_SCAN_SUPPLY,
-		.scan_type = IIO_ST('u', 14, 16, 0),
-	}, {
-		.type = IIO_ANGL_VEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_XGYRO_OUT,
-		.scan_index = ADIS16400_SCAN_GYRO_X,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ANGL_VEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_YGYRO_OUT,
-		.scan_index = ADIS16400_SCAN_GYRO_Y,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ANGL_VEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_Z,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_ZGYRO_OUT,
-		.scan_index = ADIS16400_SCAN_GYRO_Z,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ACCEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_XACCL_OUT,
-		.scan_index = ADIS16400_SCAN_ACC_X,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ACCEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_YACCL_OUT,
-		.scan_index = ADIS16400_SCAN_ACC_Y,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ACCEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_Z,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_ZACCL_OUT,
-		.scan_index = ADIS16400_SCAN_ACC_Z,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_MAGN,
-		.modified = 1,
-		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_XMAGN_OUT,
-		.scan_index = ADIS16400_SCAN_MAGN_X,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_MAGN,
-		.modified = 1,
-		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_YMAGN_OUT,
-		.scan_index = ADIS16400_SCAN_MAGN_Y,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_MAGN,
-		.modified = 1,
-		.channel2 = IIO_MOD_Z,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_ZMAGN_OUT,
-		.scan_index = ADIS16400_SCAN_MAGN_Z,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_TEMP,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = ADIS16400_TEMP_OUT,
-		.scan_index = ADIS16350_SCAN_TEMP_X,
-		.scan_type = IIO_ST('s', 12, 16, 0),
-	}, {
-		.type = IIO_VOLTAGE,
-		.indexed = 1,
-		.channel = 1,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = ADIS16400_AUX_ADC,
-		.scan_index = ADIS16400_SCAN_ADC,
-		.scan_type = IIO_ST('s', 12, 16, 0),
-	},
+	ADIS16400_SUPPLY_CHAN(ADIS16400_SUPPLY_OUT, 14),
+	ADIS16400_GYRO_CHAN(X, ADIS16400_XGYRO_OUT, 14),
+	ADIS16400_GYRO_CHAN(Y, ADIS16400_YGYRO_OUT, 14),
+	ADIS16400_GYRO_CHAN(Z, ADIS16400_ZGYRO_OUT, 14),
+	ADIS16400_ACCEL_CHAN(X, ADIS16400_XACCL_OUT, 14),
+	ADIS16400_ACCEL_CHAN(Y, ADIS16400_YACCL_OUT, 14),
+	ADIS16400_ACCEL_CHAN(Z, ADIS16400_ZACCL_OUT, 14),
+	ADIS16400_MAGN_CHAN(X, ADIS16400_XMAGN_OUT, 14),
+	ADIS16400_MAGN_CHAN(Y, ADIS16400_YMAGN_OUT, 14),
+	ADIS16400_MAGN_CHAN(Z, ADIS16400_ZMAGN_OUT, 14),
+	ADIS16400_TEMP_CHAN(ADIS16400_TEMP_OUT, 12),
+	ADIS16400_AUX_ADC_CHAN(ADIS16400_AUX_ADC, 12),
 	IIO_CHAN_SOFT_TIMESTAMP(12)
 };
 
 static const struct iio_chan_spec adis16350_channels[] = {
-	{
-		.type = IIO_VOLTAGE,
-		.indexed = 1,
-		.channel = 0,
-		.extend_name = "supply",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = ADIS16400_SUPPLY_OUT,
-		.scan_index = ADIS16400_SCAN_SUPPLY,
-		.scan_type = IIO_ST('u', 12, 16, 0),
-	}, {
-		.type = IIO_ANGL_VEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_XGYRO_OUT,
-		.scan_index = ADIS16400_SCAN_GYRO_X,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ANGL_VEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_YGYRO_OUT,
-		.scan_index = ADIS16400_SCAN_GYRO_Y,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ANGL_VEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_Z,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_ZGYRO_OUT,
-		.scan_index = ADIS16400_SCAN_GYRO_Z,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ACCEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_XACCL_OUT,
-		.scan_index = ADIS16400_SCAN_ACC_X,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ACCEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_YACCL_OUT,
-		.scan_index = ADIS16400_SCAN_ACC_Y,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ACCEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_Z,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_ZACCL_OUT,
-		.scan_index = ADIS16400_SCAN_ACC_Z,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_TEMP,
-		.indexed = 1,
-		.channel = 0,
-		.extend_name = "x",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16350_XTEMP_OUT,
-		.scan_index = ADIS16350_SCAN_TEMP_X,
-		.scan_type = IIO_ST('s', 12, 16, 0),
-	}, {
-		.type = IIO_TEMP,
-		.indexed = 1,
-		.channel = 1,
-		.extend_name = "y",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16350_YTEMP_OUT,
-		.scan_index = ADIS16350_SCAN_TEMP_Y,
-		.scan_type = IIO_ST('s', 12, 16, 0),
-	}, {
-		.type = IIO_TEMP,
-		.indexed = 1,
-		.channel = 2,
-		.extend_name = "z",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = ADIS16350_ZTEMP_OUT,
-		.scan_index = ADIS16350_SCAN_TEMP_Z,
-		.scan_type = IIO_ST('s', 12, 16, 0),
-	}, {
-		.type = IIO_VOLTAGE,
-		.indexed = 1,
-		.channel = 1,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = ADIS16300_AUX_ADC,
-		.scan_index = ADIS16400_SCAN_ADC,
-		.scan_type = IIO_ST('s', 12, 16, 0),
-	},
+	ADIS16400_SUPPLY_CHAN(ADIS16400_SUPPLY_OUT, 12),
+	ADIS16400_GYRO_CHAN(X, ADIS16400_XGYRO_OUT, 14),
+	ADIS16400_GYRO_CHAN(Y, ADIS16400_YGYRO_OUT, 14),
+	ADIS16400_GYRO_CHAN(Z, ADIS16400_ZGYRO_OUT, 14),
+	ADIS16400_ACCEL_CHAN(X, ADIS16400_XACCL_OUT, 14),
+	ADIS16400_ACCEL_CHAN(Y, ADIS16400_YACCL_OUT, 14),
+	ADIS16400_ACCEL_CHAN(Z, ADIS16400_ZACCL_OUT, 14),
+	ADIS16400_MAGN_CHAN(X, ADIS16400_XMAGN_OUT, 14),
+	ADIS16400_MAGN_CHAN(Y, ADIS16400_YMAGN_OUT, 14),
+	ADIS16400_MAGN_CHAN(Z, ADIS16400_ZMAGN_OUT, 14),
+	ADIS16400_AUX_ADC_CHAN(ADIS16300_AUX_ADC, 12),
+	ADIS16400_MOD_TEMP_CHAN(X, ADIS16350_XTEMP_OUT, 12),
+	ADIS16400_MOD_TEMP_CHAN(Y, ADIS16350_YTEMP_OUT, 12),
+	ADIS16400_MOD_TEMP_CHAN(Z, ADIS16350_ZTEMP_OUT, 12),
 	IIO_CHAN_SOFT_TIMESTAMP(11)
 };
 
 static const struct iio_chan_spec adis16300_channels[] = {
-	{
-		.type = IIO_VOLTAGE,
-		.indexed = 1,
-		.channel = 0,
-		.extend_name = "supply",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = ADIS16400_SUPPLY_OUT,
-		.scan_index = ADIS16400_SCAN_SUPPLY,
-		.scan_type = IIO_ST('u', 12, 16, 0),
-	}, {
-		.type = IIO_ANGL_VEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_XGYRO_OUT,
-		.scan_index = ADIS16400_SCAN_GYRO_X,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ACCEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_XACCL_OUT,
-		.scan_index = ADIS16400_SCAN_ACC_X,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ACCEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_YACCL_OUT,
-		.scan_index = ADIS16400_SCAN_ACC_Y,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ACCEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_Z,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_ZACCL_OUT,
-		.scan_index = ADIS16400_SCAN_ACC_Z,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_TEMP,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = ADIS16350_XTEMP_OUT,
-		.scan_index = ADIS16350_SCAN_TEMP_X,
-		.scan_type = IIO_ST('s', 12, 16, 0),
-	}, {
-		.type = IIO_VOLTAGE,
-		.indexed = 1,
-		.channel = 1,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = ADIS16300_AUX_ADC,
-		.scan_index = ADIS16400_SCAN_ADC,
-		.scan_type = IIO_ST('s', 12, 16, 0),
-	}, {
-		.type = IIO_INCLI,
-		.modified = 1,
-		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
-		.address = ADIS16300_PITCH_OUT,
-		.scan_index = ADIS16300_SCAN_INCLI_X,
-		.scan_type = IIO_ST('s', 13, 16, 0),
-	}, {
-		.type = IIO_INCLI,
-		.modified = 1,
-		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
-		.address = ADIS16300_ROLL_OUT,
-		.scan_index = ADIS16300_SCAN_INCLI_Y,
-		.scan_type = IIO_ST('s', 13, 16, 0),
-	},
+	ADIS16400_SUPPLY_CHAN(ADIS16400_SUPPLY_OUT, 12),
+	ADIS16400_GYRO_CHAN(X, ADIS16400_XGYRO_OUT, 14),
+	ADIS16400_ACCEL_CHAN(X, ADIS16400_XACCL_OUT, 14),
+	ADIS16400_ACCEL_CHAN(Y, ADIS16400_YACCL_OUT, 14),
+	ADIS16400_ACCEL_CHAN(Z, ADIS16400_ZACCL_OUT, 14),
+	ADIS16400_TEMP_CHAN(ADIS16350_XTEMP_OUT, 12),
+	ADIS16400_AUX_ADC_CHAN(ADIS16300_AUX_ADC, 12),
+	ADIS16400_INCLI_CHAN(X, ADIS16300_PITCH_OUT, 13),
+	ADIS16400_INCLI_CHAN(Y, ADIS16300_ROLL_OUT, 13),
 	IIO_CHAN_SOFT_TIMESTAMP(14)
 };
 
 static const struct iio_chan_spec adis16334_channels[] = {
-	{
-		.type = IIO_ANGL_VEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_XGYRO_OUT,
-		.scan_index = ADIS16400_SCAN_GYRO_X,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ANGL_VEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_YGYRO_OUT,
-		.scan_index = ADIS16400_SCAN_GYRO_Y,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ANGL_VEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_Z,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_ZGYRO_OUT,
-		.scan_index = ADIS16400_SCAN_GYRO_Z,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ACCEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_XACCL_OUT,
-		.scan_index = ADIS16400_SCAN_ACC_X,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ACCEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_YACCL_OUT,
-		.scan_index = ADIS16400_SCAN_ACC_Y,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_ACCEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_Z,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = ADIS16400_ZACCL_OUT,
-		.scan_index = ADIS16400_SCAN_ACC_Z,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	}, {
-		.type = IIO_TEMP,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
-		.address = ADIS16350_XTEMP_OUT,
-		.scan_index = ADIS16350_SCAN_TEMP_X,
-		.scan_type = IIO_ST('s', 14, 16, 0),
-	},
-	IIO_CHAN_SOFT_TIMESTAMP(12)
+	ADIS16400_GYRO_CHAN(X, ADIS16400_XGYRO_OUT, 14),
+	ADIS16400_GYRO_CHAN(Y, ADIS16400_YGYRO_OUT, 14),
+	ADIS16400_GYRO_CHAN(Z, ADIS16400_ZGYRO_OUT, 14),
+	ADIS16400_ACCEL_CHAN(X, ADIS16400_XACCL_OUT, 14),
+	ADIS16400_ACCEL_CHAN(Y, ADIS16400_YACCL_OUT, 14),
+	ADIS16400_ACCEL_CHAN(Z, ADIS16400_ZACCL_OUT, 14),
+	ADIS16400_TEMP_CHAN(ADIS16350_XTEMP_OUT, 12),
+	IIO_CHAN_SOFT_TIMESTAMP(8)
 };
 
 static struct attribute *adis16400_attributes[] = {
-- 
1.8.0

