Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:53989 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933208Ab1ERNkF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2011 09:40:05 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 045/111] staging:iio:accel:adis16209 move to irqchip based trigger handling.
Date: Wed, 18 May 2011 14:41:35 +0100
Message-Id: <1305726161-5606-46-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Untested.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16209.h         |    4 --
 drivers/staging/iio/accel/adis16209_ring.c    |   62 ++++++++++++-------------
 drivers/staging/iio/accel/adis16209_trigger.c |   40 ++++++----------
 3 files changed, 45 insertions(+), 61 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.h b/drivers/staging/iio/accel/adis16209.h
index 8b0da13..9ef596f 100644
--- a/drivers/staging/iio/accel/adis16209.h
+++ b/drivers/staging/iio/accel/adis16209.h
@@ -104,8 +104,6 @@
 /**
  * struct adis16209_state - device instance specific data
  * @us:			actual spi_device
- * @work_trigger_to_ring: bh for triggered event handling
- * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
  * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
@@ -114,8 +112,6 @@
  **/
 struct adis16209_state {
 	struct spi_device		*us;
-	struct work_struct		work_trigger_to_ring;
-	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
 	struct iio_trigger		*trig;
 	u8				*tx;
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 8eba0af..6e66469 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -72,17 +72,6 @@ static struct attribute_group adis16209_scan_el_group = {
 };
 
 /**
- * adis16209_poll_func_th() top half interrupt handler called by trigger
- * @private_data:	iio_dev
- **/
-static void adis16209_poll_func_th(struct iio_dev *indio_dev, s64 time)
-{
-	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
-	st->last_timestamp = time;
-	schedule_work(&st->work_trigger_to_ring);
-}
-
-/**
  * adis16209_read_ring_data() read data registers which will be placed into ring
  * @dev: device associated with child of actual device (iio_dev or iio_trig)
  * @rx: somewhere to pass back the value read
@@ -127,12 +116,12 @@ static int adis16209_read_ring_data(struct device *dev, u8 *rx)
 /* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
  * specific to be rolled into the core.
  */
-static void adis16209_trigger_bh_to_ring(struct work_struct *work_s)
+static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 {
-	struct adis16209_state *st
-		= container_of(work_s, struct adis16209_state,
-			       work_trigger_to_ring);
-	struct iio_ring_buffer *ring = st->indio_dev->ring;
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->private_data;
+	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_ring_buffer *ring = indio_dev->ring;
 
 	int i = 0;
 	s16 *data;
@@ -141,31 +130,29 @@ static void adis16209_trigger_bh_to_ring(struct work_struct *work_s)
 	data = kmalloc(datasize , GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
-		return;
+		return -ENOMEM;
 	}
 
-	if (ring->scan_count)
-		if (adis16209_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < ring->scan_count; i++)
-				data[i] = be16_to_cpup(
-					(__be16 *)&(st->rx[i*2]));
+	if (ring->scan_count &&
+	    adis16209_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
+		for (; i < ring->scan_count; i++)
+			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
-		*((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
+		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access.store_to(ring,
-			      (u8 *)data,
-			      st->last_timestamp);
+	ring->access.store_to(ring, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(st->indio_dev->trig);
 	kfree(data);
 
-	return;
+	return IRQ_HANDLED;
 }
 
 void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
 {
+	kfree(indio_dev->pollfunc->name);
 	kfree(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
@@ -173,9 +160,7 @@ void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
 int adis16209_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
-	struct adis16209_state *st = indio_dev->dev_data;
 	struct iio_ring_buffer *ring;
-	INIT_WORK(&st->work_trigger_to_ring, adis16209_trigger_bh_to_ring);
 
 	ring = iio_sw_rb_allocate(indio_dev);
 	if (!ring) {
@@ -203,13 +188,26 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 	iio_scan_mask_set(ring, iio_scan_el_incli_x.number);
 	iio_scan_mask_set(ring, iio_scan_el_incli_y.number);
 
-	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16209_poll_func_th);
-	if (ret)
+	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
 		goto error_iio_sw_rb_free;
+	}
+	indio_dev->pollfunc->private_data = indio_dev;
+	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
+	indio_dev->pollfunc->thread = &adis16209_trigger_handler;
+	indio_dev->pollfunc->type = IRQF_ONESHOT;
+	indio_dev->pollfunc->name =
+		kasprintf(GFP_KERNEL, "adis16209_consumer%d", indio_dev->id);
+	if (indio_dev->pollfunc->name == NULL) {
+		ret = -ENOMEM;
+		goto error_free_poll_func;
+	}
 
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
-
+error_free_poll_func:
+	kfree(indio_dev->pollfunc);
 error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/staging/iio/accel/adis16209_trigger.c
index 488e482..86e83c3 100644
--- a/drivers/staging/iio/accel/adis16209_trigger.c
+++ b/drivers/staging/iio/accel/adis16209_trigger.c
@@ -17,7 +17,6 @@
  **/
 static irqreturn_t adis16209_data_rdy_trig_poll(int irq, void *trig)
 {
-	disable_irq_nosync(irq);
 	iio_trigger_poll(trig, iio_get_time_ns());
 	return IRQ_HANDLED;
 }
@@ -46,27 +45,26 @@ static int adis16209_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	return adis16209_set_irq(&st->indio_dev->dev, state);
 }
 
-/**
- * adis16209_trig_try_reen() try renabling irq for data rdy trigger
- * @trig:	the datardy trigger
- **/
-static int adis16209_trig_try_reen(struct iio_trigger *trig)
-{
-	struct adis16209_state *st = trig->private_data;
-	enable_irq(st->us->irq);
-	return 0;
-}
-
 int adis16209_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
 	struct adis16209_state *st = indio_dev->dev_data;
+	char *name;
 
-	st->trig = iio_allocate_trigger();
-	if (st->trig == NULL) {
+	name = kasprintf(GFP_KERNEL,
+			 "adis16209-dev%d",
+			 indio_dev->id);
+	if (name == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
+
+	st->trig = iio_allocate_trigger_named(name);
+	if (st->trig == NULL) {
+		ret = -ENOMEM;
+		goto error_free_name;
+	}
+
 	ret = request_irq(st->us->irq,
 			  adis16209_data_rdy_trig_poll,
 			  IRQF_TRIGGER_RISING,
@@ -74,34 +72,26 @@ int adis16209_probe_trigger(struct iio_dev *indio_dev)
 			  st->trig);
 	if (ret)
 		goto error_free_trig;
-	st->trig->name = kasprintf(GFP_KERNEL,
-				   "adis16209-dev%d",
-				   indio_dev->id);
-	if (!st->trig->name) {
-		ret = -ENOMEM;
-		goto error_free_irq;
-	}
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
 	st->trig->set_trigger_state = &adis16209_data_rdy_trigger_set_state;
-	st->trig->try_reenable = &adis16209_trig_try_reen;
 	st->trig->control_attrs = &adis16209_trigger_attr_group;
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
 	indio_dev->trig = st->trig;
 	if (ret)
-		goto error_free_trig_name;
+		goto error_free_irq;
 
 	return 0;
 
-error_free_trig_name:
-	kfree(st->trig->name);
 error_free_irq:
 	free_irq(st->us->irq, st->trig);
 error_free_trig:
 	iio_free_trigger(st->trig);
+error_free_name:
+	kfree(name);
 error_ret:
 	return ret;
 }
-- 
1.7.3.4

