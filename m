Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/25] iio:max517: Report scale as fractional value
Date: Sat, 28 Sep 2013 11:31:44 +0200
Message-Id: <1380360717-26103-12-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-1-git-send-email-lars@metafoo.de>
References: <1380360717-26103-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Move the complexity of calculating the fixed point scale to the core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/max517.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index 83adcbf..d26be14 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -82,15 +82,13 @@ static int max517_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct max517_data *data = iio_priv(indio_dev);
-	unsigned int scale_uv;
 
 	switch (m) {
 	case IIO_CHAN_INFO_SCALE:
 		/* Corresponds to Vref / 2^(bits) */
-		scale_uv = (data->vref_mv[chan->channel] * 1000) >> 8;
-		*val =  scale_uv / 1000000;
-		*val2 = scale_uv % 1000000;
-		return IIO_VAL_INT_PLUS_MICRO;
+		*val = data->vref_mv[chan->channel];
+		*val2 = 8;
+		return IIO_VAL_FRACTIONAL_LOG2;
 	default:
 		break;
 	}
-- 
1.8.0
