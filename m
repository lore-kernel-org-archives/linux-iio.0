Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 6/7] staging:iio:adc:max1363 use new demuxing support.
Date: Sun, 27 Nov 2011 13:10:11 +0000
Message-Id: <1322399412-21622-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1322399412-21622-1-git-send-email-jic23@kernel.org>
References: <1322399412-21622-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@cam.ac.uk>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/max1363.h      |   11 +++++-
 drivers/staging/iio/adc/max1363_core.c |    4 ++-
 drivers/staging/iio/adc/max1363_ring.c |   51 +++++++++-----------------------
 3 files changed, 26 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363.h b/drivers/staging/iio/adc/max1363.h
index cbcb08a..fb52783 100644
--- a/drivers/staging/iio/adc/max1363.h
+++ b/drivers/staging/iio/adc/max1363.h
@@ -146,18 +146,25 @@ struct max1363_state {
 };
 
 const struct max1363_mode
-*max1363_match_mode(unsigned long *mask, const struct max1363_chip_info *ci);
+*max1363_match_mode(const unsigned long *mask,
+		    const struct max1363_chip_info *ci);
 
 int max1363_set_scan_mode(struct max1363_state *st);
 
 #ifdef CONFIG_MAX1363_RING_BUFFER
-
+int max1363_update_scan_mode(struct iio_dev *indio_dev,
+			     const unsigned long *scan_mask);
 int max1363_single_channel_from_ring(const long *mask,
 				     struct max1363_state *st);
 int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void max1363_ring_cleanup(struct iio_dev *indio_dev);
 
 #else /* CONFIG_MAX1363_RING_BUFFER */
+int max1363_update_scan_mode(struct iio_dev *indio_dev,
+			     const long *scan_mask)
+{
+	return 0;
+}
 
 int max1363_single_channel_from_ring(long mask, struct max1363_state *st)
 {
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index c3e28e1..7e078fc 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -148,7 +148,8 @@ static const struct max1363_mode max1363_mode_table[] = {
 };
 
 const struct max1363_mode
-*max1363_match_mode(unsigned long *mask, const struct max1363_chip_info *ci)
+*max1363_match_mode(const unsigned long *mask,
+const struct max1363_chip_info *ci)
 {
 	int i;
 	if (mask)
@@ -834,6 +835,7 @@ static const struct iio_info max1363_info = {
 	.read_event_config = &max1363_read_event_config,
 	.write_event_config = &max1363_write_event_config,
 	.read_raw = &max1363_read_raw,
+	.update_scan_mode = &max1363_update_scan_mode,
 	.driver_module = THIS_MODULE,
 	.event_attrs = &max1363_event_attribute_group,
 };
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 3c5e199..19977a6 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -57,46 +57,19 @@ error_ret:
 	return ret;
 }
 
-
-/**
- * max1363_ring_preenable() - setup the parameters of the ring before enabling
- *
- * The complex nature of the setting of the nuber of bytes per datum is due
- * to this driver currently ensuring that the timestamp is stored at an 8
- * byte boundary.
- **/
-static int max1363_ring_preenable(struct iio_dev *indio_dev)
+int max1363_update_scan_mode(struct iio_dev *indio_dev,
+			     const unsigned long *scan_mask)
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
+	st->current_mode = max1363_match_mode(scan_mask, st->chip_info);
 	if (!st->current_mode)
 		return -EINVAL;
-
 	max1363_set_scan_mode(st);
-
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
-
 	return 0;
 }
 
@@ -114,12 +87,14 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 
 	/* Ensure the timestamp is 8 byte aligned */
 	if (st->chip_info->bits != 8)
-		d_size = numvals*2 + sizeof(s64);
+		d_size = numvals*2;
 	else
-		d_size = numvals + sizeof(s64);
-	if (d_size % sizeof(s64))
-		d_size += sizeof(s64) - (d_size % sizeof(s64));
-
+		d_size = numvals;
+	if (indio_dev->buffer->scan_timestamp) {
+		d_size += sizeof(s64);
+		if (d_size % sizeof(s64))
+			d_size += sizeof(s64) - (d_size % sizeof(s64));
+	}
 	/* Monitor mode prevents reading. Whilst not currently implemented
 	 * might as well have this test in here in the meantime as it does
 	 * no harm.
@@ -138,9 +113,11 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 		goto done;
 
 	time_ns = iio_get_time_ns();
+
 	if (indio_dev->buffer->scan_timestamp)
 		memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
-	indio_dev->buffer->access->store_to(indio_dev->buffer, rxbuf, time_ns);
+	iio_push_to_buffer(indio_dev->buffer, rxbuf, time_ns);
+
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(rxbuf);
@@ -150,7 +127,7 @@ done:
 
 static const struct iio_buffer_setup_ops max1363_ring_setup_ops = {
 	.postenable = &iio_triggered_buffer_postenable,
-	.preenable = &max1363_ring_preenable,
+	.preenable = &iio_sw_buffer_preenable,
 	.predisable = &iio_triggered_buffer_predisable,
 };
 
-- 
1.7.7.3
