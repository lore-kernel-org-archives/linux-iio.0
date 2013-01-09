Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-052.synserver.de ([212.40.185.52]:1043 "EHLO
	smtp-out-052.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757811Ab3AIOAu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jan 2013 09:00:50 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/7] staging:iio:adis16080: Add scale and offset attributes
Date: Wed,  9 Jan 2013 15:01:18 +0100
Message-Id: <1357740079-12326-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1357740079-12326-1-git-send-email-lars@metafoo.de>
References: <1357740079-12326-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Report scale and offset for the velocity, voltage and temperature channels.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16080_core.c | 81 ++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index 55ffe39..1dde3c7 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -29,13 +29,20 @@
 
 #define ADIS16080_DIN_WRITE  (1 << 15)
 
+struct adis16080_chip_info {
+	int scale_val;
+	int scale_val2;
+};
+
 /**
  * struct adis16080_state - device instance specific data
  * @us:			actual spi_device to write data
+ * @info:		chip specific parameters
  * @buf:		transmit or receive buffer
  **/
 struct adis16080_state {
 	struct spi_device		*us;
+	const struct adis16080_chip_info *info;
 
 	__be16 buf ____cacheline_aligned;
 };
@@ -76,6 +83,7 @@ static int adis16080_read_raw(struct iio_dev *indio_dev,
 			     int *val2,
 			     long mask)
 {
+	struct adis16080_state *st = iio_priv(indio_dev);
 	int ret;
 
 	switch (mask) {
@@ -84,6 +92,40 @@ static int adis16080_read_raw(struct iio_dev *indio_dev,
 		ret = adis16080_read_sample(indio_dev, chan->address, val);
 		mutex_unlock(&indio_dev->mlock);
 		return ret ? ret : IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			*val = st->info->scale_val;
+			*val2 = st->info->scale_val2;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_VOLTAGE:
+			/* VREF = 5V, 12 bits */
+			*val = 5000;
+			*val2 = 12;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_TEMP:
+			/* 85 C = 585, 25 C = 0 */
+			*val = 85000 - 25000;
+			*val2 = 585;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			/* 2.5 V = 0 */
+			*val = 2048;
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			/* 85 C = 585, 25 C = 0 */
+			*val = DIV_ROUND_CLOSEST(25 * 585, 85 - 25);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		break;
 	}
 
 	return -EINVAL;
@@ -94,25 +136,32 @@ static const struct iio_chan_spec adis16080_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = ADIS16080_DIN_GYRO,
 	}, {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+			IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
 		.address = ADIS16080_DIN_AIN1,
 	}, {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+			IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
 		.address = ADIS16080_DIN_AIN2,
 	}, {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+			IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
 		.address = ADIS16080_DIN_TEMP,
 	}
 };
@@ -122,8 +171,27 @@ static const struct iio_info adis16080_info = {
 	.driver_module = THIS_MODULE,
 };
 
+enum {
+	ID_ADIS16080,
+	ID_ADIS16100,
+};
+
+static const struct adis16080_chip_info adis16080_chip_info[] = {
+	[ID_ADIS16080] = {
+		/* 80 degree = 819, 819 rad = 46925 degree */
+		.scale_val = 80,
+		.scale_val2 = 46925,
+	},
+	[ID_ADIS16100] = {
+		/* 300 degree = 1230, 1230 rad = 70474 degree */
+		.scale_val = 300,
+		.scale_val2 = 70474,
+	},
+};
+
 static int adis16080_probe(struct spi_device *spi)
 {
+	const struct spi_device_id *id = spi_get_device_id(spi);
 	int ret;
 	struct adis16080_state *st;
 	struct iio_dev *indio_dev;
@@ -140,6 +208,7 @@ static int adis16080_probe(struct spi_device *spi)
 
 	/* Allocate the comms buffers */
 	st->us = spi;
+	st->info = &adis16080_chip_info[id->driver_data];
 
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->channels = adis16080_channels;
@@ -169,8 +238,8 @@ static int adis16080_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id adis16080_ids[] = {
-	{ "adis16080", 0 },
-	{ "adis16100", 0 },
+	{ "adis16080", ID_ADIS16080 },
+	{ "adis16100", ID_ADIS16100 },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, adis16080_ids);
-- 
1.8.0

