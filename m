Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:35286 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756764Ab1JTQ30 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2011 12:29:26 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 5/5] staging:iio:adc:max1363 use new demuxing support.
Date: Thu, 20 Oct 2011 17:29:29 +0100
Message-Id: <1319128169-3722-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319128169-3722-1-git-send-email-jic23@cam.ac.uk>
References: <1319128169-3722-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Note that time stamps are not currently supported
hence for now I've cheekly removed them from this
driver.  Also hence no sign off.
---
 drivers/staging/iio/adc/max1363_core.c |    4 ----
 drivers/staging/iio/adc/max1363_ring.c |   27 ++++++---------------------
 2 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index eb699ad..8f19d2d 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -325,7 +325,6 @@ static const enum max1363_modes max1363_mode_list[] = {
 	MAX1363_CHAN_B(2, 3, d2m3, 5, bits, em),	\
 	MAX1363_CHAN_B(1, 0, d1m0, 6, bits, em),	\
 	MAX1363_CHAN_B(3, 2, d3m2, 7, bits, em),	\
-	IIO_CHAN_SOFT_TIMESTAMP(8)			\
 	}
 
 static struct iio_chan_spec max1036_channels[] = MAX1363_4X_CHANS(8, 0);
@@ -383,7 +382,6 @@ static const enum max1363_modes max1238_mode_list[] = {
 	MAX1363_CHAN_B(7, 6, d7m6, 21, bits, 0),	\
 	MAX1363_CHAN_B(9, 8, d9m8, 22, bits, 0),	\
 	MAX1363_CHAN_B(11, 10, d11m10, 23, bits, 0),	\
-	IIO_CHAN_SOFT_TIMESTAMP(24)			\
 	}
 static struct iio_chan_spec max1038_channels[] = MAX1363_12X_CHANS(8);
 static struct iio_chan_spec max1138_channels[] = MAX1363_12X_CHANS(10);
@@ -424,7 +422,6 @@ static const enum max1363_modes max11608_mode_list[] = {
 	MAX1363_CHAN_B(3, 2, d3m2, 13, bits, 0),	\
 	MAX1363_CHAN_B(5, 4, d5m4, 14, bits, 0),	\
 	MAX1363_CHAN_B(7, 6, d7m6, 15, bits, 0),	\
-	IIO_CHAN_SOFT_TIMESTAMP(16)			\
 }
 static struct iio_chan_spec max11602_channels[] = MAX1363_8X_CHANS(8);
 static struct iio_chan_spec max11608_channels[] = MAX1363_8X_CHANS(10);
@@ -439,7 +436,6 @@ static const enum max1363_modes max11644_mode_list[] = {
 	MAX1363_CHAN_U(1, _s1, 1, bits, 0),		\
 	MAX1363_CHAN_B(0, 1, d0m1, 2, bits, 0),	\
 	MAX1363_CHAN_B(1, 0, d1m0, 3, bits, 0),	\
-	IIO_CHAN_SOFT_TIMESTAMP(4)			\
 	}
 
 static struct iio_chan_spec max11646_channels[] = MAX1363_2X_CHANS(10);
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index df6893e..294dec9 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -68,36 +68,21 @@ error_ret:
 static int max1363_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct max1363_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-	size_t d_size = 0;
-	unsigned long numvals;
 
 	/*
 	 * Need to figure out the current mode based upon the requested
 	 * scan mask in iio_dev
 	 */
-	st->current_mode = max1363_match_mode(ring->scan_mask,
-					st->chip_info);
+	st->current_mode = max1363_match_mode(indio_dev->buffer->scan_mask,
+					      st->chip_info);
 	if (!st->current_mode)
 		return -EINVAL;
-
 	max1363_set_scan_mode(st);
 
-	numvals = bitmap_weight(st->current_mode->modemask,
-				indio_dev->masklength);
-	if (ring->access->set_bytes_per_datum) {
-		if (ring->scan_timestamp)
-			d_size += sizeof(s64);
-		if (st->chip_info->bits != 8)
-			d_size += numvals*2;
-		else
-			d_size += numvals;
-		if (ring->scan_timestamp && (d_size % 8))
-			d_size += 8 - (d_size % 8);
-		ring->access->set_bytes_per_datum(ring, d_size);
-	}
+	/* work out how to pull out the channels we actually want */
+	iio_update_demux(indio_dev);
 
-	return 0;
+	return iio_sw_buffer_preenable(indio_dev);
 }
 
 static irqreturn_t max1363_trigger_handler(int irq, void *p)
@@ -141,7 +126,7 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 
 	memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
 
-	indio_dev->buffer->access->store_to(indio_dev->buffer, rxbuf, time_ns);
+	iio_push_to_buffer(indio_dev->buffer, rxbuf, time_ns);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(rxbuf);
-- 
1.7.7

