Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 073/111] staging:iio:meter:ade7758: Update trigger to the new API
Date: Wed, 18 May 2011 14:42:03 +0100
Message-Id: <1305726161-5606-74-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Update trigger to the new API.
Add file comment/license header.

Some backporting needed to keep the driver building all the way
through the core changes.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/meter/ade7758_trigger.c |   52 ++++++++++++++-------------
 1 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
index 0adfcc6..06c921d 100644
--- a/drivers/staging/iio/meter/ade7758_trigger.c
+++ b/drivers/staging/iio/meter/ade7758_trigger.c
@@ -1,3 +1,11 @@
+/*
+ * ADE7758 Poly Phase Multifunction Energy Metering IC driver
+ *
+ * Copyright 2010-2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/mutex.h>
@@ -19,20 +27,10 @@ static irqreturn_t ade7758_data_rdy_trig_poll(int irq, void *private)
 {
 	disable_irq_nosync(irq);
 	iio_trigger_poll(private, iio_get_time_ns());
+
 	return IRQ_HANDLED;
 }
 
-static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
-
-static struct attribute *ade7758_trigger_attrs[] = {
-	&dev_attr_name.attr,
-	NULL,
-};
-
-static const struct attribute_group ade7758_trigger_attr_group = {
-	.attrs = ade7758_trigger_attrs,
-};
-
 /**
  * ade7758_data_rdy_trigger_set_state() set datardy interrupt state
  **/
@@ -53,6 +51,7 @@ static int ade7758_data_rdy_trigger_set_state(struct iio_trigger *trig,
 static int ade7758_trig_try_reen(struct iio_trigger *trig)
 {
 	struct ade7758_state *st = trig->private_data;
+
 	enable_irq(st->us->irq);
 	/* irq reenabled so success! */
 	return 0;
@@ -62,48 +61,51 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
 	struct ade7758_state *st = indio_dev->dev_data;
+	char *name;
 
+	name = kasprintf(GFP_KERNEL,
+			 "%s-dev%d",
+			 spi_get_device_id(st->us)->name,
+			 indio_dev->id);
+	if (name == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
 
-	st->trig = iio_allocate_trigger();
+	st->trig = iio_allocate_trigger_named(name);
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
-		goto error_ret;
+		goto error_free_name;
 	}
+
 	ret = request_irq(st->us->irq,
 			  ade7758_data_rdy_trig_poll,
-			  IRQF_TRIGGER_FALLING, "ade7758",
+			  IRQF_TRIGGER_LOW,
+			  spi_get_device_id(st->us)->name,
 			  st->trig);
 	if (ret)
 		goto error_free_trig;
 
-	st->trig->name = kasprintf(GFP_KERNEL,
-				"ade7758-dev%d",
-				indio_dev->id);
-	if (!st->trig->name) {
-		ret = -ENOMEM;
-		goto error_free_irq;
-	}
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
 	st->trig->set_trigger_state = &ade7758_data_rdy_trigger_set_state;
 	st->trig->try_reenable = &ade7758_trig_try_reen;
-	st->trig->control_attrs = &ade7758_trigger_attr_group;
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
