Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41054 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab2DRNOD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 09:14:03 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 10/14] staging:iio:adc:ad799x use iio_sw_buffer_preenable to avoid code repitiion
Date: Wed, 18 Apr 2012 14:13:50 +0100
Message-Id: <1334754834-13622-11-git-send-email-jic23@kernel.org>
In-Reply-To: <1334754834-13622-1-git-send-email-jic23@kernel.org>
References: <1334754834-13622-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using this generic function cuts down on repeated code at the cost of
a little overhead in a slow path.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/ad799x.h      |    1 -
 drivers/staging/iio/adc/ad799x_ring.c |   22 +++-------------------
 2 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index 356f690..99f8abe 100644
--- a/drivers/staging/iio/adc/ad799x.h
+++ b/drivers/staging/iio/adc/ad799x.h
@@ -104,7 +104,6 @@ struct ad799x_chip_info {
 struct ad799x_state {
 	struct i2c_client		*client;
 	const struct ad799x_chip_info	*chip_info;
-	size_t				d_size;
 	struct iio_trigger		*trig;
 	struct regulator		*reg;
 	u16				int_vref_mv;
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 069765c..dfdbf92 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -32,9 +32,7 @@
  **/
 static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 {
-	struct iio_buffer *ring = indio_dev->buffer;
 	struct ad799x_state *st = iio_priv(indio_dev);
-
 	/*
 	 * Need to figure out the current mode based upon the requested
 	 * scan mask in iio_dev
@@ -43,21 +41,7 @@ static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 	if (st->id == ad7997 || st->id == ad7998)
 		ad7997_8_set_scan_mode(st, *indio_dev->active_scan_mask);
 
-	st->d_size = bitmap_weight(indio_dev->active_scan_mask,
-				   indio_dev->masklength) * 2;
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
+	return iio_sw_buffer_preenable(indio_dev);
 }
 
 /**
@@ -78,7 +62,7 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	int b_sent;
 	u8 cmd;
 
-	rxbuf = kmalloc(st->d_size, GFP_KERNEL);
+	rxbuf = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (rxbuf == NULL)
 		goto out;
 
@@ -112,7 +96,7 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	time_ns = iio_get_time_ns();
 
 	if (ring->scan_timestamp)
-		memcpy(rxbuf + st->d_size - sizeof(s64),
+		memcpy(rxbuf + indio_dev->scan_bytes - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
 	ring->access->store_to(indio_dev->buffer, rxbuf, time_ns);
-- 
1.7.0.4

