Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41018 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787Ab2DRNOC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 09:14:02 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 05/14] staging:iio:adc:ad7192 make use of iio_sw_buffer_preenable.
Date: Wed, 18 Apr 2012 14:13:45 +0100
Message-Id: <1334754834-13622-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1334754834-13622-1-git-send-email-jic23@kernel.org>
References: <1334754834-13622-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is not a fast path, so although the original code was more consise
use the generic case to cut down on code repitition.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/ad7192.c |   22 +++++-----------------
 1 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index feb81f6..25ef3c3 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -456,31 +456,19 @@ out:
 static int ad7192_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-	size_t d_size;
 	unsigned channel;
+	int ret;
 
 	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
+	ret = iio_sw_buffer_preenable(indio_dev);
+	if (ret < 0)
+		return ret;
+
 	channel = find_first_bit(indio_dev->active_scan_mask,
 				 indio_dev->masklength);
 
-	d_size = bitmap_weight(indio_dev->active_scan_mask,
-			       indio_dev->masklength) *
-		 indio_dev->channels[0].scan_type.storagebits / 8;
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
 	st->mode  = (st->mode & ~AD7192_MODE_SEL(-1)) |
 		    AD7192_MODE_SEL(AD7192_MODE_CONT);
 	st->conf  = (st->conf & ~AD7192_CONF_CHAN(-1)) |
-- 
1.7.0.4

