Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-164.synserver.de ([212.40.185.164]:1146 "EHLO
	smtp-out-163.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754538Ab3I1Jav (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Sep 2013 05:30:51 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 21/25] staging:iio:ad7780: Report scale as fractional value
Date: Sat, 28 Sep 2013 11:31:53 +0200
Message-Id: <1380360717-26103-21-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-1-git-send-email-lars@metafoo.de>
References: <1380360717-26103-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move the complexity of calculating the fixed point scale to the core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7780.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 4f2522a..273add3 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -90,17 +90,14 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad7780_state *st = iio_priv(indio_dev);
-	unsigned long scale_uv;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
 		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
 	case IIO_CHAN_INFO_SCALE:
-		scale_uv = (st->int_vref_mv * 100000 * st->gain)
-			>> (chan->scan_type.realbits - 1);
-		*val =  scale_uv / 100000;
-		*val2 = (scale_uv % 100000) * 10;
-		return IIO_VAL_INT_PLUS_MICRO;
+		*val = st->int_vref_mv * st->gain;
+		*val2 = chan->scan_type.realbits - 1;
+		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_OFFSET:
 		*val -= (1 << (chan->scan_type.realbits - 1));
 		return IIO_VAL_INT;
-- 
1.8.0

