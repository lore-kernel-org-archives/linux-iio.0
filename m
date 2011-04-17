Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 50/70] staging:iio:adc:ad799x move to irqchip based trigger handling.
Date: Sun, 17 Apr 2011 20:06:23 +0100
Message-Id: <1303067203-4894-51-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Untested. Also cleared out last_timestamp as it isn't used anywhere.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad799x.h      |    3 --
 drivers/staging/iio/adc/ad799x_core.c |    1 -
 drivers/staging/iio/adc/ad799x_ring.c |   60 ++++++++++++++------------------
 3 files changed, 26 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index 503fa61..331435a 100644
--- a/drivers/staging/iio/adc/ad799x.h
+++ b/drivers/staging/iio/adc/ad799x.h
@@ -113,12 +113,9 @@ struct ad799x_state {
 	struct iio_dev			*indio_dev;
 	struct i2c_client		*client;
 	const struct ad799x_chip_info	*chip_info;
-	struct work_struct		poll_work;
-	atomic_t			protect_ring;
 	size_t				d_size;
 	struct iio_trigger		*trig;
 	struct regulator		*reg;
-	s64				last_timestamp;
 	u16				int_vref_mv;
 	unsigned			id;
 	char				*name;
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 34fc85c..dadb320 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -767,7 +767,6 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 	/* this is only used for device removal purposes */
 	i2c_set_clientdata(client, st);
 
-	atomic_set(&st->protect_ring, 0);
 	st->id = id->driver_data;
 	st->chip_info = &ad799x_chip_info_tbl[st->id];
 	st->config = st->chip_info->default_config;
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 0875a7e..417f627 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -99,34 +99,17 @@ static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 }
 
 /**
- * ad799x_poll_func_th() th of trigger launched polling to ring buffer
- *
- * As sampling only occurs on i2c comms occurring, leave timestamping until
- * then.  Some triggers will generate their own time stamp.  Currently
- * there is no way of notifying them when no one cares.
- **/
-static void ad799x_poll_func_th(struct iio_dev *indio_dev, s64 time)
-{
-	struct ad799x_state *st = indio_dev->dev_data;
-
-	schedule_work(&st->poll_work);
-
-	return;
-}
-/**
- * ad799x_poll_bh_to_ring() bh of trigger launched polling to ring buffer
- * @work_s:	the work struct through which this was scheduled
+ * ad799x_trigger_handler() bh of trigger launched polling to ring buffer
  *
  * Currently there is no option in this driver to disable the saving of
  * timestamps within the ring.
- * I think the one copy of this at a time was to avoid problems if the
- * trigger was set far too high and the reads then locked up the computer.
  **/
-static void ad799x_poll_bh_to_ring(struct work_struct *work_s)
+
+static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 {
-	struct ad799x_state *st = container_of(work_s, struct ad799x_state,
-						  poll_work);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->private_data;
+	struct ad799x_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	struct iio_sw_ring_buffer *ring_sw = iio_to_sw_ring(indio_dev->ring);
 	s64 time_ns;
@@ -134,13 +117,9 @@ static void ad799x_poll_bh_to_ring(struct work_struct *work_s)
 	int b_sent;
 	u8 cmd;
 
-	/* Ensure only one copy of this function running at a time */
-	if (atomic_inc_return(&st->protect_ring) > 1)
-		return;
-
 	rxbuf = kmalloc(st->d_size, GFP_KERNEL);
 	if (rxbuf == NULL)
-		return;
+		return -ENOMEM;
 
 	switch (st->id) {
 	case ad7991:
@@ -176,7 +155,9 @@ static void ad799x_poll_bh_to_ring(struct work_struct *work_s)
 	ring->access.store_to(&ring_sw->buf, rxbuf, time_ns);
 done:
 	kfree(rxbuf);
-	atomic_dec(&st->protect_ring);
+	if (b_sent < 0)
+		return b_sent;
+	return IRQ_HANDLED;
 }
 
 
@@ -192,10 +173,20 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&st->indio_dev->ring->access);
-	ret = iio_alloc_pollfunc(indio_dev, NULL, &ad799x_poll_func_th);
-	if (ret)
+	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
 		goto error_deallocate_sw_rb;
-
+	}
+	indio_dev->pollfunc->private_data = indio_dev;
+	indio_dev->pollfunc->thread = &ad799x_trigger_handler;
+	indio_dev->pollfunc->type = IRQF_ONESHOT;
+	indio_dev->pollfunc->name =
+		kasprintf(GFP_KERNEL, "adis16203_consumer%d", indio_dev->id);
+	if (indio_dev->pollfunc->name == NULL) {
+		ret = -ENOMEM;
+		goto error_free_poll_func;
+	}
 	/* Ring buffer functions - here trigger setup related */
 
 	indio_dev->ring->preenable = &ad799x_ring_preenable;
@@ -203,13 +194,13 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
 	indio_dev->ring->scan_timestamp = true;
 
-	INIT_WORK(&st->poll_work, &ad799x_poll_bh_to_ring);
-
 	indio_dev->ring->scan_el_attrs = st->chip_info->scan_attrs;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
+error_free_poll_func:
+	kfree(indio_dev->pollfunc);
 error_deallocate_sw_rb:
 	iio_sw_rb_free(indio_dev->ring);
 error_ret:
@@ -224,6 +215,7 @@ void ad799x_ring_cleanup(struct iio_dev *indio_dev)
 		iio_trigger_dettach_poll_func(indio_dev->trig,
 					      indio_dev->pollfunc);
 	}
+	kfree(indio_dev->pollfunc->name);
 	kfree(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
-- 
1.7.3.4
