Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 32/99] staging:iio:lis3l02dq move to threaded trigger handling.
Date: Wed,  4 May 2011 12:58:04 +0100
Message-Id: <1304510351-10922-33-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

V2: Cleaned up handling of name string.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq.h      |    2 -
 drivers/staging/iio/accel/lis3l02dq_core.c |    6 -
 drivers/staging/iio/accel/lis3l02dq_ring.c |  139 +++++++++++-----------------
 3 files changed, 56 insertions(+), 91 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
index 67f312d..a910f2d 100644
--- a/drivers/staging/iio/accel/lis3l02dq.h
+++ b/drivers/staging/iio/accel/lis3l02dq.h
@@ -150,7 +150,6 @@ Form of high byte dependent on justification set in ctrl reg */
  * struct lis3l02dq_state - device instance specific data
  * @helper:		data and func pointer allowing generic functions
  * @us:			actual spi_device
- * @inter:		used to check if new interrupt has been triggered
  * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
  * @rx:			receive buffer
@@ -159,7 +158,6 @@ Form of high byte dependent on justification set in ctrl reg */
 struct lis3l02dq_state {
 	struct iio_sw_ring_helper_state	help;
 	struct spi_device		*us;
-	bool				inter;
 	struct iio_trigger		*trig;
 	u8				*tx;
 	u8				*rx;
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 6c5f8a6..b1fb049 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -15,15 +15,12 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
-#include <linux/workqueue.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
-
 #include <linux/sysfs.h>
-#include <linux/list.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
@@ -724,7 +721,6 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	}
 
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
-		st->inter = 0;
 		ret = lis3l02dq_probe_trigger(st->help.indio_dev);
 		if (ret)
 			goto error_uninitialize_ring;
@@ -800,8 +796,6 @@ static int lis3l02dq_remove(struct spi_device *spi)
 	if (ret)
 		goto err_ret;
 
-	flush_scheduled_work();
-
 	lis3l02dq_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(indio_dev->ring);
 	lis3l02dq_unconfigure_ring(indio_dev);
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 9bc2e5f..d261bd6 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -1,13 +1,11 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
-#include <linux/workqueue.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/slab.h>
 
 #include "../iio.h"
@@ -29,37 +27,6 @@ static inline u16 combine_8_to_16(u8 lower, u8 upper)
 }
 
 /**
- * lis3l02dq_poll_func_th() top half interrupt handler called by trigger
- * @private_data:	iio_dev
- **/
-static void lis3l02dq_poll_func_th(struct iio_dev *indio_dev, s64 time)
-{
-	struct iio_sw_ring_helper_state *h
-		= iio_dev_get_devdata(indio_dev);
-	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
-	/* in this case we need to slightly extend the helper function */
-	iio_sw_poll_func_th(indio_dev, time);
-
-	/* Indicate that this interrupt is being handled */
-	/* Technically this is trigger related, but without this
-	 * handler running there is currently now way for the interrupt
-	 * to clear.
-	 */
-	st->inter = 1;
-}
-
-/**
- * lis3l02dq_data_rdy_trig_poll() the event handler for the data rdy trig
- **/
-static irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private)
-{
-	disable_irq_nosync(irq);
-	iio_trigger_poll(private, iio_get_time_ns());
-
-	return IRQ_HANDLED;
-}
-
-/**
  * lis3l02dq_read_accel_from_ring() individual acceleration read from ring
  **/
 ssize_t lis3l02dq_read_accel_from_ring(struct iio_ring_buffer *ring,
@@ -153,15 +120,16 @@ static int lis3l02dq_read_all(struct lis3l02dq_state *st, u8 *rx_array)
 	return ret;
 }
 
-static void lis3l02dq_trigger_bh_to_ring(struct work_struct *work_s)
+static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 {
-	struct iio_sw_ring_helper_state *h
-		= container_of(work_s, struct iio_sw_ring_helper_state,
-			work_trigger_to_ring);
-	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev);
 
-	st->inter = 0;
-	iio_sw_trigger_bh_to_ring(work_s);
+	h->last_timestamp = pf->timestamp;
+	iio_sw_trigger_to_ring(h);
+
+	return IRQ_HANDLED;
 }
 
 static int lis3l02dq_get_ring_element(struct iio_sw_ring_helper_state *h,
@@ -236,7 +204,7 @@ __lis3l02dq_write_data_ready_config(struct device *dev, bool state)
 		valold = ret |
 			LIS3L02DQ_REG_CTRL_2_ENABLE_DATA_READY_GENERATION;
 		ret = request_irq(st->us->irq,
-				  lis3l02dq_data_rdy_trig_poll,
+				  &iio_trigger_generic_data_rdy_poll,
 				  IRQF_TRIGGER_RISING, "lis3l02dq_datardy",
 				  st->trig);
 		if (ret)
@@ -272,10 +240,10 @@ static int lis3l02dq_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 	__lis3l02dq_write_data_ready_config(&st->help.indio_dev->dev, state);
 	if (state == false) {
-		/* possible quirk with handler currently worked around
-		   by ensuring the work queue is empty */
-		flush_scheduled_work();
-		/* Clear any outstanding ready events */
+		/*
+		 * A possible quirk with teh handler is currently worked around
+		 *  by ensuring outstanding read events are cleared.
+		 */
 		ret = lis3l02dq_read_all(st, NULL);
 	}
 	lis3l02dq_spi_read_reg_8(st->help.indio_dev,
@@ -298,32 +266,23 @@ static const struct attribute_group lis3l02dq_trigger_attr_group = {
 /**
  * lis3l02dq_trig_try_reen() try renabling irq for data rdy trigger
  * @trig:	the datardy trigger
- *
- * As the trigger may occur on any data element being updated it is
- * really rather likely to occur during the read from the previous
- * trigger event.  The only way to discover if this has occurred on
- * boards not supporting level interrupts is to take a look at the line.
- * If it is indicating another interrupt and we don't seem to have a
- * handler looking at it, then we need to notify the core that we need
- * to tell the triggering core to try reading all these again.
- **/
+ */
 static int lis3l02dq_trig_try_reen(struct iio_trigger *trig)
 {
 	struct lis3l02dq_state *st = trig->private_data;
-	enable_irq(st->us->irq);
+	int i;
+
 	/* If gpio still high (or high again) */
-	if (gpio_get_value(irq_to_gpio(st->us->irq)))
-		if (st->inter == 0) {
-			/* already interrupt handler dealing with it */
-			disable_irq_nosync(st->us->irq);
-			if (st->inter == 1) {
-				/* interrupt handler snuck in between test
-				 * and disable */
-				enable_irq(st->us->irq);
-				return 0;
-			}
-			return -EAGAIN;
-		}
+	/* In theory possible we will need to do this several times */
+	for (i = 0; i < 5; i++)
+		if (gpio_get_value(irq_to_gpio(st->us->irq)))
+			lis3l02dq_read_all(st, NULL);
+		else
+			break;
+	if (i == 5)
+		printk(KERN_INFO
+		       "Failed to clear the interrupt for lis3l02dq\n");
+
 	/* irq reenabled so success! */
 	return 0;
 }
@@ -334,17 +293,19 @@ int lis3l02dq_probe_trigger(struct iio_dev *indio_dev)
 	struct iio_sw_ring_helper_state *h
 		= iio_dev_get_devdata(indio_dev);
 	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
+	char *name;
 
-	st->trig = iio_allocate_trigger();
-	if (!st->trig)
-		return -ENOMEM;
-
-	st->trig->name = kasprintf(GFP_KERNEL,
-				   "lis3l02dq-dev%d",
-				   indio_dev->id);
-	if (!st->trig->name) {
+	name = kasprintf(GFP_KERNEL,
+			 "lis3l02dq-dev%d",
+			 indio_dev->id);
+	if (name == NULL) {
 		ret = -ENOMEM;
-		goto error_free_trig;
+		goto error_ret;
+	}
+	st->trig = iio_allocate_trigger_named(name);
+	if (!st->trig) {
+		ret = -ENOMEM;
+		goto error_free_name;
 	}
 
 	st->trig->dev.parent = &st->us->dev;
@@ -355,15 +316,15 @@ int lis3l02dq_probe_trigger(struct iio_dev *indio_dev)
 	st->trig->control_attrs = &lis3l02dq_trigger_attr_group;
 	ret = iio_trigger_register(st->trig);
 	if (ret)
-		goto error_free_trig_name;
+		goto error_free_trig;
 
 	return 0;
 
-error_free_trig_name:
-	kfree(st->trig->name);
 error_free_trig:
 	iio_free_trigger(st->trig);
-
+error_free_name:
+	kfree(name);
+error_ret:
 	return ret;
 }
 
@@ -380,6 +341,7 @@ void lis3l02dq_remove_trigger(struct iio_dev *indio_dev)
 
 void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev)
 {
+	kfree(indio_dev->pollfunc->name);
 	kfree(indio_dev->pollfunc);
 	lis3l02dq_free_buf(indio_dev->ring);
 }
@@ -459,7 +421,7 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 	int ret;
 	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev);
 	struct iio_ring_buffer *ring;
-	INIT_WORK(&h->work_trigger_to_ring, lis3l02dq_trigger_bh_to_ring);
+
 	h->get_ring_element = &lis3l02dq_get_ring_element;
 
 	ring = lis3l02dq_alloc_buf(indio_dev);
@@ -482,9 +444,20 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 	iio_scan_mask_set(ring, 1);
 	iio_scan_mask_set(ring, 2);
 
-	ret = iio_alloc_pollfunc(indio_dev, NULL, &lis3l02dq_poll_func_th);
-	if (ret)
+	/* Functions are NULL as we set handler below */
+	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
 		goto error_iio_sw_rb_free;
+	}
+	indio_dev->pollfunc->private_data = indio_dev;
+	indio_dev->pollfunc->thread = &lis3l02dq_trigger_handler;
+	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
+	indio_dev->pollfunc->type = 0;
+	indio_dev->pollfunc->name
+		= kasprintf(GFP_KERNEL, "lis3l02dq_consumer%d", indio_dev->id);
+
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
 
-- 
1.7.3.4
