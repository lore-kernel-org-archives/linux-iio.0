Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-069.synserver.de ([212.40.185.69]:1095 "EHLO
	smtp-out-069.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab3APMsg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2013 07:48:36 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 15/15] iio:adis16400: Add support for the adis16448
Date: Wed, 16 Jan 2013 13:48:51 +0100
Message-Id: <1358340531-31350-15-git-send-email-lars@metafoo.de>
In-Reply-To: <1358340531-31350-1-git-send-email-lars@metafoo.de>
References: <1358340531-31350-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The adis16448 is more or less from the same family of devices as supported by
this driver. It features three acceleration channels, three angular velocity
channels, three magnetometer channels, one temperature channels and one
barometric pressure channel.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/adis16400.h      |  4 ++++
 drivers/iio/imu/adis16400_core.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iio/imu/adis16400.h b/drivers/iio/imu/adis16400.h
index 6270185..2f8f9d6 100644
--- a/drivers/iio/imu/adis16400.h
+++ b/drivers/iio/imu/adis16400.h
@@ -44,6 +44,9 @@
 #define ADIS16300_ROLL_OUT  0x14 /* Y axis inclinometer output measurement */
 #define ADIS16300_AUX_ADC   0x16 /* Auxiliary ADC measurement */
 
+#define ADIS16448_BARO_OUT	0x16 /* Barometric pressure output */
+#define ADIS16448_TEMP_OUT  0x18 /* Temperature output */
+
 /* Calibration parameters */
 #define ADIS16400_XGYRO_OFF 0x1A /* X-axis gyroscope bias offset factor */
 #define ADIS16400_YGYRO_OFF 0x1C /* Y-axis gyroscope bias offset factor */
@@ -179,6 +182,7 @@ enum {
 	ADIS16400_SCAN_MAGN_X,
 	ADIS16400_SCAN_MAGN_Y,
 	ADIS16400_SCAN_MAGN_Z,
+	ADIS16400_SCAN_BARO,
 	ADIS16350_SCAN_TEMP_X,
 	ADIS16350_SCAN_TEMP_Y,
 	ADIS16350_SCAN_TEMP_Z,
diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index e8f84c9..b7f215e 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -139,6 +139,7 @@ enum adis16400_chip_variant {
 	ADIS16362,
 	ADIS16364,
 	ADIS16400,
+	ADIS16448,
 };
 
 static int adis16334_get_freq(struct adis16400_state *st)
@@ -633,6 +634,28 @@ static const struct iio_chan_spec adis16400_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(12)
 };
 
+static const struct iio_chan_spec adis16448_channels[] = {
+	ADIS16400_GYRO_CHAN(X, ADIS16400_XGYRO_OUT, 16),
+	ADIS16400_GYRO_CHAN(Y, ADIS16400_YGYRO_OUT, 16),
+	ADIS16400_GYRO_CHAN(Z, ADIS16400_ZGYRO_OUT, 16),
+	ADIS16400_ACCEL_CHAN(X, ADIS16400_XACCL_OUT, 16),
+	ADIS16400_ACCEL_CHAN(Y, ADIS16400_YACCL_OUT, 16),
+	ADIS16400_ACCEL_CHAN(Z, ADIS16400_ZACCL_OUT, 16),
+	ADIS16400_MAGN_CHAN(X, ADIS16400_XMAGN_OUT, 16),
+	ADIS16400_MAGN_CHAN(Y, ADIS16400_YMAGN_OUT, 16),
+	ADIS16400_MAGN_CHAN(Z, ADIS16400_ZMAGN_OUT, 16),
+	{
+		.type = IIO_PRESSURE,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.address = ADIS16448_BARO_OUT,
+		.scan_index = ADIS16400_SCAN_BARO,
+		.scan_type = IIO_ST('s', 16, 16, 0),
+	},
+	ADIS16400_TEMP_CHAN(ADIS16448_TEMP_OUT, 12),
+	IIO_CHAN_SOFT_TIMESTAMP(11)
+};
+
 static const struct iio_chan_spec adis16350_channels[] = {
 	ADIS16400_SUPPLY_CHAN(ADIS16400_SUPPLY_OUT, 12),
 	ADIS16400_GYRO_CHAN(X, ADIS16400_XGYRO_OUT, 14),
@@ -765,6 +788,18 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
+	},
+	[ADIS16448] = {
+		.channels = adis16448_channels,
+		.num_channels = ARRAY_SIZE(adis16448_channels),
+		.flags = ADIS16400_HAS_PROD_ID |
+				ADIS16400_HAS_SERIAL_NUMBER,
+		.gyro_scale_micro = IIO_DEGREE_TO_RAD(10000), /* 0.01 deg/s */
+		.accel_scale_micro = IIO_G_TO_M_S_2(833), /* 1/1200 g */
+		.temp_scale_nano = 73860000, /* 0.07386 C */
+		.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
+		.set_freq = adis16334_set_freq,
+		.get_freq = adis16334_get_freq,
 	}
 };
 
@@ -909,6 +944,7 @@ static const struct spi_device_id adis16400_id[] = {
 	{"adis16365", ADIS16360},
 	{"adis16400", ADIS16400},
 	{"adis16405", ADIS16400},
+	{"adis16448", ADIS16448},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, adis16400_id);
-- 
1.8.0

