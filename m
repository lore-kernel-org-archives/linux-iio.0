Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-069.synserver.de ([212.40.185.69]:1032 "EHLO
	smtp-out-069.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558Ab3APMsI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2013 07:48:08 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/15] staging:iio:adis16400: Fix and cleanup 3db filter setting
Date: Wed, 16 Jan 2013 13:48:38 +0100
Message-Id: <1358340531-31350-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1358340531-31350-1-git-send-email-lars@metafoo.de>
References: <1358340531-31350-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The 3db divisors table is partially wrong and incomplete. Also the code rounds
up to the next higher frequency if the requested frequency would matches one of
the available frequencies. These two issues are fixed by this patch. The patch
also changes the driver to round down the filter frequency if it is larger than
the largest supported frequency instead of rejecting it as an invalid value.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400_core.c | 41 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index cb66225..7114de9 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -242,33 +242,32 @@ static ssize_t adis16400_read_frequency(struct device *dev,
 
 static const unsigned adis16400_3db_divisors[] = {
 	[0] = 2, /* Special case */
-	[1] = 5,
-	[2] = 10,
-	[3] = 50,
-	[4] = 200,
+	[1] = 6,
+	[2] = 12,
+	[3] = 25,
+	[4] = 50,
+	[5] = 100,
+	[6] = 200,
+	[7] = 200, /* Not a valid setting */
 };
 
 static int adis16400_set_filter(struct iio_dev *indio_dev, int sps, int val)
 {
 	int i, ret;
 	u16 val16;
-	for (i = ARRAY_SIZE(adis16400_3db_divisors) - 1; i >= 0; i--)
-		if (sps/adis16400_3db_divisors[i] > val)
+
+	for (i = ARRAY_SIZE(adis16400_3db_divisors) - 1; i >= 1; i--) {
+		if (sps / adis16400_3db_divisors[i] >= val)
 			break;
-	if (i == -1)
-		ret = -EINVAL;
-	else {
-		ret = adis16400_spi_read_reg_16(indio_dev,
-						ADIS16400_SENS_AVG,
+	}
+
+	ret = adis16400_spi_read_reg_16(indio_dev, ADIS16400_SENS_AVG,
 						&val16);
-		if (ret < 0)
-			goto error_ret;
+	if (ret < 0)
+		return ret;
 
-		ret = adis16400_spi_write_reg_16(indio_dev,
-						 ADIS16400_SENS_AVG,
-						 (val16 & ~0x03) | i);
-	}
-error_ret:
+	ret = adis16400_spi_write_reg_16(indio_dev, ADIS16400_SENS_AVG,
+					 (val16 & ~0x07) | i);
 	return ret;
 }
 
@@ -653,9 +652,9 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 			mutex_unlock(&indio_dev->mlock);
 			return ret;
 		}
-		val16 = st->variant->get_freq(indio_dev);
-		if (ret > 0)
-			*val = ret/adis16400_3db_divisors[val16 & 0x03];
+		ret = st->variant->get_freq(indio_dev);
+		if (ret >= 0)
+			*val = ret / adis16400_3db_divisors[val16 & 0x07];
 		*val2 = 0;
 		mutex_unlock(&indio_dev->mlock);
 		if (ret < 0)
-- 
1.8.0

