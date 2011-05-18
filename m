Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 047/111] staging:iio:adc:ad7298 move to irqchip based trigger handling.
Date: Wed, 18 May 2011 14:41:37 +0100
Message-Id: <1305726161-5606-48-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Untested. This one is of a different form, so worth a closer look than
the previous incredibly similar patches (which were based on the
adis16400 that I have tested).

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7298.h      |    2 -
 drivers/staging/iio/adc/ad7298_core.c |    2 -
 drivers/staging/iio/adc/ad7298_ring.c |   65 +++++++++++++--------------------
 3 files changed, 26 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7298.h b/drivers/staging/iio/adc/ad7298.h
index fe7ed77..8d149c8 100644
--- a/drivers/staging/iio/adc/ad7298.h
+++ b/drivers/staging/iio/adc/ad7298.h
@@ -40,8 +40,6 @@ struct ad7298_state {
 	struct iio_dev			*indio_dev;
 	struct spi_device		*spi;
 	struct regulator		*reg;
-	struct work_struct		poll_work;
-	atomic_t			protect_ring;
 	size_t				d_size;
 	u16				int_vref_mv;
 	unsigned			ext_ref;
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 8b3a490..40bbb42 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -6,7 +6,6 @@
  * Licensed under the GPL-2.
  */
 
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -170,7 +169,6 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, st);
 
-	atomic_set(&st->protect_ring, 0);
 	st->spi = spi;
 
 	st->indio_dev = iio_allocate_device(0);
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index 9068d7f..1b9752c 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -155,47 +154,24 @@ static int ad7298_ring_preenable(struct iio_dev *indio_dev)
 }
 
 /**
- * ad7298_poll_func_th() th of trigger launched polling to ring buffer
- *
- * As sampling only occurs on spi comms occurring, leave timestamping until
- * then.  Some triggers will generate their own time stamp.  Currently
- * there is no way of notifying them when no one cares.
- **/
-static void ad7298_poll_func_th(struct iio_dev *indio_dev, s64 time)
-{
-	struct ad7298_state *st = indio_dev->dev_data;
-
-	schedule_work(&st->poll_work);
-	return;
-}
-
-/**
- * ad7298_poll_bh_to_ring() bh of trigger launched polling to ring buffer
- * @work_s:	the work struct through which this was scheduled
+ * ad7298_trigger_handler() bh of trigger launched polling to ring buffer
  *
  * Currently there is no option in this driver to disable the saving of
  * timestamps within the ring.
- * I think the one copy of this at a time was to avoid problems if the
- * trigger was set far too high and the reads then locked up the computer.
  **/
-static void ad7298_poll_bh_to_ring(struct work_struct *work_s)
+static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 {
-	struct ad7298_state *st = container_of(work_s, struct ad7298_state,
-						  poll_work);
-	struct iio_dev *indio_dev = st->indio_dev;
-	struct iio_sw_ring_buffer *sw_ring = iio_to_sw_ring(indio_dev->ring);
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->private_data;
+	struct ad7298_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	s64 time_ns;
 	__u16 buf[16];
 	int b_sent, i;
 
-	/* Ensure only one copy of this function running at a time */
-	if (atomic_inc_return(&st->protect_ring) > 1)
-		return;
-
 	b_sent = spi_sync(st->spi, &st->ring_msg);
 	if (b_sent)
-		goto done;
+		return b_sent;
 
 	if (ring->scan_timestamp) {
 		time_ns = iio_get_time_ns();
@@ -206,14 +182,13 @@ static void ad7298_poll_bh_to_ring(struct work_struct *work_s)
 	for (i = 0; i < ring->scan_count; i++)
 		buf[i] = be16_to_cpu(st->rx_buf[i]);
 
-	indio_dev->ring->access.store_to(&sw_ring->buf, (u8 *)buf, time_ns);
-done:
-	atomic_dec(&st->protect_ring);
+	indio_dev->ring->access.store_to(ring, (u8 *)buf, time_ns);
+
+	return IRQ_HANDLED;
 }
 
 int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
-	struct ad7298_state *st = indio_dev->dev_data;
 	int ret;
 
 	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
@@ -223,10 +198,21 @@ int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&indio_dev->ring->access);
-	ret = iio_alloc_pollfunc(indio_dev, NULL, &ad7298_poll_func_th);
-	if (ret)
-		goto error_deallocate_sw_rb;
 
+	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
+		goto error_deallocate_sw_rb;
+	}
+	indio_dev->pollfunc->private_data = indio_dev;
+	indio_dev->pollfunc->thread = &ad7298_trigger_handler;
+	indio_dev->pollfunc->type = IRQF_ONESHOT;
+	indio_dev->pollfunc->name =
+		kasprintf(GFP_KERNEL, "ad7298_consumer%d", indio_dev->id);
+	if (indio_dev->pollfunc->name == NULL) {
+		ret = -ENOMEM;
+		goto error_free_poll_func;
+	}
 	/* Ring buffer functions - here trigger setup related */
 
 	indio_dev->ring->preenable = &ad7298_ring_preenable;
@@ -235,11 +221,11 @@ int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->ring->scan_el_attrs = &ad7298_scan_el_group;
 	indio_dev->ring->scan_timestamp = true;
 
-	INIT_WORK(&st->poll_work, &ad7298_poll_bh_to_ring);
-
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
+error_free_poll_func:
+	kfree(indio_dev->pollfunc);
 error_deallocate_sw_rb:
 	iio_sw_rb_free(indio_dev->ring);
 error_ret:
@@ -253,6 +239,7 @@ void ad7298_ring_cleanup(struct iio_dev *indio_dev)
 		iio_trigger_dettach_poll_func(indio_dev->trig,
 					      indio_dev->pollfunc);
 	}
+	kfree(indio_dev->pollfunc->name);
 	kfree(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
-- 
1.7.3.4
