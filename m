Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/25] iio:ad5421: Report scale as fractional value
Date: Sat, 28 Sep 2013 11:31:36 +0200
Message-Id: <1380360717-26103-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-1-git-send-email-lars@metafoo.de>
References: <1380360717-26103-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Move the complexity of calculating the fixed point scale to the core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5421.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index 1f78b14..567c4bd 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -281,18 +281,11 @@ static inline unsigned int ad5421_get_offset(struct ad5421_state *st)
 	return (min * (1 << 16)) / (max - min);
 }
 
-static inline unsigned int ad5421_get_scale(struct ad5421_state *st)
-{
-	unsigned int min, max;
-
-	ad5421_get_current_min_max(st, &min, &max);
-	return ((max - min) * 1000) / (1 << 16);
-}
-
 static int ad5421_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long m)
 {
 	struct ad5421_state *st = iio_priv(indio_dev);
+	unsigned int min, max;
 	int ret;
 
 	if (chan->type != IIO_CURRENT)
@@ -306,9 +299,10 @@ static int ad5421_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		*val2 = ad5421_get_scale(st);
-		return IIO_VAL_INT_PLUS_MICRO;
+		ad5421_get_current_min_max(st, &min, &max);
+		*val = max - min;
+		*val2 = (1 << 16) * 1000;
+		return IIO_VAL_FRACTIONAL;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = ad5421_get_offset(st);
 		return IIO_VAL_INT;
-- 
1.8.0
