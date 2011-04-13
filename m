Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 06/12] staging:iio:adis16260 replace unnecessary event line registration.
Date: Wed, 13 Apr 2011 14:43:01 +0100
Message-Id: <1302702187-953-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1302702187-953-1-git-send-email-jic23@cam.ac.uk>
References: <1302702187-953-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Whilst the adis16260 does indeed support events, currently the driver
does not.  The trigger code should never use that infrastructure.

Untested

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16260_core.c    |   25 +-------------
 drivers/staging/iio/gyro/adis16260_trigger.c |   46 ++++++++++++--------------
 2 files changed, 22 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 26e3af4..a50b645 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -507,14 +507,6 @@ static IIO_DEVICE_ATTR(sampling_frequency_available,
 
 static IIO_CONST_ATTR_NAME("adis16260");
 
-static struct attribute *adis16260_event_attributes[] = {
-	NULL
-};
-
-static struct attribute_group adis16260_event_attribute_group = {
-	.attrs = adis16260_event_attributes,
-};
-
 #define ADIS16260_GYRO_ATTR_SET(axis)					\
 	IIO_DEV_ATTR_GYRO##axis(adis16260_read_14bit_signed,		\
 				ADIS16260_GYRO_OUT);			\
@@ -603,8 +595,6 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	}
 
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->num_interrupt_lines = 1;
-	st->indio_dev->event_attrs = &adis16260_event_attribute_group;
 	if (pd && pd->direction)
 		switch (pd->direction) {
 		case 'x':
@@ -642,17 +632,9 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	}
 
 	if (spi->irq) {
-		ret = iio_register_interrupt_line(spi->irq,
-				st->indio_dev,
-				0,
-				IRQF_TRIGGER_RISING,
-				"adis16260");
-		if (ret)
-			goto error_uninitialize_ring;
-
 		ret = adis16260_probe_trigger(st->indio_dev);
 		if (ret)
-			goto error_unregister_line;
+			goto error_uninitialize_ring;
 	}
 
 	/* Get the device into a sane initial state */
@@ -663,9 +645,6 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 
 error_remove_trigger:
 	adis16260_remove_trigger(st->indio_dev);
-error_unregister_line:
-	if (spi->irq)
-		iio_unregister_interrupt_line(st->indio_dev, 0);
 error_uninitialize_ring:
 	iio_ring_buffer_unregister(st->indio_dev->ring);
 error_unreg_ring_funcs:
@@ -698,8 +677,6 @@ static int adis16260_remove(struct spi_device *spi)
 	flush_scheduled_work();
 
 	adis16260_remove_trigger(indio_dev);
-	if (spi->irq)
-		iio_unregister_interrupt_line(indio_dev, 0);
 
 	iio_ring_buffer_unregister(st->indio_dev->ring);
 	iio_device_unregister(indio_dev);
diff --git a/drivers/staging/iio/gyro/adis16260_trigger.c b/drivers/staging/iio/gyro/adis16260_trigger.c
index 4a744c1..5eb3038 100644
--- a/drivers/staging/iio/gyro/adis16260_trigger.c
+++ b/drivers/staging/iio/gyro/adis16260_trigger.c
@@ -15,21 +15,13 @@
 /**
  * adis16260_data_rdy_trig_poll() the event handler for the data rdy trig
  **/
-static int adis16260_data_rdy_trig_poll(struct iio_dev *dev_info,
-				       int index,
-				       s64 timestamp,
-				       int no_test)
+static irqreturn_t adis16260_data_rdy_trig_poll(int irq, void *private)
 {
-	struct adis16260_state *st = iio_dev_get_devdata(dev_info);
-	struct iio_trigger *trig = st->trig;
-
-	iio_trigger_poll(trig, timestamp);
-
+	disable_irq_nosync(irq);
+	iio_trigger_poll(private, iio_get_time_ns());
 	return IRQ_HANDLED;
 }
 
-IIO_EVENT_SH(data_rdy_trig, &adis16260_data_rdy_trig_poll);
-
 static IIO_TRIGGER_NAME_ATTR;
 
 static struct attribute *adis16260_trigger_attrs[] = {
@@ -49,20 +41,9 @@ static int adis16260_data_rdy_trigger_set_state(struct iio_trigger *trig,
 {
 	struct adis16260_state *st = trig->private_data;
 	struct iio_dev *indio_dev = st->indio_dev;
-	int ret = 0;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	ret = adis16260_set_irq(&st->indio_dev->dev, state);
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
+	return adis16260_set_irq(&st->indio_dev->dev, state);
 }
 
 /**
@@ -82,12 +63,24 @@ int adis16260_probe_trigger(struct iio_dev *indio_dev)
 	struct adis16260_state *st = indio_dev->dev_data;
 
 	st->trig = iio_allocate_trigger();
+	if (st->trig == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	ret = request_irq(st->us->irq,
+			  adis16260_data_rdy_trig_poll,
+			  IRQF_TRIGGER_RISING,
+			  "adis16260",
+			  st->trig);
+	if (ret)
+		goto error_free_trig;
+
 	st->trig->name = kasprintf(GFP_KERNEL,
 				   "adis16260-dev%d",
 				   indio_dev->id);
 	if (!st->trig->name) {
 		ret = -ENOMEM;
-		goto error_free_trig;
+		goto error_free_irq;
 	}
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
@@ -106,9 +99,11 @@ int adis16260_probe_trigger(struct iio_dev *indio_dev)
 
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
 
@@ -118,5 +113,6 @@ void adis16260_remove_trigger(struct iio_dev *indio_dev)
 
 	iio_trigger_unregister(state->trig);
 	kfree(state->trig->name);
+	free_irq(state->us->irq, state->trig);
 	iio_free_trigger(state->trig);
 }
-- 
1.7.3.4
