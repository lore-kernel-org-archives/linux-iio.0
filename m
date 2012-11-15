Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] staging:iio:ad7298: Do not perform endianness conversion in buffered mode
Date: Thu, 15 Nov 2012 14:15:24 +0100
Message-Id: <1352985328-24322-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

For buffered mode we do not want to perform endianness conversion in the kernel,
but rather offload it to user space, since it is not always required to do a
conversion at all. It also greatly simplifies the kernel code since no
post-processing has to be done and may allow future optimizations like streaming
data directly to a storage device or over the network via DMA.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7298.h      |  2 +-
 drivers/staging/iio/adc/ad7298_core.c |  1 +
 drivers/staging/iio/adc/ad7298_ring.c | 11 +++--------
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7298.h b/drivers/staging/iio/adc/ad7298.h
index 18f2787..0ce9031 100644
--- a/drivers/staging/iio/adc/ad7298.h
+++ b/drivers/staging/iio/adc/ad7298.h
@@ -48,7 +48,7 @@ struct ad7298_state {
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
 	 */
-	unsigned short			rx_buf[8] ____cacheline_aligned;
+	unsigned short			rx_buf[12] ____cacheline_aligned;
 	unsigned short			tx_buf[2];
 };
 
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 4c75114..67082ad 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -35,6 +35,7 @@
 			.sign = 'u',					\
 			.realbits = 12,					\
 			.storagebits = 16,				\
+			.endianness = IIO_BE,				\
 		},							\
 	}
 
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index b3dd514..e387712 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -76,8 +76,7 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7298_state *st = iio_priv(indio_dev);
 	s64 time_ns = 0;
-	__u16 buf[16];
-	int b_sent, i;
+	int b_sent;
 
 	b_sent = spi_sync(st->spi, &st->ring_msg);
 	if (b_sent)
@@ -85,15 +84,11 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 
 	if (indio_dev->scan_timestamp) {
 		time_ns = iio_get_time_ns();
-		memcpy((u8 *)buf + indio_dev->scan_bytes - sizeof(s64),
+		memcpy((u8 *)st->rx_buf + indio_dev->scan_bytes - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 	}
 
-	for (i = 0; i < bitmap_weight(indio_dev->active_scan_mask,
-						 indio_dev->masklength); i++)
-		buf[i] = be16_to_cpu(st->rx_buf[i]);
-
-	iio_push_to_buffers(indio_dev, (u8 *)buf);
+	iio_push_to_buffers(indio_dev, (u8 *)st->rx_buf);
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
1.8.0
