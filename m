Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 049/111] staging:iio:adc:ad7887 move to irqchip based trigger handling.
Date: Wed, 18 May 2011 14:41:39 +0100
Message-Id: <1305726161-5606-50-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Untested.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7887.h      |    2 -
 drivers/staging/iio/adc/ad7887_core.c |    1 -
 drivers/staging/iio/adc/ad7887_ring.c |   62 ++++++++++++++------------------
 3 files changed, 27 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7887.h b/drivers/staging/iio/adc/ad7887.h
index 439c802..ffff403 100644
--- a/drivers/staging/iio/adc/ad7887.h
+++ b/drivers/staging/iio/adc/ad7887.h
@@ -61,8 +61,6 @@ struct ad7887_state {
 	struct spi_device		*spi;
 	const struct ad7887_chip_info	*chip_info;
 	struct regulator		*reg;
-	struct work_struct		poll_work;
-	atomic_t			protect_ring;
 	size_t				d_size;
 	u16				int_vref_mv;
 	bool				en_dual;
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 11c9fcf..42e9cd7 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -150,7 +150,6 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, st);
 
-	atomic_set(&st->protect_ring, 0);
 	st->spi = spi;
 
 	st->indio_dev = iio_allocate_device(0);
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index da77f26..df5a2ae 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -163,48 +163,27 @@ static int ad7887_ring_postdisable(struct iio_dev *indio_dev)
 }
 
 /**
- * ad7887_poll_func_th() th of trigger launched polling to ring buffer
- *
- * As sampling only occurs on spi comms occurring, leave timestamping until
- * then.  Some triggers will generate their own time stamp.  Currently
- * there is no way of notifying them when no one cares.
- **/
-static void ad7887_poll_func_th(struct iio_dev *indio_dev, s64 time)
-{
-	struct ad7887_state *st = indio_dev->dev_data;
-
-	schedule_work(&st->poll_work);
-	return;
-}
-/**
- * ad7887_poll_bh_to_ring() bh of trigger launched polling to ring buffer
- * @work_s:	the work struct through which this was scheduled
+ * ad7887_trigger_handler() bh of trigger launched polling to ring buffer
  *
  * Currently there is no option in this driver to disable the saving of
  * timestamps within the ring.
- * I think the one copy of this at a time was to avoid problems if the
- * trigger was set far too high and the reads then locked up the computer.
  **/
-static void ad7887_poll_bh_to_ring(struct work_struct *work_s)
+static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 {
-	struct ad7887_state *st = container_of(work_s, struct ad7887_state,
-						  poll_work);
-	struct iio_dev *indio_dev = st->indio_dev;
-	struct iio_sw_ring_buffer *sw_ring = iio_to_sw_ring(indio_dev->ring);
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->private_data;
+	struct ad7887_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_sw_ring_buffer *sw_ring = iio_to_sw_ring(indio_dev->ring);
 	s64 time_ns;
 	__u8 *buf;
 	int b_sent;
 
 	unsigned int bytes = ring->scan_count * st->chip_info->storagebits / 8;
 
-	/* Ensure only one copy of this function running at a time */
-	if (atomic_inc_return(&st->protect_ring) > 1)
-		return;
-
 	buf = kzalloc(st->d_size, GFP_KERNEL);
 	if (buf == NULL)
-		return;
+		return -ENOMEM;
 
 	b_sent = spi_sync(st->spi, st->ring_msg);
 	if (b_sent)
@@ -215,17 +194,17 @@ static void ad7887_poll_bh_to_ring(struct work_struct *work_s)
 	memcpy(buf, st->data, bytes);
 	if (ring->scan_timestamp)
 		memcpy(buf + st->d_size - sizeof(s64),
-			&time_ns, sizeof(time_ns));
+		       &time_ns, sizeof(time_ns));
 
 	indio_dev->ring->access.store_to(&sw_ring->buf, buf, time_ns);
 done:
 	kfree(buf);
-	atomic_dec(&st->protect_ring);
+
+	return IRQ_HANDLED;
 }
 
 int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
-	struct ad7887_state *st = indio_dev->dev_data;
 	int ret;
 
 	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
@@ -235,10 +214,22 @@ int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&indio_dev->ring->access);
-	ret = iio_alloc_pollfunc(indio_dev, NULL, &ad7887_poll_func_th);
-	if (ret)
+	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
 		goto error_deallocate_sw_rb;
+	}
 
+	indio_dev->pollfunc->private_data = indio_dev;
+	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
+	indio_dev->pollfunc->thread = &ad7887_trigger_handler;
+	indio_dev->pollfunc->type = IRQF_ONESHOT;
+	indio_dev->pollfunc->name =
+		kasprintf(GFP_KERNEL, "ad7887_consumer%d", indio_dev->id);
+	if (indio_dev->pollfunc->name == NULL) {
+		ret = -ENOMEM;
+		goto error_free_pollfunc;
+	}
 	/* Ring buffer functions - here trigger setup related */
 
 	indio_dev->ring->preenable = &ad7887_ring_preenable;
@@ -248,11 +239,11 @@ int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->ring->scan_el_attrs = &ad7887_scan_el_group;
 	indio_dev->ring->scan_timestamp = true;
 
-	INIT_WORK(&st->poll_work, &ad7887_poll_bh_to_ring);
-
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
+error_free_pollfunc:
+	kfree(indio_dev->pollfunc);
 error_deallocate_sw_rb:
 	iio_sw_rb_free(indio_dev->ring);
 error_ret:
@@ -267,6 +258,7 @@ void ad7887_ring_cleanup(struct iio_dev *indio_dev)
 		iio_trigger_dettach_poll_func(indio_dev->trig,
 					      indio_dev->pollfunc);
 	}
+	kfree(indio_dev->pollfunc->name);
 	kfree(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
-- 
1.7.3.4
