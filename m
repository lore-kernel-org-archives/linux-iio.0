Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 13/16] staging;iio:adc:ad7606 use iio_sw_buffer_preenable rather than local equiv
Date: Fri, 23 Sep 2011 13:01:39 +0100
Message-Id: <1316779302-12357-14-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Other than a few slight refactorings the local version was pretty standard
so replace it and rework to get rid of st->d_size which it setup.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7606.h      |    1 -
 drivers/staging/iio/adc/ad7606_ring.c |   42 +++++---------------------------
 2 files changed, 7 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 8fc259f..bc95f09 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -68,7 +68,6 @@ struct ad7606_state {
 	struct regulator		*reg;
 	struct work_struct		poll_work;
 	wait_queue_head_t		wq_data_avail;
-	size_t				d_size;
 	const struct ad7606_bus_ops	*bops;
 	int				irq;
 	unsigned			id;
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index f0742d6..20927fd 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -43,37 +43,6 @@ error_ret:
 }
 
 /**
- * ad7606_ring_preenable() setup the parameters of the ring before enabling
- *
- * The complex nature of the setting of the nuber of bytes per datum is due
- * to this driver currently ensuring that the timestamp is stored at an 8
- * byte boundary.
- **/
-static int ad7606_ring_preenable(struct iio_dev *indio_dev)
-{
-	struct ad7606_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-	size_t d_size;
-
-	d_size = st->chip_info->num_channels *
-		 st->chip_info->channels[0].scan_type.storagebits / 8;
-
-	if (ring->scan_timestamp) {
-		d_size += sizeof(s64);
-
-		if (d_size % sizeof(s64))
-			d_size += sizeof(s64) - (d_size % sizeof(s64));
-	}
-
-	if (ring->access->set_bytes_per_datum)
-		ring->access->set_bytes_per_datum(ring, d_size);
-
-	st->d_size = d_size;
-
-	return 0;
-}
-
-/**
  * ad7606_trigger_handler_th() th/bh of trigger launched polling to ring buffer
  *
  **/
@@ -106,7 +75,8 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 	__u8 *buf;
 	int ret;
 
-	buf = kzalloc(st->d_size, GFP_KERNEL);
+	buf = kzalloc(ring->access->get_bytes_per_datum(ring),
+		      GFP_KERNEL);
 	if (buf == NULL)
 		return;
 
@@ -137,8 +107,8 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 	time_ns = iio_get_time_ns();
 
 	if (ring->scan_timestamp)
-		memcpy(buf + st->d_size - sizeof(s64),
-			&time_ns, sizeof(time_ns));
+		*((s64 *)(buf + ring->access->get_bytes_per_datum(ring) -
+			  sizeof(s64))) = time_ns;
 
 	ring->access->store_to(indio_dev->buffer, buf, time_ns);
 done:
@@ -148,7 +118,7 @@ done:
 }
 
 static const struct iio_buffer_setup_ops ad7606_ring_setup_ops = {
-	.preenable = &ad7606_ring_preenable,
+	.preenable = &iio_sw_buffer_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
 };
@@ -166,6 +136,8 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 
 	/* Effectively select the ring buffer implementation */
 	indio_dev->buffer->access = &ring_sw_access_funcs;
+	indio_dev->buffer->bpe =
+		st->chip_info->channels[0].scan_type.storagebits / 8;
 	indio_dev->pollfunc = iio_alloc_pollfunc(&ad7606_trigger_handler_th_bh,
 						 &ad7606_trigger_handler_th_bh,
 						 0,
-- 
1.7.3.4
