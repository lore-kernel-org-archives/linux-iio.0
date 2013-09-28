Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/25] iio:ad5624r: Report scale as fractional value
Date: Sat, 28 Sep 2013 11:31:39 +0200
Message-Id: <1380360717-26103-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-1-git-send-email-lars@metafoo.de>
References: <1380360717-26103-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Move the complexity of calculating the fixed point scale to the core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5624r_spi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index dbb1289..774dd96 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -50,15 +50,12 @@ static int ad5624r_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad5624r_state *st = iio_priv(indio_dev);
-	unsigned long scale_uv;
 
 	switch (m) {
 	case IIO_CHAN_INFO_SCALE:
-		scale_uv = (st->vref_mv * 1000) >> chan->scan_type.realbits;
-		*val =  scale_uv / 1000;
-		*val2 = (scale_uv % 1000) * 1000;
-		return IIO_VAL_INT_PLUS_MICRO;
-
+		*val = st->vref_mv;
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
 	}
 	return -EINVAL;
 }
-- 
1.8.0
