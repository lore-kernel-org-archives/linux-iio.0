Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: barry.song@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 5/5]  staging:iio:adis16209 use iio_sw_ring_helper_state and funcs
Date: Wed, 30 Jun 2010 15:27:56 +0100
Message-Id: <1277908076-28592-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1277908076-28592-1-git-send-email-jic23@cam.ac.uk>
References: <1277908076-28592-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

 Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16209.h         |    7 ++-
 drivers/staging/iio/accel/adis16209_core.c    |   54 +++++++++++---------
 drivers/staging/iio/accel/adis16209_ring.c    |   66 ++++++-------------------
 drivers/staging/iio/accel/adis16209_trigger.c |    8 ++-
 4 files changed, 53 insertions(+), 82 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.h b/drivers/staging/iio/accel/adis16209.h
index 92daf6f..84e1a2f 100644
--- a/drivers/staging/iio/accel/adis16209.h
+++ b/drivers/staging/iio/accel/adis16209.h
@@ -113,16 +113,17 @@
  * @buf_lock:		mutex to protect tx and rx
  **/
 struct adis16209_state {
+	struct iio_sw_ring_helper_state help;
 	struct spi_device		*us;
-	struct work_struct		work_trigger_to_ring;
-	s64				last_timestamp;
-	struct iio_dev			*indio_dev;
 	struct iio_trigger		*trig;
 	u8				*tx;
 	u8				*rx;
 	struct mutex			buf_lock;
 };
 
+#define adis16209_h_to_s(_h)				\
+	container_of(_h, struct adis16209_state, help)
+
 int adis16209_set_irq(struct device *dev, bool enable);
 
 #ifdef CONFIG_IIO_RING_BUFFER
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 6c6923f..9c7aafe 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -21,6 +21,7 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_generic.h"
+#include "../ring_sw.h"
 #include "accel.h"
 #include "inclinometer.h"
 #include "../gyro/gyro.h"
@@ -44,7 +45,8 @@ static int adis16209_spi_write_reg_8(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev);
+	struct adis16209_state *st = adis16209_h_to_s(h);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADIS16209_WRITE_REG(reg_address);
@@ -70,7 +72,8 @@ static int adis16209_spi_write_reg_16(struct device *dev,
 	int ret;
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev);
+	struct adis16209_state *st = adis16209_h_to_s(h);
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = st->tx,
@@ -115,7 +118,8 @@ static int adis16209_spi_read_reg_16(struct device *dev,
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev);
+	struct adis16209_state *st = adis16209_h_to_s(h);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -355,7 +359,7 @@ err_ret:
 static int adis16209_initial_setup(struct adis16209_state *st)
 {
 	int ret;
-	struct device *dev = &st->indio_dev->dev;
+	struct device *dev = &st->help.indio_dev->dev;
 
 	/* Disable IRQ */
 	ret = adis16209_set_irq(dev, false);
@@ -498,30 +502,30 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
-	if (st->indio_dev == NULL) {
+	st->help.indio_dev = iio_allocate_device();
+	if (st->help.indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
 	}
 
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->num_interrupt_lines = 1;
-	st->indio_dev->event_attrs = &adis16209_event_attribute_group;
-	st->indio_dev->attrs = &adis16209_attribute_group;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	st->help.indio_dev->dev.parent = &spi->dev;
+	st->help.indio_dev->num_interrupt_lines = 1;
+	st->help.indio_dev->event_attrs = &adis16209_event_attribute_group;
+	st->help.indio_dev->attrs = &adis16209_attribute_group;
+	st->help.indio_dev->dev_data = (void *)(&st->help);
+	st->help.indio_dev->driver_module = THIS_MODULE;
+	st->help.indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = adis16209_configure_ring(st->indio_dev);
+	ret = adis16209_configure_ring(st->help.indio_dev);
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(st->help.indio_dev);
 	if (ret)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
+	ret = iio_ring_buffer_register(st->help.indio_dev->ring, 0);
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -529,14 +533,14 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 
 	if (spi->irq) {
 		ret = iio_register_interrupt_line(spi->irq,
-				st->indio_dev,
+				st->help.indio_dev,
 				0,
 				IRQF_TRIGGER_RISING,
 				"adis16209");
 		if (ret)
 			goto error_uninitialize_ring;
 
-		ret = adis16209_probe_trigger(st->indio_dev);
+		ret = adis16209_probe_trigger(st->help.indio_dev);
 		if (ret)
 			goto error_unregister_line;
 	}
@@ -548,19 +552,19 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 	return 0;
 
 error_remove_trigger:
-	adis16209_remove_trigger(st->indio_dev);
+	adis16209_remove_trigger(st->help.indio_dev);
 error_unregister_line:
 	if (spi->irq)
-		iio_unregister_interrupt_line(st->indio_dev, 0);
+		iio_unregister_interrupt_line(st->help.indio_dev, 0);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(st->indio_dev->ring);
+	iio_ring_buffer_unregister(st->help.indio_dev->ring);
 error_unreg_ring_funcs:
-	adis16209_unconfigure_ring(st->indio_dev);
+	adis16209_unconfigure_ring(st->help.indio_dev);
 error_free_dev:
 	if (regdone)
-		iio_device_unregister(st->indio_dev);
+		iio_device_unregister(st->help.indio_dev);
 	else
-		iio_free_device(st->indio_dev);
+		iio_free_device(st->help.indio_dev);
 error_free_tx:
 	kfree(st->tx);
 error_free_rx:
@@ -574,7 +578,7 @@ error_ret:
 static int adis16209_remove(struct spi_device *spi)
 {
 	struct adis16209_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = st->help.indio_dev;
 
 	flush_scheduled_work();
 
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 25fde65..34f8258 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -55,17 +55,6 @@ static struct attribute_group adis16209_scan_el_group = {
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
@@ -107,44 +96,19 @@ static int adis16209_read_ring_data(struct device *dev, u8 *rx)
 	return ret;
 }
 
-/* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
- * specific to be rolled into the core.
- */
-static void adis16209_trigger_bh_to_ring(struct work_struct *work_s)
+static int adis16209_get_ring_element(struct iio_sw_ring_helper_state *h,
+				u8 *buf)
 {
-	struct adis16209_state *st
-		= container_of(work_s, struct adis16209_state,
-			       work_trigger_to_ring);
-
-	int i = 0;
-	s16 *data;
-	size_t datasize = st->indio_dev
-		->ring->access.get_bpd(st->indio_dev->ring);
-
-	data = kmalloc(datasize , GFP_KERNEL);
-	if (data == NULL) {
-		dev_err(&st->us->dev, "memory alloc failed in ring bh");
-		return;
-	}
-
-	if (st->indio_dev->scan_count)
-		if (adis16209_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < st->indio_dev->scan_count; i++)
-				data[i] = be16_to_cpup(
-					(__be16 *)&(st->rx[i*2]));
-
-	/* Guaranteed to be aligned with 8 byte boundary */
-	if (st->indio_dev->scan_timestamp)
-		*((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
-
-	st->indio_dev->ring->access.store_to(st->indio_dev->ring,
-					    (u8 *)data,
-					    st->last_timestamp);
-
-	iio_trigger_notify_done(st->indio_dev->trig);
-	kfree(data);
+	int i;
+	s16 *data = (s16 *)buf;
 
-	return;
+	struct adis16209_state *st = adis16209_h_to_s(h);
+	int ret = adis16209_read_ring_data(&h->indio_dev->dev, st->rx);
+	if (ret < 0)
+		return ret;
+	for (i = 0; i < h->indio_dev->scan_count; i++)
+		data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
+	return 0;
 }
 
 void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
@@ -156,11 +120,11 @@ void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
 int adis16209_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
-	struct adis16209_state *st = indio_dev->dev_data;
 	struct iio_ring_buffer *ring;
-	INIT_WORK(&st->work_trigger_to_ring, adis16209_trigger_bh_to_ring);
+	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev);
+	INIT_WORK(&h->work_trigger_to_ring, iio_sw_trigger_bh_to_ring);
 	/* Set default scan mode */
-
+	h->get_ring_element = &adis16209_get_ring_element;
 	iio_scan_mask_set(indio_dev, iio_scan_el_supply.number);
 	iio_scan_mask_set(indio_dev, iio_scan_el_rot.number);
 	iio_scan_mask_set(indio_dev, iio_scan_el_accel_x.number);
@@ -187,7 +151,7 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 	ring->predisable = &iio_triggered_ring_predisable;
 	ring->owner = THIS_MODULE;
 
-	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16209_poll_func_th);
+	ret = iio_alloc_pollfunc(indio_dev, NULL, &iio_sw_poll_func_th);
 	if (ret)
 		goto error_iio_sw_rb_free;
 
diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/staging/iio/accel/adis16209_trigger.c
index 1487eff..51cdf4a 100644
--- a/drivers/staging/iio/accel/adis16209_trigger.c
+++ b/drivers/staging/iio/accel/adis16209_trigger.c
@@ -10,6 +10,7 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../trigger.h"
+#include "../ring_sw.h"
 #include "adis16209.h"
 
 /**
@@ -48,11 +49,11 @@ static int adis16209_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
 	struct adis16209_state *st = trig->private_data;
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = st->help.indio_dev;
 	int ret = 0;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	ret = adis16209_set_irq(&st->indio_dev->dev, state);
+	ret = adis16209_set_irq(&indio_dev->dev, state);
 	if (state == false) {
 		iio_remove_event_from_list(&iio_event_data_rdy_trig,
 					   &indio_dev->interrupts[0]
@@ -79,7 +80,8 @@ static int adis16209_trig_try_reen(struct iio_trigger *trig)
 int adis16209_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct adis16209_state *st = indio_dev->dev_data;
+	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev);
+	struct adis16209_state *st = adis16209_h_to_s(h);
 
 	st->trig = iio_allocate_trigger();
 	st->trig->name = kasprintf(GFP_KERNEL,
-- 
1.7.0.4
