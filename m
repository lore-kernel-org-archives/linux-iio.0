Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 12/12] staging:iio:ade7758 replace unnecessary event line registration.
Date: Wed, 13 Apr 2011 14:43:07 +0100
Message-Id: <1302702187-953-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1302702187-953-1-git-send-email-jic23@cam.ac.uk>
References: <1302702187-953-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This was only used for triggering and hence should never have been
done this way in the first place.  Needs to go prior to cleaning
out some of the registration functions.

Untested

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/meter/ade7758_core.c    |   30 ++---------------
 drivers/staging/iio/meter/ade7758_trigger.c |   48 ++++++++++++---------------
 2 files changed, 24 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 8d37ef7..cab31dd 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -23,7 +23,7 @@
 #include "meter.h"
 #include "ade7758.h"
 
-int ade7758_spi_write_reg_8(struct device *dev,
+static int ade7758_spi_write_reg_8(struct device *dev,
 		u8 reg_address,
 		u8 val)
 {
@@ -292,7 +292,7 @@ error_ret:
 	return ret ? ret : len;
 }
 
-int ade7758_reset(struct device *dev)
+static int ade7758_reset(struct device *dev)
 {
 	int ret;
 	u8 val;
@@ -652,14 +652,6 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("26000 13000 65000 33000");
 
 static IIO_CONST_ATTR(name, "ade7758");
 
-static struct attribute *ade7758_event_attributes[] = {
-	NULL
-};
-
-static struct attribute_group ade7758_event_attribute_group = {
-	.attrs = ade7758_event_attributes,
-};
-
 static struct attribute *ade7758_attributes[] = {
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
@@ -744,8 +736,6 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 	}
 
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->num_interrupt_lines = 1;
-	st->indio_dev->event_attrs = &ade7758_event_attribute_group;
 	st->indio_dev->attrs = &ade7758_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
@@ -767,17 +757,9 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 	}
 
 	if (spi->irq) {
-		ret = iio_register_interrupt_line(spi->irq,
-				st->indio_dev,
-				0,
-				IRQF_TRIGGER_FALLING,
-				"ade7758");
-		if (ret)
-			goto error_uninitialize_ring;
-
 		ret = ade7758_probe_trigger(st->indio_dev);
 		if (ret)
-			goto error_unregister_line;
+			goto error_uninitialize_ring;
 	}
 
 	/* Get the device into a sane initial state */
@@ -789,9 +771,6 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 error_remove_trigger:
 	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
 		ade7758_remove_trigger(st->indio_dev);
-error_unregister_line:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		iio_unregister_interrupt_line(st->indio_dev, 0);
 error_uninitialize_ring:
 	ade7758_uninitialize_ring(st->indio_dev->ring);
 error_unreg_ring_funcs:
@@ -824,9 +803,6 @@ static int ade7758_remove(struct spi_device *spi)
 	flush_scheduled_work();
 
 	ade7758_remove_trigger(indio_dev);
-	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
-		iio_unregister_interrupt_line(indio_dev, 0);
-
 	ade7758_uninitialize_ring(indio_dev->ring);
 	iio_device_unregister(indio_dev);
 	ade7758_unconfigure_ring(indio_dev);
diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
index 60abca0..0adfcc6 100644
--- a/drivers/staging/iio/meter/ade7758_trigger.c
+++ b/drivers/staging/iio/meter/ade7758_trigger.c
@@ -15,21 +15,13 @@
 /**
  * ade7758_data_rdy_trig_poll() the event handler for the data rdy trig
  **/
-static int ade7758_data_rdy_trig_poll(struct iio_dev *dev_info,
-				       int index,
-				       s64 timestamp,
-				       int no_test)
+static irqreturn_t ade7758_data_rdy_trig_poll(int irq, void *private)
 {
-	struct ade7758_state *st = iio_dev_get_devdata(dev_info);
-	struct iio_trigger *trig = st->trig;
-
-	iio_trigger_poll(trig, timestamp);
-
+	disable_irq_nosync(irq);
+	iio_trigger_poll(private, iio_get_time_ns());
 	return IRQ_HANDLED;
 }
 
-IIO_EVENT_SH(data_rdy_trig, &ade7758_data_rdy_trig_poll);
-
 static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
 
 static struct attribute *ade7758_trigger_attrs[] = {
@@ -49,22 +41,9 @@ static int ade7758_data_rdy_trigger_set_state(struct iio_trigger *trig,
 {
 	struct ade7758_state *st = trig->private_data;
 	struct iio_dev *indio_dev = st->indio_dev;
-	int ret = 0;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	ret = ade7758_set_irq(&st->indio_dev->dev, state);
-	if (state == false) {
-		iio_remove_event_from_list(&iio_event_data_rdy_trig,
-					   &indio_dev->interrupts[0]
-					   ->ev_list);
-		/* possible quirk with handler currently worked around
-		   by ensuring the work queue is empty */
-		flush_scheduled_work();
-	} else {
-		iio_add_event_to_list(&iio_event_data_rdy_trig,
-				      &indio_dev->interrupts[0]->ev_list);
-	}
-	return ret;
+	return ade7758_set_irq(&indio_dev->dev, state);
 }
 
 /**
@@ -84,13 +63,25 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
 	int ret;
 	struct ade7758_state *st = indio_dev->dev_data;
 
+
 	st->trig = iio_allocate_trigger();
+	if (st->trig == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	ret = request_irq(st->us->irq,
+			  ade7758_data_rdy_trig_poll,
+			  IRQF_TRIGGER_FALLING, "ade7758",
+			  st->trig);
+	if (ret)
+		goto error_free_trig;
+
 	st->trig->name = kasprintf(GFP_KERNEL,
 				"ade7758-dev%d",
 				indio_dev->id);
 	if (!st->trig->name) {
 		ret = -ENOMEM;
-		goto error_free_trig;
+		goto error_free_irq;
 	}
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
@@ -109,9 +100,11 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
 
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
 
@@ -121,5 +114,6 @@ void ade7758_remove_trigger(struct iio_dev *indio_dev)
 
 	iio_trigger_unregister(state->trig);
 	kfree(state->trig->name);
+	free_irq(state->us->irq, state->trig);
 	iio_free_trigger(state->trig);
 }
-- 
1.7.3.4
