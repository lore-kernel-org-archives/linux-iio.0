Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/25] iio:ad5791: Report scale as fractional value
Date: Sat, 28 Sep 2013 11:31:43 +0200
Message-Id: <1380360717-26103-11-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-1-git-send-email-lars@metafoo.de>
References: <1380360717-26103-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Move the complexity of calculating the fixed point scale to the core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5791.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 3cee89b..d64acbd 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -270,9 +270,9 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
 		*val >>= chan->scan_type.shift;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		*val2 = (((u64)st->vref_mv) * 1000000ULL) >> chan->scan_type.realbits;
-		return IIO_VAL_INT_PLUS_MICRO;
+		*val = st->vref_mv;
+		*val2 = (1 << chan->scan_type.realbits) - 1;
+		return IIO_VAL_FRACTIONAL;
 	case IIO_CHAN_INFO_OFFSET:
 		val64 = (((u64)st->vref_neg_mv) << chan->scan_type.realbits);
 		do_div(val64, st->vref_mv);
-- 
1.8.0
