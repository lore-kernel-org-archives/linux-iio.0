Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/25] iio:ad5764: Report scale as fractional value
Date: Sat, 28 Sep 2013 11:31:42 +0200
Message-Id: <1380360717-26103-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-1-git-send-email-lars@metafoo.de>
References: <1380360717-26103-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Move the complexity of calculating the fixed point scale to the core.

Also fix a off by one error in the comment describing the transfer function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5764.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
index df7e028..a8ff5b2 100644
--- a/drivers/iio/dac/ad5764.c
+++ b/drivers/iio/dac/ad5764.c
@@ -217,7 +217,6 @@ static int ad5764_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long info)
 {
 	struct ad5764_state *st = iio_priv(indio_dev);
-	unsigned long scale_uv;
 	unsigned int reg;
 	int vref;
 	int ret;
@@ -245,15 +244,14 @@ static int ad5764_read_raw(struct iio_dev *indio_dev,
 		*val = sign_extend32(*val, 5);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		/* vout = 4 * vref + ((dac_code / 65535) - 0.5) */
+		/* vout = 4 * vref + ((dac_code / 65536) - 0.5) */
 		vref = ad5764_get_channel_vref(st, chan->channel);
 		if (vref < 0)
 			return vref;
 
-		scale_uv = (vref * 4 * 100) >> chan->scan_type.realbits;
-		*val = scale_uv / 100000;
-		*val2 = (scale_uv % 100000) * 10;
-		return IIO_VAL_INT_PLUS_MICRO;
+		*val = vref * 4 / 1000;
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = -(1 << chan->scan_type.realbits) / 2;
 		return IIO_VAL_INT;
-- 
1.8.0
