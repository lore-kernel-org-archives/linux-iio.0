Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41032 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184Ab2DRNOC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 09:14:02 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 07/14] staging:iio:adc:ad7476 use iio_sw_buffer_preenable instead of local version.
Date: Wed, 18 Apr 2012 14:13:47 +0100
Message-Id: <1334754834-13622-8-git-send-email-jic23@kernel.org>
In-Reply-To: <1334754834-13622-1-git-send-email-jic23@kernel.org>
References: <1334754834-13622-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Now the generic version caches the scan size the version in this driver
is redundant.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/ad7476.h      |    1 -
 drivers/staging/iio/adc/ad7476_ring.c |   36 ++------------------------------
 2 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7476.h b/drivers/staging/iio/adc/ad7476.h
index 27f696c..b1dd931 100644
--- a/drivers/staging/iio/adc/ad7476.h
+++ b/drivers/staging/iio/adc/ad7476.h
@@ -27,7 +27,6 @@ struct ad7476_state {
 	struct spi_device		*spi;
 	const struct ad7476_chip_info	*chip_info;
 	struct regulator		*reg;
-	size_t				d_size;
 	u16				int_vref_mv;
 	struct spi_transfer		xfer;
 	struct spi_message		msg;
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index d6af6c0..a090bc3 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -20,36 +20,6 @@
 
 #include "ad7476.h"
 
-/**
- * ad7476_ring_preenable() setup the parameters of the ring before enabling
- *
- * The complex nature of the setting of the number of bytes per datum is due
- * to this driver currently ensuring that the timestamp is stored at an 8
- * byte boundary.
- **/
-static int ad7476_ring_preenable(struct iio_dev *indio_dev)
-{
-	struct ad7476_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-
-	st->d_size = bitmap_weight(indio_dev->active_scan_mask,
-				   indio_dev->masklength) *
-		st->chip_info->channel[0].scan_type.storagebits / 8;
-
-	if (ring->scan_timestamp) {
-		st->d_size += sizeof(s64);
-
-		if (st->d_size % sizeof(s64))
-			st->d_size += sizeof(s64) - (st->d_size % sizeof(s64));
-	}
-
-	if (indio_dev->buffer->access->set_bytes_per_datum)
-		indio_dev->buffer->access->
-			set_bytes_per_datum(indio_dev->buffer, st->d_size);
-
-	return 0;
-}
-
 static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 {
 	struct iio_poll_func *pf = p;
@@ -59,7 +29,7 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 	__u8 *rxbuf;
 	int b_sent;
 
-	rxbuf = kzalloc(st->d_size, GFP_KERNEL);
+	rxbuf = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (rxbuf == NULL)
 		return -ENOMEM;
 
@@ -71,7 +41,7 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 	time_ns = iio_get_time_ns();
 
 	if (indio_dev->buffer->scan_timestamp)
-		memcpy(rxbuf + st->d_size - sizeof(s64),
+		memcpy(rxbuf + indio_dev->scan_bytes - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
 	indio_dev->buffer->access->store_to(indio_dev->buffer, rxbuf, time_ns);
@@ -83,7 +53,7 @@ done:
 }
 
 static const struct iio_buffer_setup_ops ad7476_ring_setup_ops = {
-	.preenable = &ad7476_ring_preenable,
+	.preenable = &iio_sw_buffer_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
 };
-- 
1.7.0.4

