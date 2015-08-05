Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-232.synserver.de ([212.40.185.232]:1041 "EHLO
	smtp-out-230.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751591AbbHENid (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2015 09:38:33 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/9] iio: adis16480: Fix scale factors
Date: Wed,  5 Aug 2015 15:38:15 +0200
Message-Id: <1438781901-28000-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1438781901-28000-1-git-send-email-lars@metafoo.de>
References: <1438781901-28000-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The different devices support by the adis16480 driver have slightly
different scales for the gyroscope and accelerometer channels.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/adis16480.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 989605d..b94bfd3 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -110,6 +110,10 @@
 struct adis16480_chip_info {
 	unsigned int num_channels;
 	const struct iio_chan_spec *channels;
+	unsigned int gyro_max_val;
+	unsigned int gyro_max_scale;
+	unsigned int accel_max_val;
+	unsigned int accel_max_scale;
 };
 
 struct adis16480 {
@@ -497,19 +501,21 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
 static int adis16480_read_raw(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, int *val, int *val2, long info)
 {
+	struct adis16480 *st = iio_priv(indio_dev);
+
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
 		return adis_single_conversion(indio_dev, chan, 0, val);
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
-			*val = 0;
-			*val2 = IIO_DEGREE_TO_RAD(20000); /* 0.02 degree/sec */
-			return IIO_VAL_INT_PLUS_MICRO;
+			*val = st->chip_info->gyro_max_scale;
+			*val2 = st->chip_info->gyro_max_val;
+			return IIO_VAL_FRACTIONAL;
 		case IIO_ACCEL:
-			*val = 0;
-			*val2 = IIO_G_TO_M_S_2(800); /* 0.8 mg */
-			return IIO_VAL_INT_PLUS_MICRO;
+			*val = st->chip_info->accel_max_scale;
+			*val2 = st->chip_info->accel_max_val;
+			return IIO_VAL_FRACTIONAL;
 		case IIO_MAGN:
 			*val = 0;
 			*val2 = 100; /* 0.0001 gauss */
@@ -674,18 +680,39 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 	[ADIS16375] = {
 		.channels = adis16485_channels,
 		.num_channels = ARRAY_SIZE(adis16485_channels),
+		/*
+		 * storing the value in rad/degree and the scale in degree
+		 * gives us the result in rad and better precession than
+		 * storing the scale directly in rad.
+		 */
+		.gyro_max_val = IIO_RAD_TO_DEGREE(22887),
+		.gyro_max_scale = 300,
+		.accel_max_val = IIO_M_S_2_TO_G(21973),
+		.accel_max_scale = 18,
 	},
 	[ADIS16480] = {
 		.channels = adis16480_channels,
 		.num_channels = ARRAY_SIZE(adis16480_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(22500),
+		.gyro_max_scale = 450,
+		.accel_max_val = IIO_M_S_2_TO_G(12500),
+		.accel_max_scale = 5,
 	},
 	[ADIS16485] = {
 		.channels = adis16485_channels,
 		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(22500),
+		.gyro_max_scale = 450,
+		.accel_max_val = IIO_M_S_2_TO_G(20000),
+		.accel_max_scale = 5,
 	},
 	[ADIS16488] = {
 		.channels = adis16480_channels,
 		.num_channels = ARRAY_SIZE(adis16480_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(22500),
+		.gyro_max_scale = 450,
+		.accel_max_val = IIO_M_S_2_TO_G(22500),
+		.accel_max_scale = 18,
 	},
 };
 
-- 
2.1.4

