Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-164.synserver.de ([212.40.185.164]:1059 "EHLO
	smtp-out-163.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754303Ab3I1Jao (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Sep 2013 05:30:44 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 16/25] iio:ad7791: Report scale as fractional value
Date: Sat, 28 Sep 2013 11:31:48 +0200
Message-Id: <1380360717-26103-16-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-1-git-send-email-lars@metafoo.de>
References: <1380360717-26103-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move the complexity of calculating the fixed point scale to the core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7791.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index c202035..c19f8fd 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -202,7 +202,6 @@ static int ad7791_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad7791_state *st = iio_priv(indio_dev);
 	bool unipolar = !!(st->mode & AD7791_MODE_UNIPOLAR);
-	unsigned long long scale_pv;
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
@@ -220,23 +219,26 @@ static int ad7791_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		/* The monitor channel uses an internal reference. */
 		if (chan->address == AD7791_CH_AVDD_MONITOR) {
-			scale_pv = 5850000000000ULL;
+			/*
+			 * The signal is attenuated by a factor of 5 and
+			 * compared against a 1.17V internal reference.
+			 */
+			*val = 1170 * 5;
 		} else {
 			int voltage_uv;
 
 			voltage_uv = regulator_get_voltage(st->reg);
 			if (voltage_uv < 0)
 				return voltage_uv;
-			scale_pv = (unsigned long long)voltage_uv * 1000000;
+
+			*val = voltage_uv / 1000;
 		}
 		if (unipolar)
-			scale_pv >>= chan->scan_type.realbits;
+			*val2 = chan->scan_type.realbits;
 		else
-			scale_pv >>= chan->scan_type.realbits - 1;
-		*val2 = do_div(scale_pv, 1000000000);
-		*val = scale_pv;
+			*val2 = chan->scan_type.realbits - 1;
 
-		return IIO_VAL_INT_PLUS_NANO;
+		return IIO_VAL_FRACTIONAL_LOG2;
 	}
 
 	return -EINVAL;
-- 
1.8.0

