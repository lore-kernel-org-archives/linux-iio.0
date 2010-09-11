Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com,
	Robin.Getz@analog.com,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/6] staging:iio:adis16350 move datardy trigger to straight interrupt.
Date: Sat, 11 Sep 2010 15:58:16 +0100
Message-Id: <1284217100-2469-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284217100-2469-1-git-send-email-jic23@cam.ac.uk>
References: <1284217100-2469-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The use of the interface for the trigger was lifted from the
lis3l02dq.  There it is needed because the same physical line
is used for data ready and event interrupts.  Her it isn't
so we can simplify things.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16350_core.c    |   27 ++----------------
 drivers/staging/iio/imu/adis16350_trigger.c |   40 +++++++++++----------------
 2 files changed, 19 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index d8181f9..e500a5c 100644
--- a/drivers/staging/iio/imu/adis16350_core.c
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -583,14 +583,6 @@ static const struct attribute_group adis16350_attribute_group = {
 	.attrs = adis16350_attributes,
 };
 
-static struct attribute *adis16350_event_attributes[] = {
-	NULL,
-};
-
-static struct attribute_group adis16350_event_attribute_group = {
-	.attrs = adis16350_event_attributes,
-};
-
 static int __devinit adis16350_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -624,8 +616,6 @@ static int __devinit adis16350_probe(struct spi_device *spi)
 	}
 
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->num_interrupt_lines = 1;
-	st->indio_dev->event_attrs = &adis16350_event_attribute_group;
 	st->indio_dev->attrs = &adis16350_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
@@ -647,17 +637,9 @@ static int __devinit adis16350_probe(struct spi_device *spi)
 	}
 
 	if (spi->irq) {
-		ret = iio_register_interrupt_line(spi->irq,
-				st->indio_dev,
-				0,
-				IRQF_TRIGGER_RISING,
-				"adis16350");
-		if (ret)
-			goto error_uninitialize_ring;
-
 		ret = adis16350_probe_trigger(st->indio_dev);
 		if (ret)
-			goto error_unregister_line;
+			goto error_uninitialize_ring;
 	}
 
 	/* Get the device into a sane initial state */
@@ -667,10 +649,8 @@ static int __devinit adis16350_probe(struct spi_device *spi)
 	return 0;
 
 error_remove_trigger:
-	adis16350_remove_trigger(st->indio_dev);
-error_unregister_line:
 	if (spi->irq)
-		iio_unregister_interrupt_line(st->indio_dev, 0);
+		adis16350_remove_trigger(st->indio_dev);
 error_uninitialize_ring:
 	iio_ring_buffer_unregister(st->indio_dev->ring);
 error_unreg_ring_funcs:
@@ -702,9 +682,8 @@ static int adis16350_remove(struct spi_device *spi)
 
 	flush_scheduled_work();
 
-	adis16350_remove_trigger(indio_dev);
 	if (spi->irq)
-		iio_unregister_interrupt_line(indio_dev, 0);
+		adis16350_remove_trigger(indio_dev);
 
 	iio_ring_buffer_unregister(indio_dev->ring);
 	iio_device_unregister(indio_dev);
diff --git a/drivers/staging/iio/imu/adis16350_trigger.c b/drivers/staging/iio/imu/adis16350_trigger.c
index 739b7ec..593c98f 100644
--- a/drivers/staging/iio/imu/adis16350_trigger.c
+++ b/drivers/staging/iio/imu/adis16350_trigger.c
@@ -13,23 +13,15 @@
 #include "adis16350.h"
 
 /**
- * adis16350_data_rdy_trig_poll() the event handler for the data rdy trig
+ * adis16350_data_rdy_trig_poll() the interrupt th for the data rdy trig
  **/
-static int adis16350_data_rdy_trig_poll(struct iio_dev *dev_info,
-				       int index,
-				       s64 timestamp,
-				       int no_test)
+static irqreturn_t adis16350_data_rdy_trig_poll(int irq, void *private)
 {
-	struct adis16350_state *st = iio_dev_get_devdata(dev_info);
-	struct iio_trigger *trig = st->trig;
-
-	iio_trigger_poll(trig, timestamp);
-
+	disable_irq_nosync(irq);
+	iio_trigger_poll(private, iio_get_time_ns());
 	return IRQ_HANDLED;
 }
 
-IIO_EVENT_SH(data_rdy_trig, &adis16350_data_rdy_trig_poll);
-
 static IIO_TRIGGER_NAME_ATTR;
 
 static struct attribute *adis16350_trigger_attrs[] = {
@@ -53,17 +45,9 @@ static int adis16350_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
 	ret = adis16350_set_irq(&st->indio_dev->dev, state);
-	if (state == false) {
-		iio_remove_event_from_list(&iio_event_data_rdy_trig,
-					   &indio_dev->interrupts[0]
-					   ->ev_list);
-		/* possible quirk with handler currently worked around
-		   by ensuring the work queue is empty */
+	if (state == false)
 		flush_scheduled_work();
-	} else {
-		iio_add_event_to_list(&iio_event_data_rdy_trig,
-				      &indio_dev->interrupts[0]->ev_list);
-	}
+
 	return ret;
 }
 
@@ -82,7 +66,7 @@ static int adis16350_trig_try_reen(struct iio_trigger *trig)
 int adis16350_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct adis16350_state *st = indio_dev->dev_data;
+	struct adis16350_state *st = iio_dev_get_devdata(indio_dev);
 
 	st->trig = iio_allocate_trigger();
 	st->trig->name = kasprintf(GFP_KERNEL,
@@ -105,8 +89,15 @@ int adis16350_probe_trigger(struct iio_dev *indio_dev)
 	if (ret)
 		goto error_free_trig_name;
 
+	ret = request_irq(st->us->irq, adis16350_data_rdy_trig_poll,
+			IRQF_TRIGGER_RISING, st->trig->name, st->trig);
+	if (ret)
+		goto error_trigger_unregister;
+
 	return 0;
 
+error_trigger_unregister:
+	iio_trigger_unregister(st->trig);
 error_free_trig_name:
 	kfree(st->trig->name);
 error_free_trig:
@@ -117,8 +108,9 @@ error_free_trig:
 
 void adis16350_remove_trigger(struct iio_dev *indio_dev)
 {
-	struct adis16350_state *state = indio_dev->dev_data;
+	struct adis16350_state *state = iio_dev_get_devdata(indio_dev);
 
+	free_irq(state->us->irq, state->trig);
 	iio_trigger_unregister(state->trig);
 	kfree(state->trig->name);
 	iio_free_trigger(state->trig);
-- 
1.7.2.2
