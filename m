Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] staging:iio:adis16130: Report scale and offset
Date: Mon, 10 Jun 2013 16:00:14 +0200
Message-Id: <1370872815-14386-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1370872815-14386-1-git-send-email-lars@metafoo.de>
References: <1370872815-14386-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Report scale and offset for the temperature and voltage channels.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16130_core.c | 57 +++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index 2537f59..8979435 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -78,14 +78,47 @@ static int adis16130_read_raw(struct iio_dev *indio_dev,
 	int ret;
 	u32 temp;
 
-	/* Take the iio_dev status lock */
-	mutex_lock(&indio_dev->mlock);
-	ret =  adis16130_spi_read(indio_dev, chan->address, &temp);
-	mutex_unlock(&indio_dev->mlock);
-	if (ret)
-		return ret;
-	*val = temp;
-	return IIO_VAL_INT;
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		/* Take the iio_dev status lock */
+		mutex_lock(&indio_dev->mlock);
+		ret = adis16130_spi_read(indio_dev, chan->address, &temp);
+		mutex_unlock(&indio_dev->mlock);
+		if (ret)
+			return ret;
+		*val = temp;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			/* 0 degree = 838860, 250 degree = 14260608 */
+			*val = 250;
+			*val2 = 336440817; /* RAD_TO_DEGREE(14260608 - 8388608) */
+			return IIO_VAL_FRACTIONAL;
+		case IIO_TEMP:
+			/* 0C = 8036283, 105C = 9516048 */
+			*val = 105000;
+			*val2 = 9516048 - 8036283;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			*val = -8388608;
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			*val = -8036283;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+		break;
+	}
+
+	return -EINVAL;
 }
 
 static const struct iio_chan_spec adis16130_channels[] = {
@@ -93,13 +126,17 @@ static const struct iio_chan_spec adis16130_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_OFFSET),
 		.address = ADIS16130_RATEDATA,
 	}, {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_OFFSET),
 		.address = ADIS16130_TEMPDATA,
 	}
 };
-- 
1.8.0
