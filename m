Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:57582 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202Ab1EDL4x (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2011 07:56:53 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de, Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 35/99] staging:iio:ad7476 move to irqchip based triggering
Date: Wed,  4 May 2011 12:58:07 +0100
Message-Id: <1304510351-10922-36-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Untested

V2: Fixed missing free of pollfunc->name pointed out by
Michael Hennerich.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7476.h      |    2 -
 drivers/staging/iio/adc/ad7476_core.c |    4 --
 drivers/staging/iio/adc/ad7476_ring.c |   66 +++++++++++++--------------------
 3 files changed, 26 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7476.h b/drivers/staging/iio/adc/ad7476.h
index 17febd2..01a7021 100644
--- a/drivers/staging/iio/adc/ad7476.h
+++ b/drivers/staging/iio/adc/ad7476.h
@@ -28,8 +28,6 @@ struct ad7476_state {
 	struct spi_device		*spi;
 	const struct ad7476_chip_info	*chip_info;
 	struct regulator		*reg;
-	struct work_struct		poll_work;
-	atomic_t			protect_ring;
 	size_t				d_size;
 	u16				int_vref_mv;
 	struct spi_transfer		xfer;
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 0438923..9729a1c 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -6,13 +6,10 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <linux/interrupt.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
@@ -176,7 +173,6 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, st);
 
-	atomic_set(&st->protect_ring, 0);
 	st->spi = spi;
 
 	st->indio_dev = iio_allocate_device(0);
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index 8f00d6c..ec1fa14 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -8,13 +8,10 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/spi/spi.h>
 
 #include "../iio.h"
@@ -77,46 +74,19 @@ static int ad7476_ring_preenable(struct iio_dev *indio_dev)
 	return 0;
 }
 
-/**
- * ad7476_poll_func_th() th of trigger launched polling to ring buffer
- *
- * As sampling only occurs on i2c comms occurring, leave timestamping until
- * then.  Some triggers will generate their own time stamp.  Currently
- * there is no way of notifying them when no one cares.
- **/
-static void ad7476_poll_func_th(struct iio_dev *indio_dev, s64 time)
-{
-	struct ad7476_state *st = indio_dev->dev_data;
-
-	schedule_work(&st->poll_work);
-	return;
-}
-/**
- * ad7476_poll_bh_to_ring() bh of trigger launched polling to ring buffer
- * @work_s:	the work struct through which this was scheduled
- *
- * Currently there is no option in this driver to disable the saving of
- * timestamps within the ring.
- * I think the one copy of this at a time was to avoid problems if the
- * trigger was set far too high and the reads then locked up the computer.
- **/
-static void ad7476_poll_bh_to_ring(struct work_struct *work_s)
+static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 {
-	struct ad7476_state *st = container_of(work_s, struct ad7476_state,
-						  poll_work);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->private_data;
+	struct ad7476_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_sw_ring_buffer *sw_ring = iio_to_sw_ring(indio_dev->ring);
 	s64 time_ns;
 	__u8 *rxbuf;
 	int b_sent;
 
-	/* Ensure only one copy of this function running at a time */
-	if (atomic_inc_return(&st->protect_ring) > 1)
-		return;
-
 	rxbuf = kzalloc(st->d_size, GFP_KERNEL);
 	if (rxbuf == NULL)
-		return;
+		return -ENOMEM;
 
 	b_sent = spi_read(st->spi, rxbuf,
 			  st->chip_info->channel[0].scan_type.storagebits / 8);
@@ -131,8 +101,10 @@ static void ad7476_poll_bh_to_ring(struct work_struct *work_s)
 
 	indio_dev->ring->access.store_to(&sw_ring->buf, rxbuf, time_ns);
 done:
+	iio_trigger_notify_done(indio_dev->trig);
 	kfree(rxbuf);
-	atomic_dec(&st->protect_ring);
+
+	return IRQ_HANDLED;
 }
 
 int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
@@ -147,9 +119,22 @@ int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&indio_dev->ring->access);
-	ret = iio_alloc_pollfunc(indio_dev, NULL, &ad7476_poll_func_th);
-	if (ret)
+	indio_dev->pollfunc = kzalloc(sizeof(indio_dev->pollfunc), GFP_KERNEL);
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
 		goto error_deallocate_sw_rb;
+	}
+	indio_dev->pollfunc->private_data = indio_dev;
+	indio_dev->pollfunc->thread = &ad7476_trigger_handler;
+	indio_dev->pollfunc->type = IRQF_ONESHOT;
+	indio_dev->pollfunc->name
+		= kasprintf(GFP_KERNEL, "%s_consumer%d",
+			    spi_get_device_id(st->spi)->name,
+			    indio_dev->id);
+	if (indio_dev->pollfunc->name == NULL) {
+		ret = -ENOMEM;
+		goto error_free_pollfunc;
+	}
 
 	/* Ring buffer functions - here trigger setup related */
 
@@ -158,11 +143,11 @@ int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
 	indio_dev->ring->scan_timestamp = true;
 
-	INIT_WORK(&st->poll_work, &ad7476_poll_bh_to_ring);
-
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
+error_free_pollfunc:
+	kfree(indio_dev->pollfunc);
 error_deallocate_sw_rb:
 	iio_sw_rb_free(indio_dev->ring);
 error_ret:
@@ -177,6 +162,7 @@ void ad7476_ring_cleanup(struct iio_dev *indio_dev)
 		iio_trigger_dettach_poll_func(indio_dev->trig,
 					      indio_dev->pollfunc);
 	}
+	kfree(indio_dev->pollfunc->name);
 	kfree(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
-- 
1.7.3.4

