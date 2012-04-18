Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41050 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198Ab2DRNOD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 09:14:03 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 09/14] staging:iio:adc:ad7887 make use of iio_sw_buffer_preenable.
Date: Wed, 18 Apr 2012 14:13:49 +0100
Message-Id: <1334754834-13622-10-git-send-email-jic23@kernel.org>
In-Reply-To: <1334754834-13622-1-git-send-email-jic23@kernel.org>
References: <1334754834-13622-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using this generic function cuts down on repeated code at the cost
of some computation in a slow path.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/ad7887.h      |    1 -
 drivers/staging/iio/adc/ad7887_ring.c |   23 ++++++-----------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7887.h b/drivers/staging/iio/adc/ad7887.h
index bc53b65..2e09e54 100644
--- a/drivers/staging/iio/adc/ad7887.h
+++ b/drivers/staging/iio/adc/ad7887.h
@@ -63,7 +63,6 @@ struct ad7887_state {
 	struct spi_device		*spi;
 	const struct ad7887_chip_info	*chip_info;
 	struct regulator		*reg;
-	size_t				d_size;
 	u16				int_vref_mv;
 	struct spi_transfer		xfer[4];
 	struct spi_message		msg[3];
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index d180907..442994e 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -29,22 +29,11 @@
 static int ad7887_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7887_state *st = iio_priv(indio_dev);
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
+	int ret;
 
-	if (indio_dev->buffer->access->set_bytes_per_datum)
-		indio_dev->buffer->access->
-			set_bytes_per_datum(indio_dev->buffer, st->d_size);
+	ret = iio_sw_buffer_preenable(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	/* We know this is a single long so can 'cheat' */
 	switch (*indio_dev->active_scan_mask) {
@@ -92,7 +81,7 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 					   indio_dev->masklength) *
 		st->chip_info->channel[0].scan_type.storagebits / 8;
 
-	buf = kzalloc(st->d_size, GFP_KERNEL);
+	buf = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (buf == NULL)
 		return -ENOMEM;
 
@@ -104,7 +93,7 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 
 	memcpy(buf, st->data, bytes);
 	if (ring->scan_timestamp)
-		memcpy(buf + st->d_size - sizeof(s64),
+		memcpy(buf + indio_dev->scan_bytes - sizeof(s64),
 		       &time_ns, sizeof(time_ns));
 
 	indio_dev->buffer->access->store_to(indio_dev->buffer, buf, time_ns);
-- 
1.7.0.4

