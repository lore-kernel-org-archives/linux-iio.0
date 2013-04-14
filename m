Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/3] staging:iio:gyro:adis16130 add offset and scale info mask elements.
Date: Sun, 14 Apr 2013 12:23:45 +0100
Message-Id: <1365938625-21778-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1365938625-21778-1-git-send-email-jic23@kernel.org>
References: <1365938625-21778-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/gyro/adis16130_core.c | 57 +++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index 628671a..4c44afc 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -84,14 +84,47 @@ static int adis16130_read_raw(struct iio_dev *indio_dev,
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
+		ret =  adis16130_spi_read(indio_dev, chan->address, &temp);
+		mutex_unlock(&indio_dev->mlock);
+		if (ret)
+			return ret;
+		*val = temp;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			/* -2^23 */
+			*val = -8388608;
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			/* -2^23 + 25*14093 */
+			*val = -8036233;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			/* 2pi/(360*23488) */
+			*val = 0;
+			*val2 = 743072;
+			return IIO_VAL_INT_PLUS_PICO;
+		case IIO_TEMP:
+			/* 1/(14093*1000) */
+			*val = 0;
+			*val2 = 70957;
+			return IIO_VAL_INT_PLUS_PICO;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
 }
 
 static const struct iio_chan_spec adis16130_channels[] = {
@@ -99,13 +132,17 @@ static const struct iio_chan_spec adis16130_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SCALE),
 		.address = ADIS16130_RATEDATA,
 	}, {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SCALE),
 		.address = ADIS16130_TEMPDATA,
 	}
 };
-- 
1.8.2.1
