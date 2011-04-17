Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 44/70] staging:iio:accel:adis16204 move to irqchip based trigger handling.
Date: Sun, 17 Apr 2011 20:06:17 +0100
Message-Id: <1303067203-4894-45-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Untested.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16204.h         |    5 --
 drivers/staging/iio/accel/adis16204_ring.c    |   55 ++++++++++++-------------
 drivers/staging/iio/accel/adis16204_trigger.c |   53 ++++++++----------------
 3 files changed, 44 insertions(+), 69 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16204.h b/drivers/staging/iio/accel/adis16204.h
index e618446..bdd20c6 100644
--- a/drivers/staging/iio/accel/adis16204.h
+++ b/drivers/staging/iio/accel/adis16204.h
@@ -67,9 +67,6 @@
 /**
  * struct adis16204_state - device instance specific data
  * @us:			actual spi_device
- * @work_trigger_to_ring: bh for triggered event handling
- * @inter:		used to check if new interrupt has been triggered
- * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
  * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
@@ -78,8 +75,6 @@
  **/
 struct adis16204_state {
 	struct spi_device		*us;
-	struct work_struct		work_trigger_to_ring;
-	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
 	struct iio_trigger		*trig;
 	u8				*tx;
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 420b160..dfc09c3 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -56,17 +56,6 @@ static struct attribute_group adis16204_scan_el_group = {
 };
 
 /**
- * adis16204_poll_func_th() top half interrupt handler called by trigger
- * @private_data:	iio_dev
- **/
-static void adis16204_poll_func_th(struct iio_dev *indio_dev, s64 timestamp)
-{
-	struct adis16204_state *st = iio_dev_get_devdata(indio_dev);
-	st->last_timestamp = timestamp;
-	schedule_work(&st->work_trigger_to_ring);
-}
-
-/**
  * adis16204_read_ring_data() read data registers which will be placed into ring
  * @dev: device associated with child of actual device (iio_dev or iio_trig)
  * @rx: somewhere to pass back the value read
@@ -110,13 +99,12 @@ static int adis16204_read_ring_data(struct device *dev, u8 *rx)
 /* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
  * specific to be rolled into the core.
  */
-static void adis16204_trigger_bh_to_ring(struct work_struct *work_s)
+static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 {
-	struct adis16204_state *st
-		= container_of(work_s, struct adis16204_state,
-			       work_trigger_to_ring);
-	struct iio_ring_buffer *ring = st->indio_dev->ring;
-
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->private_data;
+	struct adis16204_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_ring_buffer *ring = indio_dev->ring;
 	int i = 0;
 	s16 *data;
 	size_t datasize = ring->access.get_bytes_per_datum(ring);
@@ -124,7 +112,7 @@ static void adis16204_trigger_bh_to_ring(struct work_struct *work_s)
 	data = kmalloc(datasize, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
-		return;
+		return -ENOMEM;
 	}
 
 	if (ring->scan_count)
@@ -135,20 +123,19 @@ static void adis16204_trigger_bh_to_ring(struct work_struct *work_s)
 
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
 
 void adis16204_unconfigure_ring(struct iio_dev *indio_dev)
 {
+	kfree(indio_dev->pollfunc->name);
 	kfree(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
@@ -156,9 +143,7 @@ void adis16204_unconfigure_ring(struct iio_dev *indio_dev)
 int adis16204_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
-	struct adis16204_state *st = indio_dev->dev_data;
 	struct iio_ring_buffer *ring;
-	INIT_WORK(&st->work_trigger_to_ring, adis16204_trigger_bh_to_ring);
 
 	ring = iio_sw_rb_allocate(indio_dev);
 	if (!ring) {
@@ -183,13 +168,27 @@ int adis16204_configure_ring(struct iio_dev *indio_dev)
 	iio_scan_mask_set(ring, iio_scan_el_temp.number);
 	iio_scan_mask_set(ring, iio_scan_el_in0.number);
 
-	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16204_poll_func_th);
-	if (ret)
-		goto error_iio_sw_rb_free;
+	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
+ 		goto error_iio_sw_rb_free;
+	}
+	indio_dev->pollfunc->private_data = indio_dev;
+	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
+	indio_dev->pollfunc->thread = &adis16204_trigger_handler;
+	indio_dev->pollfunc->type = IRQF_ONESHOT;
+	indio_dev->pollfunc->name =
+		kasprintf(GFP_KERNEL, "adis16204_consumer%d", indio_dev->id);
+	if (indio_dev->pollfunc->name == NULL) {
+		ret = -ENOMEM;
+		goto error_free_poll_func;
+	}
 
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
 
+error_free_poll_func:
+	kfree(indio_dev->pollfunc);
 error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
diff --git a/drivers/staging/iio/accel/adis16204_trigger.c b/drivers/staging/iio/accel/adis16204_trigger.c
index c1dcb94..ef9b84f 100644
--- a/drivers/staging/iio/accel/adis16204_trigger.c
+++ b/drivers/staging/iio/accel/adis16204_trigger.c
@@ -12,16 +12,6 @@
 #include "../trigger.h"
 #include "adis16204.h"
 
-/**
- * adis16204_data_rdy_trig_poll() the event handler for the data rdy trig
- **/
-static irqreturn_t adis16204_data_rdy_trig_poll(int irq, void *private)
-{
-	disable_irq_nosync(irq);
-	iio_trigger_poll(private, iio_get_time_ns());
-	return IRQ_HANDLED;
-}
-
 static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
 
 static struct attribute *adis16204_trigger_attrs[] = {
@@ -46,63 +36,54 @@ static int adis16204_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	return adis16204_set_irq(&st->indio_dev->dev, state);
 }
 
-/**
- * adis16204_trig_try_reen() try renabling irq for data rdy trigger
- * @trig:	the datardy trigger
- **/
-static int adis16204_trig_try_reen(struct iio_trigger *trig)
-{
-	struct adis16204_state *st = trig->private_data;
-	enable_irq(st->us->irq);
-	return 0;
-}
-
 int adis16204_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
 	struct adis16204_state *st = indio_dev->dev_data;
+	char *name;
 
-	st->trig = iio_allocate_trigger();
-	if (st->trig == NULL) {
+	name = kasprintf(GFP_KERNEL,
+			 "adis16204-dev%d",
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
-			  adis16204_data_rdy_trig_poll,
+			  &iio_trigger_generic_data_rdy_poll,
 			  IRQF_TRIGGER_RISING,
 			  "adis16204",
 			  st->trig);
 	if (ret)
 		goto error_free_trig;
-	
-	st->trig->name = kasprintf(GFP_KERNEL,
-				"adis16204-dev%d",
-				indio_dev->id);
-	if (!st->trig->name) {
-		ret = -ENOMEM;
-		goto error_free_irq;
-	}
+
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
 	st->trig->set_trigger_state = &adis16204_data_rdy_trigger_set_state;
-	st->trig->try_reenable = &adis16204_trig_try_reen;
 	st->trig->control_attrs = &adis16204_trigger_attr_group;
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
