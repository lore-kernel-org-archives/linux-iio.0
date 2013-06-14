Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-136.synserver.de ([212.40.185.136]:1063 "EHLO
	smtp-out-134.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751294Ab3FNP6i (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Jun 2013 11:58:38 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/7] staging:iio:ad7291: Use sign_extend32 instead of open-coding it
Date: Fri, 14 Jun 2013 17:58:27 +0200
Message-Id: <1371225508-32190-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1371225508-32190-1-git-send-email-lars@metafoo.de>
References: <1371225508-32190-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This makes it a bit more obvious what is going on than open-coding it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7291.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 2a7e6a7..c2709d6 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -275,7 +275,6 @@ static int ad7291_read_event_value(struct iio_dev *indio_dev,
 	struct ad7291_chip_info *chip = iio_priv(indio_dev);
 	int ret;
 	u16 uval;
-	s16 signval;
 
 	ret = ad7291_i2c_read(chip, ad7291_threshold_reg(event_code), &uval);
 	if (ret < 0)
@@ -286,8 +285,7 @@ static int ad7291_read_event_value(struct iio_dev *indio_dev,
 		*val = uval & AD7291_VALUE_MASK;
 		return 0;
 	case IIO_TEMP:
-		signval = (s16)((uval & AD7291_VALUE_MASK) << 4) >> 4;
-		*val = signval;
+		*val = sign_extend32(uval, 11);
 		return 0;
 	default:
 		return -EINVAL;
@@ -397,7 +395,6 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 	int ret;
 	struct ad7291_chip_info *chip = iio_priv(indio_dev);
 	u16 regval;
-	s16 signval;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -433,8 +430,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 						       AD7291_T_SENSE);
 			if (ret < 0)
 				return ret;
-			signval = (s16)((ret & AD7291_VALUE_MASK) << 4) >> 4;
-			*val = signval;
+			*val = sign_extend32(ret, 11);
 			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
@@ -444,8 +440,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 					       AD7291_T_AVERAGE);
 			if (ret < 0)
 				return ret;
-			signval = (s16)((ret & AD7291_VALUE_MASK) << 4) >> 4;
-			*val = signval;
+			*val = sign_extend32(ret, 11);
 			return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
-- 
1.8.0

