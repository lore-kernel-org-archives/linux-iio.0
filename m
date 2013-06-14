Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-136.synserver.de ([212.40.185.136]:1071 "EHLO
	smtp-out-134.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751599Ab3FNP6Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Jun 2013 11:58:25 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/7] staging:iio:ad7291: Use IIO_VAL_FRACTIONAL_LOG2
Date: Fri, 14 Jun 2013 17:58:22 +0200
Message-Id: <1371225508-32190-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a bit more straight forward and also allows better precession when using
the an in-kernel consumer.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7291.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index d088c66..a3a3a2f 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -456,7 +456,6 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct ad7291_chip_info *chip = iio_priv(indio_dev);
-	unsigned int scale_uv;
 	u16 regval;
 	s16 signval;
 
@@ -513,10 +512,9 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			scale_uv = (chip->int_vref_mv * 1000) >> AD7291_BITS;
-			*val =  scale_uv / 1000;
-			*val2 = (scale_uv % 1000) * 1000;
-			return IIO_VAL_INT_PLUS_MICRO;
+			*val = chip->int_vref_mv;
+			*val2 = AD7291_BITS;
+			return IIO_VAL_FRACTIONAL_LOG2;
 		case IIO_TEMP:
 			/*
 			 * One LSB of the ADC corresponds to 0.25 deg C.
-- 
1.8.0

