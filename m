Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41024 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab2DRNOC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 09:14:02 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 06/14] staging:iio:adc:ad7298 use iio_sw_buffer_preenable to avoid code repitition.
Date: Wed, 18 Apr 2012 14:13:46 +0100
Message-Id: <1334754834-13622-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1334754834-13622-1-git-send-email-jic23@kernel.org>
References: <1334754834-13622-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Here some addition elements are needed, but this generic function cuts
down on the amount of code.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/ad7298.h      |    1 -
 drivers/staging/iio/adc/ad7298_ring.c |   24 ++++++++----------------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7298.h b/drivers/staging/iio/adc/ad7298.h
index a0e5dea..5051a7e 100644
--- a/drivers/staging/iio/adc/ad7298.h
+++ b/drivers/staging/iio/adc/ad7298.h
@@ -38,7 +38,6 @@ struct ad7298_platform_data {
 struct ad7298_state {
 	struct spi_device		*spi;
 	struct regulator		*reg;
-	size_t				d_size;
 	u16				int_vref_mv;
 	unsigned			ext_ref;
 	struct spi_transfer		ring_xfer[10];
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index feeb0ee..5c13690 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -28,25 +28,17 @@
 static int ad7298_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7298_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-	size_t d_size;
 	int i, m;
 	unsigned short command;
-	int scan_count = bitmap_weight(indio_dev->active_scan_mask,
-				       indio_dev->masklength);
-	d_size = scan_count * (AD7298_STORAGE_BITS / 8);
-
-	if (ring->scan_timestamp) {
-		d_size += sizeof(s64);
-
-		if (d_size % sizeof(s64))
-			d_size += sizeof(s64) - (d_size % sizeof(s64));
-	}
+	int scan_count, ret;
 
-	if (ring->access->set_bytes_per_datum)
-		ring->access->set_bytes_per_datum(ring, d_size);
+	ret = iio_sw_buffer_preenable(indio_dev);
+	if (ret < 0)
+		return ret;
 
-	st->d_size = d_size;
+	/* Now compute overall size */
+	scan_count = bitmap_weight(indio_dev->active_scan_mask,
+				   indio_dev->masklength);
 
 	command = AD7298_WRITE | st->ext_ref;
 
@@ -102,7 +94,7 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 
 	if (ring->scan_timestamp) {
 		time_ns = iio_get_time_ns();
-		memcpy((u8 *)buf + st->d_size - sizeof(s64),
+		memcpy((u8 *)buf + indio_dev->scan_bytes - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 	}
 
-- 
1.7.0.4

