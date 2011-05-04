Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 33/99] staging:iio:max1363 move to irqchip based threaded irq triggering
Date: Wed,  4 May 2011 12:58:05 +0100
Message-Id: <1304510351-10922-34-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

V2: Fixed missing free of pollfunc->name as pointed out by
Michael Hennerich.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/max1363.h      |    4 --
 drivers/staging/iio/adc/max1363_core.c |    3 -
 drivers/staging/iio/adc/max1363_ring.c |   66 ++++++++++++-------------------
 3 files changed, 26 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363.h b/drivers/staging/iio/adc/max1363.h
index 76635a0..2d41a27 100644
--- a/drivers/staging/iio/adc/max1363.h
+++ b/drivers/staging/iio/adc/max1363.h
@@ -180,8 +180,6 @@ struct max1363_chip_info {
  * @chip_info:		chip model specific constants, available modes etc
  * @current_mode:	the scan mode of this chip
  * @requestedmask:	a valid requested set of channels
- * @poll_work:		bottom half of polling interrupt handler
- * @protect_ring:	used to ensure only one polling bh running at a time
  * @reg:		supply regulator
  * @monitor_on:		whether monitor mode is enabled
  * @monitor_speed:	parameter corresponding to device monitor speed setting
@@ -197,8 +195,6 @@ struct max1363_state {
 	const struct max1363_chip_info	*chip_info;
 	const struct max1363_mode	*current_mode;
 	u32				requestedmask;
-	struct work_struct		poll_work;
-	atomic_t			protect_ring;
 	struct iio_trigger		*trig;
 	struct regulator		*reg;
 
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 78ed918..62fefb3 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -22,7 +22,6 @@
   */
 
 #include <linux/interrupt.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/sysfs.h>
@@ -1172,8 +1171,6 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	/* this is only used for device removal purposes */
 	i2c_set_clientdata(client, indio_dev);
 
-	atomic_set(&st->protect_ring, 0);
-
 	st->chip_info = &max1363_chip_info_tbl[id->driver_data];
 	st->client = client;
 
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 405f729..a387a99 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -9,8 +9,6 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -105,36 +103,11 @@ static int max1363_ring_preenable(struct iio_dev *indio_dev)
 	return 0;
 }
 
-
-/**
- * max1363_poll_func_th() - th of trigger launched polling to ring buffer
- *
- * As sampling only occurs on i2c comms occurring, leave timestamping until
- * then.  Some triggers will generate their own time stamp.  Currently
- * there is no way of notifying them when no one cares.
- **/
-static void max1363_poll_func_th(struct iio_dev *indio_dev, s64 time)
+static irqreturn_t max1363_trigger_handler(int irq, void *p)
 {
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->private_data;
 	struct max1363_state *st = iio_priv(indio_dev);
-
-	schedule_work(&st->poll_work);
-
-	return;
-}
-/**
- * max1363_poll_bh_to_ring() - bh of trigger launched polling to ring buffer
- * @work_s:	the work struct through which this was scheduled
- *
- * Currently there is no option in this driver to disable the saving of
- * timestamps within the ring.
- * I think the one copy of this at a time was to avoid problems if the
- * trigger was set far too high and the reads then locked up the computer.
- **/
-static void max1363_poll_bh_to_ring(struct work_struct *work_s)
-{
-	struct max1363_state *st = container_of(work_s, struct max1363_state,
-						  poll_work);
-	struct iio_dev *indio_dev = iio_priv_to_dev(st);
 	struct iio_sw_ring_buffer *sw_ring = iio_to_sw_ring(indio_dev->ring);
 	s64 time_ns;
 	__u8 *rxbuf;
@@ -150,20 +123,16 @@ static void max1363_poll_bh_to_ring(struct work_struct *work_s)
 	if (d_size % sizeof(s64))
 		d_size += sizeof(s64) - (d_size % sizeof(s64));
 
-	/* Ensure only one copy of this function running at a time */
-	if (atomic_inc_return(&st->protect_ring) > 1)
-		return;
-
 	/* Monitor mode prevents reading. Whilst not currently implemented
 	 * might as well have this test in here in the meantime as it does
 	 * no harm.
 	 */
 	if (numvals == 0)
-		return;
+		return IRQ_HANDLED;
 
 	rxbuf = kmalloc(d_size,	GFP_KERNEL);
 	if (rxbuf == NULL)
-		return;
+		return -ENOMEM;
 	if (st->chip_info->bits != 8)
 		b_sent = i2c_master_recv(st->client, rxbuf, numvals*2);
 	else
@@ -177,8 +146,10 @@ static void max1363_poll_bh_to_ring(struct work_struct *work_s)
 
 	indio_dev->ring->access.store_to(&sw_ring->buf, rxbuf, time_ns);
 done:
+	iio_trigger_notify_done(indio_dev->trig);
 	kfree(rxbuf);
-	atomic_dec(&st->protect_ring);
+
+	return IRQ_HANDLED;
 }
 
 
@@ -194,19 +165,33 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&indio_dev->ring->access);
-	ret = iio_alloc_pollfunc(indio_dev, NULL, &max1363_poll_func_th);
-	if (ret)
+	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
 		goto error_deallocate_sw_rb;
+	}
+	indio_dev->pollfunc->private_data = indio_dev;
+	indio_dev->pollfunc->thread = &max1363_trigger_handler;
+	indio_dev->pollfunc->type = IRQF_ONESHOT;
+	indio_dev->pollfunc->name =
+		kasprintf(GFP_KERNEL, "%s_consumer%d",
+			  st->client->name, indio_dev->id);
+	if (indio_dev->pollfunc->name == NULL) {
+		ret = -ENOMEM;
+		goto error_free_pollfunc;
+	}
 
 	/* Ring buffer functions - here trigger setup related */
 	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
 	indio_dev->ring->preenable = &max1363_ring_preenable;
 	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
-	INIT_WORK(&st->poll_work, &max1363_poll_bh_to_ring);
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
+
 	return 0;
+error_free_pollfunc:
+	kfree(indio_dev->pollfunc);
 error_deallocate_sw_rb:
 	iio_sw_rb_free(indio_dev->ring);
 error_ret:
@@ -221,6 +206,7 @@ void max1363_ring_cleanup(struct iio_dev *indio_dev)
 		iio_trigger_dettach_poll_func(indio_dev->trig,
 					      indio_dev->pollfunc);
 	}
+	kfree(indio_dev->pollfunc->name);
 	kfree(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
-- 
1.7.3.4
