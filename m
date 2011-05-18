Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 046/111] staging:iio:accel:adis16240 move to irqchip based trigger handling.
Date: Wed, 18 May 2011 14:41:36 +0100
Message-Id: <1305726161-5606-47-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Untested.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16240.h         |    5 --
 drivers/staging/iio/accel/adis16240_ring.c    |   66 ++++++++++++-------------
 drivers/staging/iio/accel/adis16240_trigger.c |   37 +++++---------
 3 files changed, 43 insertions(+), 65 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240.h b/drivers/staging/iio/accel/adis16240.h
index 76a4579..364aabf 100644
--- a/drivers/staging/iio/accel/adis16240.h
+++ b/drivers/staging/iio/accel/adis16240.h
@@ -126,9 +126,6 @@
 /**
  * struct adis16240_state - device instance specific data
  * @us:			actual spi_device
- * @work_trigger_to_ring: bh for triggered event handling
- * @inter:		used to check if new interrupt has been triggered
- * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
  * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
@@ -137,8 +134,6 @@
  **/
 struct adis16240_state {
 	struct spi_device		*us;
-	struct work_struct		work_trigger_to_ring;
-	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
 	struct iio_trigger		*trig;
 	u8				*tx;
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index f882e9c..a6d27d21 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -60,17 +60,6 @@ static struct attribute_group adis16240_scan_el_group = {
 };
 
 /**
- * adis16240_poll_func_th() top half interrupt handler called by trigger
- * @private_data:	iio_dev
- **/
-static void adis16240_poll_func_th(struct iio_dev *indio_dev, s64 time)
-{
-	struct adis16240_state *st = iio_dev_get_devdata(indio_dev);
-	st->last_timestamp = time;
-	schedule_work(&st->work_trigger_to_ring);
-}
-
-/**
  * adis16240_read_ring_data() read data registers which will be placed into ring
  * @dev: device associated with child of actual device (iio_dev or iio_trig)
  * @rx: somewhere to pass back the value read
@@ -112,46 +101,43 @@ static int adis16240_read_ring_data(struct device *dev, u8 *rx)
 	return ret;
 }
 
-
-static void adis16240_trigger_bh_to_ring(struct work_struct *work_s)
+static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 {
-	struct adis16240_state *st
-		= container_of(work_s, struct adis16240_state,
-				work_trigger_to_ring);
-	struct iio_ring_buffer *ring = st->indio_dev->ring;
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->private_data;
+	struct adis16240_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_ring_buffer *ring = indio_dev->ring;
 
 	int i = 0;
 	s16 *data;
 	size_t datasize = ring->access.get_bytes_per_datum(ring);
 
-	data = kmalloc(datasize , GFP_KERNEL);
+	data = kmalloc(datasize, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
-		return;
+		return -ENOMEM;
 	}
 
-	if (ring->scan_count)
-		if (adis16240_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < ring->scan_count; i++)
-				data[i] = be16_to_cpup(
-					(__be16 *)&(st->rx[i*2]));
+	if (ring->scan_count &&
+	    adis16240_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
+		for (; i < ring->scan_count; i++)
+			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
-		*((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
+		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access.store_to(ring,
-			(u8 *)data,
-			st->last_timestamp);
+	ring->access.store_to(ring, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(st->indio_dev->trig);
 	kfree(data);
 
-	return;
+	return IRQ_HANDLED;
 }
 
 void adis16240_unconfigure_ring(struct iio_dev *indio_dev)
 {
+	kfree(indio_dev->pollfunc->name);
 	kfree(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
@@ -159,9 +145,7 @@ void adis16240_unconfigure_ring(struct iio_dev *indio_dev)
 int adis16240_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
-	struct adis16240_state *st = indio_dev->dev_data;
 	struct iio_ring_buffer *ring;
-	INIT_WORK(&st->work_trigger_to_ring, adis16240_trigger_bh_to_ring);
 
 	ring = iio_sw_rb_allocate(indio_dev);
 	if (!ring) {
@@ -187,13 +171,25 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
 	iio_scan_mask_set(ring, iio_scan_el_temp.number);
 	iio_scan_mask_set(ring, iio_scan_el_in0.number);
 
-	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16240_poll_func_th);
-	if (ret)
+	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
 		goto error_iio_sw_rb_free;
-
+	}
+	indio_dev->pollfunc->private_data = indio_dev;
+	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
+	indio_dev->pollfunc->thread = &adis16240_trigger_handler;
+	indio_dev->pollfunc->type = IRQF_ONESHOT;
+	indio_dev->pollfunc->name =
+		kasprintf(GFP_KERNEL, "adis16240_consumer%d", indio_dev->id);
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
diff --git a/drivers/staging/iio/accel/adis16240_trigger.c b/drivers/staging/iio/accel/adis16240_trigger.c
index 3976c85..55e2145 100644
--- a/drivers/staging/iio/accel/adis16240_trigger.c
+++ b/drivers/staging/iio/accel/adis16240_trigger.c
@@ -17,7 +17,6 @@
  **/
 static irqreturn_t adis16240_data_rdy_trig_poll(int irq, void *trig)
 {
-	disable_irq_nosync(irq);
 	iio_trigger_poll(trig, iio_get_time_ns());
 	return IRQ_HANDLED;
 }
@@ -46,27 +45,23 @@ static int adis16240_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	return adis16240_set_irq(&st->indio_dev->dev, state);
 }
 
-/**
- * adis16240_trig_try_reen() try renabling irq for data rdy trigger
- * @trig:	the datardy trigger
- **/
-static int adis16240_trig_try_reen(struct iio_trigger *trig)
-{
-	struct adis16240_state *st = trig->private_data;
-	enable_irq(st->us->irq);
-	return 0;
-}
-
 int adis16240_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
 	struct adis16240_state *st = indio_dev->dev_data;
+	char *name;
 
-	st->trig = iio_allocate_trigger();
-	if (st->trig == NULL) {
+	name = kasprintf(GFP_KERNEL, "adis16240-dev%d", indio_dev->id);
+	if (name == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
+	st->trig = iio_allocate_trigger_named(name);
+	if (st->trig == NULL) {
+		ret = -ENOMEM;
+		goto error_free_name;
+	}
+
 	ret = request_irq(st->us->irq,
 			  adis16240_data_rdy_trig_poll,
 			  IRQF_TRIGGER_RISING,
@@ -75,34 +70,26 @@ int adis16240_probe_trigger(struct iio_dev *indio_dev)
 	if (ret)
 		goto error_free_trig;
 
-	st->trig->name = kasprintf(GFP_KERNEL,
-				   "adis16240-dev%d",
-				   indio_dev->id);
-	if (!st->trig->name) {
-		ret = -ENOMEM;
-		goto error_free_irq;
-	}
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
 	st->trig->set_trigger_state = &adis16240_data_rdy_trigger_set_state;
-	st->trig->try_reenable = &adis16240_trig_try_reen;
 	st->trig->control_attrs = &adis16240_trigger_attr_group;
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
