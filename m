Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/24] iio:ad7298: Use iio_push_to_buffers_with_timestamp()
Date: Thu, 19 Sep 2013 14:59:41 +0200
Message-Id: <1379595601-26448-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-1-git-send-email-lars@metafoo.de>
References: <1379595601-26448-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7298.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 0812556..2a3b65c 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -159,20 +159,14 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7298_state *st = iio_priv(indio_dev);
-	s64 time_ns = 0;
 	int b_sent;
 
 	b_sent = spi_sync(st->spi, &st->ring_msg);
 	if (b_sent)
 		goto done;
 
-	if (indio_dev->scan_timestamp) {
-		time_ns = iio_get_time_ns();
-		memcpy((u8 *)st->rx_buf + indio_dev->scan_bytes - sizeof(s64),
-			&time_ns, sizeof(time_ns));
-	}
-
-	iio_push_to_buffers(indio_dev, st->rx_buf);
+	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
+		iio_get_time_ns());
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
1.8.0
