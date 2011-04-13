Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 10/12] staging:iio:adis16240 replace unnecessary event line registration.
Date: Wed, 13 Apr 2011 14:43:05 +0100
Message-Id: <1302702187-953-11-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1302702187-953-1-git-send-email-jic23@cam.ac.uk>
References: <1302702187-953-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16240_core.c    |   26 +-------------
 drivers/staging/iio/accel/adis16240_trigger.c |   46 +++++++++++-------------
 2 files changed, 22 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 31f64ae..89ab810 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -424,14 +424,6 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("4096");
 
 static IIO_CONST_ATTR_NAME("adis16240");
 
-static struct attribute *adis16240_event_attributes[] = {
-	NULL
-};
-
-static struct attribute_group adis16240_event_attribute_group = {
-	.attrs = adis16240_event_attributes,
-};
-
 static struct attribute *adis16240_attributes[] = {
 	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
 	&iio_const_attr_in0_supply_scale.dev_attr.attr,
@@ -492,8 +484,6 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 	}
 
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->num_interrupt_lines = 1;
-	st->indio_dev->event_attrs = &adis16240_event_attribute_group;
 	st->indio_dev->attrs = &adis16240_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
@@ -515,17 +505,9 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 	}
 
 	if (spi->irq) {
-		ret = iio_register_interrupt_line(spi->irq,
-				st->indio_dev,
-				0,
-				IRQF_TRIGGER_RISING,
-				"adis16240");
-		if (ret)
-			goto error_uninitialize_ring;
-
 		ret = adis16240_probe_trigger(st->indio_dev);
 		if (ret)
-			goto error_unregister_line;
+			goto error_uninitialize_ring;
 	}
 
 	/* Get the device into a sane initial state */
@@ -536,9 +518,6 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 
 error_remove_trigger:
 	adis16240_remove_trigger(st->indio_dev);
-error_unregister_line:
-	if (spi->irq)
-		iio_unregister_interrupt_line(st->indio_dev, 0);
 error_uninitialize_ring:
 	iio_ring_buffer_unregister(st->indio_dev->ring);
 error_unreg_ring_funcs:
@@ -566,9 +545,6 @@ static int adis16240_remove(struct spi_device *spi)
 	flush_scheduled_work();
 
 	adis16240_remove_trigger(indio_dev);
-	if (spi->irq)
-		iio_unregister_interrupt_line(indio_dev, 0);
-
 	iio_ring_buffer_unregister(indio_dev->ring);
 	iio_device_unregister(indio_dev);
 	adis16240_unconfigure_ring(indio_dev);
diff --git a/drivers/staging/iio/accel/adis16240_trigger.c b/drivers/staging/iio/accel/adis16240_trigger.c
index 6cb8681..c5a26ae 100644
--- a/drivers/staging/iio/accel/adis16240_trigger.c
+++ b/drivers/staging/iio/accel/adis16240_trigger.c
@@ -15,21 +15,13 @@
 /**
  * adis16240_data_rdy_trig_poll() the event handler for the data rdy trig
  **/
-static int adis16240_data_rdy_trig_poll(struct iio_dev *dev_info,
-				       int index,
-				       s64 timestamp,
-				       int no_test)
+static irqreturn_t adis16240_data_rdy_trig_poll(int irq, void *trig)
 {
-	struct adis16240_state *st = iio_dev_get_devdata(dev_info);
-	struct iio_trigger *trig = st->trig;
-
-	iio_trigger_poll(trig, timestamp);
-
+	disable_irq_nosync(irq);
+	iio_trigger_poll(trig, iio_get_time_ns());
 	return IRQ_HANDLED;
 }
 
-IIO_EVENT_SH(data_rdy_trig, &adis16240_data_rdy_trig_poll);
-
 static IIO_TRIGGER_NAME_ATTR;
 
 static struct attribute *adis16240_trigger_attrs[] = {
@@ -49,20 +41,9 @@ static int adis16240_data_rdy_trigger_set_state(struct iio_trigger *trig,
 {
 	struct adis16240_state *st = trig->private_data;
 	struct iio_dev *indio_dev = st->indio_dev;
-	int ret = 0;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	ret = adis16240_set_irq(&st->indio_dev->dev, state);
-	if (state == false) {
-		iio_remove_event_from_list(&iio_event_data_rdy_trig,
-					   &indio_dev->interrupts[0]
-					   ->ev_list);
-		flush_scheduled_work();
-	} else {
-		iio_add_event_to_list(&iio_event_data_rdy_trig,
-				      &indio_dev->interrupts[0]->ev_list);
-	}
-	return ret;
+	return adis16240_set_irq(&st->indio_dev->dev, state);
 }
 
 /**
@@ -82,12 +63,24 @@ int adis16240_probe_trigger(struct iio_dev *indio_dev)
 	struct adis16240_state *st = indio_dev->dev_data;
 
 	st->trig = iio_allocate_trigger();
+	if (st->trig == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	ret = request_irq(st->us->irq,
+			  adis16240_data_rdy_trig_poll,
+			  IRQF_TRIGGER_RISING,
+			  "adis16240",
+			  st->trig);
+	if (ret)
+		goto error_free_trig;
+		
 	st->trig->name = kasprintf(GFP_KERNEL,
 				   "adis16240-dev%d",
 				   indio_dev->id);
 	if (!st->trig->name) {
 		ret = -ENOMEM;
-		goto error_free_trig;
+		goto error_free_irq;
 	}
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
@@ -106,9 +99,11 @@ int adis16240_probe_trigger(struct iio_dev *indio_dev)
 
 error_free_trig_name:
 	kfree(st->trig->name);
+error_free_irq:
+	free_irq(st->us->irq, st->trig);
 error_free_trig:
 	iio_free_trigger(st->trig);
-
+error_ret:
 	return ret;
 }
 
@@ -118,5 +113,6 @@ void adis16240_remove_trigger(struct iio_dev *indio_dev)
 
 	iio_trigger_unregister(state->trig);
 	kfree(state->trig->name);
+	free_irq(state->us->irq, state->trig);
 	iio_free_trigger(state->trig);
 }
-- 
1.7.3.4
