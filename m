Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41058 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab2DRNOD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 09:14:03 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 11/14] staging:iio:meter:ad7758 use iio_sw_buffer_preenable to avoid code repition
Date: Wed, 18 Apr 2012 14:13:51 +0100
Message-Id: <1334754834-13622-12-git-send-email-jic23@kernel.org>
In-Reply-To: <1334754834-13622-1-git-send-email-jic23@kernel.org>
References: <1334754834-13622-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using this generic function adds a little overhead to a slow path but
reduces the amount of code repitition in exchange.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/meter/ade7758_ring.c |   20 +++++---------------
 1 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index c45b23b..3dfd788 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -92,29 +92,19 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 static int ade7758_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ade7758_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-	size_t d_size;
 	unsigned channel;
+	int ret;
 
 	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
+	ret = iio_sw_buffer_preenable(indio_dev);
+	if (ret < 0)
+		return ret;
+
 	channel = find_first_bit(indio_dev->active_scan_mask,
 				 indio_dev->masklength);
 
-	d_size = st->ade7758_ring_channels[channel].scan_type.storagebits / 8;
-
-	if (ring->scan_timestamp) {
-		d_size += sizeof(s64);
-
-		if (d_size % sizeof(s64))
-			d_size += sizeof(s64) - (d_size % sizeof(s64));
-	}
-
-	if (indio_dev->buffer->access->set_bytes_per_datum)
-		indio_dev->buffer->access->
-			set_bytes_per_datum(indio_dev->buffer, d_size);
-
 	ade7758_write_waveform_type(&indio_dev->dev,
 		st->ade7758_ring_channels[channel].address);
 
-- 
1.7.0.4

