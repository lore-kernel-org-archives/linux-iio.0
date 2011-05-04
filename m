Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 86/99] staging:iio:trigger handle name attr in core, remove old alloc and register any control_attrs via struct device
Date: Wed,  4 May 2011 12:58:58 +0100
Message-Id: <1304510351-10922-87-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

As the majority of triggers don't actually have any other control_attrs lets use the fact
that struct device has a groups element when we do need to have these attributes registered.
A vargs function is used to cut down on lots of building strings in every single driver
just in order to pass them into the allocate.

Also iio_allocate_trigger_named -> iio_allocate_trigger as there is no
unamed version any more, so that is now just confusing.

Blackfin tested and fixed by Michael Hennerich.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_trigger.c      |   27 +-----
 drivers/staging/iio/accel/adis16203_trigger.c      |   28 +-----
 drivers/staging/iio/accel/adis16204_trigger.c      |   28 +-----
 drivers/staging/iio/accel/adis16209_trigger.c      |   28 +-----
 drivers/staging/iio/accel/adis16240_trigger.c      |   25 +-----
 drivers/staging/iio/accel/lis3l02dq_ring.c         |   27 +-----
 drivers/staging/iio/gyro/adis16260_trigger.c       |   30 +-----
 drivers/staging/iio/imu/adis16400_trigger.c        |   31 +-----
 drivers/staging/iio/industrialio-trigger.c         |  103 ++++++++++----------
 drivers/staging/iio/trigger.h                      |   26 ++----
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |   22 ++---
 drivers/staging/iio/trigger/iio-trig-gpio.c        |   25 +-----
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |   24 ++---
 drivers/staging/iio/trigger/iio-trig-sysfs.c       |   23 ++---
 14 files changed, 106 insertions(+), 341 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_trigger.c b/drivers/staging/iio/accel/adis16201_trigger.c
index bfd43c5..bea917e 100644
--- a/drivers/staging/iio/accel/adis16201_trigger.c
+++ b/drivers/staging/iio/accel/adis16201_trigger.c
@@ -11,17 +11,6 @@
 #include "../trigger.h"
 #include "adis16201.h"
 
-static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
-
-static struct attribute *adis16201_trigger_attrs[] = {
-	&dev_attr_name.attr,
-	NULL,
-};
-
-static const struct attribute_group adis16201_trigger_attr_group = {
-	.attrs = adis16201_trigger_attrs,
-};
-
 /**
  * adis16201_data_rdy_trigger_set_state() set datardy interrupt state
  **/
@@ -39,19 +28,11 @@ int adis16201_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
 	struct adis16201_state *st = indio_dev->dev_data;
-	char *name;
 
-	name = kasprintf(GFP_KERNEL,
-			 "adis16201-dev%d",
-			 indio_dev->id);
-	if (name == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	st->trig = iio_allocate_trigger_named(name);
+	st->trig = iio_allocate_trigger("adis16201-dev%d", indio_dev->id);
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
-		goto error_free_name;
+		goto error_ret;
 	}
 	ret = request_irq(st->us->irq,
 			  &iio_trigger_generic_data_rdy_poll,
@@ -64,7 +45,6 @@ int adis16201_probe_trigger(struct iio_dev *indio_dev)
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
 	st->trig->set_trigger_state = &adis16201_data_rdy_trigger_set_state;
-	st->trig->control_attrs = &adis16201_trigger_attr_group;
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
@@ -78,8 +58,6 @@ error_free_irq:
 	free_irq(st->us->irq, st->trig);
 error_free_trig:
 	iio_free_trigger(st->trig);
-error_free_name:
-	kfree(name);
 error_ret:
 	return ret;
 }
@@ -89,7 +67,6 @@ void adis16201_remove_trigger(struct iio_dev *indio_dev)
 	struct adis16201_state *state = indio_dev->dev_data;
 
 	iio_trigger_unregister(state->trig);
-	kfree(state->trig->name);
 	free_irq(state->us->irq, state->trig);
 	iio_free_trigger(state->trig);
 }
diff --git a/drivers/staging/iio/accel/adis16203_trigger.c b/drivers/staging/iio/accel/adis16203_trigger.c
index 72710f8..ca5db17 100644
--- a/drivers/staging/iio/accel/adis16203_trigger.c
+++ b/drivers/staging/iio/accel/adis16203_trigger.c
@@ -12,17 +12,6 @@
 #include "../trigger.h"
 #include "adis16203.h"
 
-static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
-
-static struct attribute *adis16203_trigger_attrs[] = {
-	&dev_attr_name.attr,
-	NULL,
-};
-
-static const struct attribute_group adis16203_trigger_attr_group = {
-	.attrs = adis16203_trigger_attrs,
-};
-
 /**
  * adis16203_data_rdy_trigger_set_state() set datardy interrupt state
  **/
@@ -40,20 +29,11 @@ int adis16203_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
 	struct adis16203_state *st = indio_dev->dev_data;
-	char *name;
-
-	name = kasprintf(GFP_KERNEL,
-			 "adis16203-dev%d",
-			 indio_dev->id);
-	if (name == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
 
-	st->trig = iio_allocate_trigger_named(name);
+	st->trig = iio_allocate_trigger("adis16203-dev%d", indio_dev->id);
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
-		goto error_free_name;
+		goto error_ret;
 	}
 
 	ret = request_irq(st->us->irq,
@@ -68,7 +48,6 @@ int adis16203_probe_trigger(struct iio_dev *indio_dev)
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
 	st->trig->set_trigger_state = &adis16203_data_rdy_trigger_set_state;
-	st->trig->control_attrs = &adis16203_trigger_attr_group;
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
@@ -82,8 +61,6 @@ error_free_irq:
 	free_irq(st->us->irq, st->trig);
 error_free_trig:
 	iio_free_trigger(st->trig);
-error_free_name:
-	kfree(name);
 error_ret:
 	return ret;
 }
@@ -93,7 +70,6 @@ void adis16203_remove_trigger(struct iio_dev *indio_dev)
 	struct adis16203_state *state = indio_dev->dev_data;
 
 	iio_trigger_unregister(state->trig);
-	kfree(state->trig->name);
 	free_irq(state->us->irq, state->trig);
 	iio_free_trigger(state->trig);
 }
diff --git a/drivers/staging/iio/accel/adis16204_trigger.c b/drivers/staging/iio/accel/adis16204_trigger.c
index a00668c..5e1f9ae 100644
--- a/drivers/staging/iio/accel/adis16204_trigger.c
+++ b/drivers/staging/iio/accel/adis16204_trigger.c
@@ -12,17 +12,6 @@
 #include "../trigger.h"
 #include "adis16204.h"
 
-static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
-
-static struct attribute *adis16204_trigger_attrs[] = {
-	&dev_attr_name.attr,
-	NULL,
-};
-
-static const struct attribute_group adis16204_trigger_attr_group = {
-	.attrs = adis16204_trigger_attrs,
-};
-
 /**
  * adis16204_data_rdy_trigger_set_state() set datardy interrupt state
  **/
@@ -40,20 +29,11 @@ int adis16204_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
 	struct adis16204_state *st = indio_dev->dev_data;
-	char *name;
-
-	name = kasprintf(GFP_KERNEL,
-			 "adis16204-dev%d",
-			 indio_dev->id);
-	if (name == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
 
-	st->trig = iio_allocate_trigger_named(name);
+	st->trig = iio_allocate_trigger("adis16204-dev%d", indio_dev->id);
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
-		goto error_free_name;
+		goto error_ret;
 	}
 
 	ret = request_irq(st->us->irq,
@@ -68,7 +48,6 @@ int adis16204_probe_trigger(struct iio_dev *indio_dev)
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
 	st->trig->set_trigger_state = &adis16204_data_rdy_trigger_set_state;
-	st->trig->control_attrs = &adis16204_trigger_attr_group;
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
@@ -82,8 +61,6 @@ error_free_irq:
 	free_irq(st->us->irq, st->trig);
 error_free_trig:
 	iio_free_trigger(st->trig);
-error_free_name:
-	kfree(name);
 error_ret:
 	return ret;
 }
@@ -93,7 +70,6 @@ void adis16204_remove_trigger(struct iio_dev *indio_dev)
 	struct adis16204_state *state = indio_dev->dev_data;
 
 	iio_trigger_unregister(state->trig);
-	kfree(state->trig->name);
 	free_irq(state->us->irq, state->trig);
 	iio_free_trigger(state->trig);
 }
diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/staging/iio/accel/adis16209_trigger.c
index 0847ce5..211ee70 100644
--- a/drivers/staging/iio/accel/adis16209_trigger.c
+++ b/drivers/staging/iio/accel/adis16209_trigger.c
@@ -21,17 +21,6 @@ static irqreturn_t adis16209_data_rdy_trig_poll(int irq, void *trig)
 	return IRQ_HANDLED;
 }
 
-static IIO_TRIGGER_NAME_ATTR;
-
-static struct attribute *adis16209_trigger_attrs[] = {
-	&dev_attr_name.attr,
-	NULL,
-};
-
-static const struct attribute_group adis16209_trigger_attr_group = {
-	.attrs = adis16209_trigger_attrs,
-};
-
 /**
  * adis16209_data_rdy_trigger_set_state() set datardy interrupt state
  **/
@@ -49,20 +38,11 @@ int adis16209_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
 	struct adis16209_state *st = indio_dev->dev_data;
-	char *name;
-
-	name = kasprintf(GFP_KERNEL,
-			 "adis16209-dev%d",
-			 indio_dev->id);
-	if (name == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
 
-	st->trig = iio_allocate_trigger_named(name);
+	st->trig = iio_allocate_trigger("adis16209-dev%d", indio_dev->id);
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
-		goto error_free_name;
+		goto error_ret;
 	}
 
 	ret = request_irq(st->us->irq,
@@ -76,7 +56,6 @@ int adis16209_probe_trigger(struct iio_dev *indio_dev)
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
 	st->trig->set_trigger_state = &adis16209_data_rdy_trigger_set_state;
-	st->trig->control_attrs = &adis16209_trigger_attr_group;
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
@@ -90,8 +69,6 @@ error_free_irq:
 	free_irq(st->us->irq, st->trig);
 error_free_trig:
 	iio_free_trigger(st->trig);
-error_free_name:
-	kfree(name);
 error_ret:
 	return ret;
 }
@@ -101,7 +78,6 @@ void adis16209_remove_trigger(struct iio_dev *indio_dev)
 	struct adis16209_state *state = indio_dev->dev_data;
 
 	iio_trigger_unregister(state->trig);
-	kfree(state->trig->name);
 	free_irq(state->us->irq, state->trig);
 	iio_free_trigger(state->trig);
 }
diff --git a/drivers/staging/iio/accel/adis16240_trigger.c b/drivers/staging/iio/accel/adis16240_trigger.c
index d5bda92..ece3ca8 100644
--- a/drivers/staging/iio/accel/adis16240_trigger.c
+++ b/drivers/staging/iio/accel/adis16240_trigger.c
@@ -21,17 +21,6 @@ static irqreturn_t adis16240_data_rdy_trig_poll(int irq, void *trig)
 	return IRQ_HANDLED;
 }
 
-static IIO_TRIGGER_NAME_ATTR;
-
-static struct attribute *adis16240_trigger_attrs[] = {
-	&dev_attr_name.attr,
-	NULL,
-};
-
-static const struct attribute_group adis16240_trigger_attr_group = {
-	.attrs = adis16240_trigger_attrs,
-};
-
 /**
  * adis16240_data_rdy_trigger_set_state() set datardy interrupt state
  **/
@@ -49,17 +38,11 @@ int adis16240_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
 	struct adis16240_state *st = indio_dev->dev_data;
-	char *name;
 
-	name = kasprintf(GFP_KERNEL, "adis16240-dev%d", indio_dev->id);
-	if (name == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	st->trig = iio_allocate_trigger_named(name);
+	st->trig = iio_allocate_trigger("adis16240-dev%d", indio_dev->id);
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
-		goto error_free_name;
+		goto error_ret;
 	}
 
 	ret = request_irq(st->us->irq,
@@ -74,7 +57,6 @@ int adis16240_probe_trigger(struct iio_dev *indio_dev)
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
 	st->trig->set_trigger_state = &adis16240_data_rdy_trigger_set_state;
-	st->trig->control_attrs = &adis16240_trigger_attr_group;
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
@@ -88,8 +70,6 @@ error_free_irq:
 	free_irq(st->us->irq, st->trig);
 error_free_trig:
 	iio_free_trigger(st->trig);
-error_free_name:
-	kfree(name);
 error_ret:
 	return ret;
 }
@@ -99,7 +79,6 @@ void adis16240_remove_trigger(struct iio_dev *indio_dev)
 	struct adis16240_state *state = indio_dev->dev_data;
 
 	iio_trigger_unregister(state->trig);
-	kfree(state->trig->name);
 	free_irq(state->us->irq, state->trig);
 	iio_free_trigger(state->trig);
 }
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 83f2bbe..2b7219b 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -260,17 +260,6 @@ static int lis3l02dq_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	return ret;
 }
 
-static IIO_TRIGGER_NAME_ATTR;
-
-static struct attribute *lis3l02dq_trigger_attrs[] = {
-	&dev_attr_name.attr,
-	NULL,
-};
-
-static const struct attribute_group lis3l02dq_trigger_attr_group = {
-	.attrs = lis3l02dq_trigger_attrs,
-};
-
 /**
  * lis3l02dq_trig_try_reen() try renabling irq for data rdy trigger
  * @trig:	the datardy trigger
@@ -301,19 +290,11 @@ int lis3l02dq_probe_trigger(struct iio_dev *indio_dev)
 	struct iio_sw_ring_helper_state *h
 		= iio_dev_get_devdata(indio_dev);
 	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
-	char *name;
 
-	name = kasprintf(GFP_KERNEL,
-			 "lis3l02dq-dev%d",
-			 indio_dev->id);
-	if (name == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	st->trig = iio_allocate_trigger_named(name);
+	st->trig = iio_allocate_trigger("lis3l02dq-dev%d", indio_dev->id);
 	if (!st->trig) {
 		ret = -ENOMEM;
-		goto error_free_name;
+		goto error_ret;
 	}
 
 	st->trig->dev.parent = &st->us->dev;
@@ -321,7 +302,6 @@ int lis3l02dq_probe_trigger(struct iio_dev *indio_dev)
 	st->trig->private_data = st;
 	st->trig->set_trigger_state = &lis3l02dq_data_rdy_trigger_set_state;
 	st->trig->try_reenable = &lis3l02dq_trig_try_reen;
-	st->trig->control_attrs = &lis3l02dq_trigger_attr_group;
 	ret = iio_trigger_register(st->trig);
 	if (ret)
 		goto error_free_trig;
@@ -330,8 +310,6 @@ int lis3l02dq_probe_trigger(struct iio_dev *indio_dev)
 
 error_free_trig:
 	iio_free_trigger(st->trig);
-error_free_name:
-	kfree(name);
 error_ret:
 	return ret;
 }
@@ -343,7 +321,6 @@ void lis3l02dq_remove_trigger(struct iio_dev *indio_dev)
 	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
 
 	iio_trigger_unregister(st->trig);
-	kfree(st->trig->name);
 	iio_free_trigger(st->trig);
 }
 
diff --git a/drivers/staging/iio/gyro/adis16260_trigger.c b/drivers/staging/iio/gyro/adis16260_trigger.c
index 228272e..4f10fb5 100644
--- a/drivers/staging/iio/gyro/adis16260_trigger.c
+++ b/drivers/staging/iio/gyro/adis16260_trigger.c
@@ -12,17 +12,6 @@
 #include "../trigger.h"
 #include "adis16260.h"
 
-static IIO_TRIGGER_NAME_ATTR;
-
-static struct attribute *adis16260_trigger_attrs[] = {
-	&dev_attr_name.attr,
-	NULL,
-};
-
-static const struct attribute_group adis16260_trigger_attr_group = {
-	.attrs = adis16260_trigger_attrs,
-};
-
 /**
  * adis16260_data_rdy_trigger_set_state() set datardy interrupt state
  **/
@@ -40,20 +29,13 @@ int adis16260_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
 	struct adis16260_state *st = indio_dev->dev_data;
-	char *name;
-	name = kasprintf(GFP_KERNEL,
-			 "%s-dev%d",
-			 spi_get_device_id(st->us)->name,
-			 indio_dev->id);
-	if (name == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
 
-	st->trig = iio_allocate_trigger_named(name);
+	st->trig = iio_allocate_trigger("%s-dev%d",
+					spi_get_device_id(st->us)->name,
+					indio_dev->id);
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
-		goto error_free_name;
+		goto error_ret;
 	}
 
 	ret = request_irq(st->us->irq,
@@ -68,7 +50,6 @@ int adis16260_probe_trigger(struct iio_dev *indio_dev)
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
 	st->trig->set_trigger_state = &adis16260_data_rdy_trigger_set_state;
-	st->trig->control_attrs = &adis16260_trigger_attr_group;
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
@@ -82,8 +63,6 @@ error_free_irq:
 	free_irq(st->us->irq, st->trig);
 error_free_trig:
 	iio_free_trigger(st->trig);
-error_free_name:
-	kfree(name);
 error_ret:
 	return ret;
 }
@@ -93,7 +72,6 @@ void adis16260_remove_trigger(struct iio_dev *indio_dev)
 	struct adis16260_state *state = indio_dev->dev_data;
 
 	iio_trigger_unregister(state->trig);
-	kfree(state->trig->name);
 	free_irq(state->us->irq, state->trig);
 	iio_free_trigger(state->trig);
 }
diff --git a/drivers/staging/iio/imu/adis16400_trigger.c b/drivers/staging/iio/imu/adis16400_trigger.c
index d0c4aea..d426fba 100644
--- a/drivers/staging/iio/imu/adis16400_trigger.c
+++ b/drivers/staging/iio/imu/adis16400_trigger.c
@@ -12,17 +12,6 @@
 #include "../trigger.h"
 #include "adis16400.h"
 
-static IIO_TRIGGER_NAME_ATTR;
-
-static struct attribute *adis16400_trigger_attrs[] = {
-	&dev_attr_name.attr,
-	NULL,
-};
-
-static const struct attribute_group adis16400_trigger_attr_group = {
-	.attrs = adis16400_trigger_attrs,
-};
-
 /**
  * adis16400_data_rdy_trigger_set_state() set datardy interrupt state
  **/
@@ -40,21 +29,13 @@ int adis16400_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
 	struct adis16400_state *st = indio_dev->dev_data;
-	char *name;
-
-	name = kasprintf(GFP_KERNEL,
-			 "%s-dev%d",
-			 spi_get_device_id(st->us)->name,
-			 indio_dev->id);
-	if (name == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
 
-	st->trig = iio_allocate_trigger_named(name);
+	st->trig = iio_allocate_trigger("%s-dev%d",
+					spi_get_device_id(st->us)->name,
+					indio_dev->id);
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
-		goto error_free_name;
+		goto error_ret;
 	}
 
 	ret = request_irq(st->us->irq,
@@ -68,7 +49,6 @@ int adis16400_probe_trigger(struct iio_dev *indio_dev)
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
 	st->trig->set_trigger_state = &adis16400_data_rdy_trigger_set_state;
-	st->trig->control_attrs = &adis16400_trigger_attr_group;
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
@@ -82,8 +62,6 @@ error_free_irq:
 	free_irq(st->us->irq, st->trig);
 error_free_trig:
 	iio_free_trigger(st->trig);
-error_free_name:
-	kfree(name);
 error_ret:
 	return ret;
 }
@@ -93,7 +71,6 @@ void adis16400_remove_trigger(struct iio_dev *indio_dev)
 	struct adis16400_state *state = indio_dev->dev_data;
 
 	iio_trigger_unregister(state->trig);
-	kfree(state->trig->name);
 	free_irq(state->us->irq, state->trig);
 	iio_free_trigger(state->trig);
 }
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 86d026b..e83edac 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -39,6 +39,19 @@ static LIST_HEAD(iio_trigger_list);
 static DEFINE_MUTEX(iio_trigger_list_lock);
 
 /**
+ * iio_trigger_read_name() - retrieve useful identifying name
+ **/
+static ssize_t iio_trigger_read_name(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct iio_trigger *trig = dev_get_drvdata(dev);
+	return sprintf(buf, "%s\n", trig->name);
+}
+
+static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+
+/**
  * iio_trigger_register_sysfs() - create a device for this trigger
  * @trig_info:	the trigger
  *
@@ -46,20 +59,16 @@ static DEFINE_MUTEX(iio_trigger_list_lock);
  **/
 static int iio_trigger_register_sysfs(struct iio_trigger *trig_info)
 {
-	int ret = 0;
-
-	if (trig_info->control_attrs)
-		ret = sysfs_create_group(&trig_info->dev.kobj,
-					 trig_info->control_attrs);
-
-	return ret;
+	return sysfs_add_file_to_group(&trig_info->dev.kobj,
+				       &dev_attr_name.attr,
+				       NULL);
 }
 
 static void iio_trigger_unregister_sysfs(struct iio_trigger *trig_info)
 {
-	if (trig_info->control_attrs)
-		sysfs_remove_group(&trig_info->dev.kobj,
-				   trig_info->control_attrs);
+	sysfs_remove_file_from_group(&trig_info->dev.kobj,
+					   &dev_attr_name.attr,
+					   NULL);
 }
 
 
@@ -205,18 +214,6 @@ void iio_trigger_notify_done(struct iio_trigger *trig)
 }
 EXPORT_SYMBOL(iio_trigger_notify_done);
 
-/**
- * iio_trigger_read_name() - retrieve useful identifying name
- **/
-ssize_t iio_trigger_read_name(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	struct iio_trigger *trig = dev_get_drvdata(dev);
-	return sprintf(buf, "%s\n", trig->name);
-}
-EXPORT_SYMBOL(iio_trigger_read_name);
-
 /* Trigger Consumer related functions */
 
 /* Complexity in here.  With certain triggers (datardy) an acknowledgement
@@ -355,6 +352,7 @@ static void iio_trig_release(struct device *device)
 		irq_free_descs(trig->subirq_base,
 			       CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 	}
+	kfree(trig->name);
 	kfree(trig);
 	iio_put();
 }
@@ -381,8 +379,9 @@ static void iio_trig_subirqunmask(struct irq_data *d)
 	trig->subirqs[d->irq - trig->subirq_base].enabled = true;
 }
 
-struct iio_trigger *iio_allocate_trigger_named(const char *name)
+struct iio_trigger *iio_allocate_trigger(const char *fmt, ...)
 {
+	va_list vargs;
 	struct iio_trigger *trig;
 	trig = kzalloc(sizeof *trig, GFP_KERNEL);
 	if (trig) {
@@ -392,40 +391,40 @@ struct iio_trigger *iio_allocate_trigger_named(const char *name)
 		device_initialize(&trig->dev);
 		dev_set_drvdata(&trig->dev, (void *)trig);
 
-		if (name) {
-			mutex_init(&trig->pool_lock);
-			trig->subirq_base
-				= irq_alloc_descs(-1, 0,
-					CONFIG_IIO_CONSUMERS_PER_TRIGGER,
-					0);
-			if (trig->subirq_base < 0) {
-				kfree(trig);
-				return NULL;
-			}
-			trig->name = name;
-			trig->subirq_chip.name = name;
-			trig->subirq_chip.irq_mask = &iio_trig_subirqmask;
-			trig->subirq_chip.irq_unmask = &iio_trig_subirqunmask;
-			for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
-				irq_set_chip(trig->subirq_base + i,
-					     &trig->subirq_chip);
-				irq_set_handler(trig->subirq_base + i,
-						&handle_simple_irq);
-				irq_modify_status(trig->subirq_base + i,
-						  IRQ_NOREQUEST | IRQ_NOAUTOEN,
-						  IRQ_NOPROBE);
-			}
+		mutex_init(&trig->pool_lock);
+		trig->subirq_base
+			= irq_alloc_descs(-1, 0,
+					  CONFIG_IIO_CONSUMERS_PER_TRIGGER,
+					  0);
+		if (trig->subirq_base < 0) {
+			kfree(trig);
+			return NULL;
+		}
+		va_start(vargs, fmt);
+		trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
+		va_end(vargs);
+		if (trig->name == NULL) {
+			irq_free_descs(trig->subirq_base,
+				       CONFIG_IIO_CONSUMERS_PER_TRIGGER);
+			kfree(trig);
+			return NULL;
+		}
+		trig->subirq_chip.name = trig->name;
+		trig->subirq_chip.irq_mask = &iio_trig_subirqmask;
+		trig->subirq_chip.irq_unmask = &iio_trig_subirqunmask;
+		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
+			irq_set_chip(trig->subirq_base + i,
+				     &trig->subirq_chip);
+			irq_set_handler(trig->subirq_base + i,
+					&handle_simple_irq);
+			irq_modify_status(trig->subirq_base + i,
+					  IRQ_NOREQUEST | IRQ_NOAUTOEN,
+					  IRQ_NOPROBE);
 		}
 		iio_get();
 	}
 	return trig;
 }
-EXPORT_SYMBOL(iio_allocate_trigger_named);
-
-struct iio_trigger *iio_allocate_trigger(void)
-{
-	return iio_allocate_trigger_named(NULL);
-}
 EXPORT_SYMBOL(iio_allocate_trigger);
 
 void iio_free_trigger(struct iio_trigger *trig)
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 5efa0d5..7faa31a 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -24,12 +24,16 @@ struct iio_subirq {
  * @private_data:	[DRIVER] device specific data
  * @list:		[INTERN] used in maintenance of global trigger list
  * @alloc_list:		[DRIVER] used for driver specific trigger list
- * @control_attrs:	[DRIVER] sysfs attributes relevant to trigger type
  * @owner:		[DRIVER] used to monitor usage count of the trigger.
  * @use_count:		use count for the trigger
  * @set_trigger_state:	[DRIVER] switch on/off the trigger on demand
  * @try_reenable:	function to reenable the trigger when the
  *			use count is zero (may be NULL)
+ * @subirq_chip:	[INTERN] associate 'virtual' irq chip.
+ * @subirq_base:	[INTERN] base number for irqs provided by trigger.
+ * @subirqs:		[INTERN] information about the 'child' irqs.
+ * @pool:		[INTERN] bitmap of irqs currently in use.
+ * @pool_lock:		[INTERN] protection of the irq pool.
  **/
 struct iio_trigger {
 	int				id;
@@ -39,7 +43,6 @@ struct iio_trigger {
 	void				*private_data;
 	struct list_head		list;
 	struct list_head		alloc_list;
-	const struct attribute_group	*control_attrs;
 	struct module			*owner;
 	int use_count;
 
@@ -72,20 +75,6 @@ static inline void iio_get_trigger(struct iio_trigger *trig)
 };
 
 /**
- * iio_trigger_read_name() - sysfs access function to get the trigger name
- * @dev: the system device
- * @attr: device attributes for the device
- * @buf: output buffer to store the trigger name
- **/
-ssize_t iio_trigger_read_name(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf);
-
-#define IIO_TRIGGER_NAME_ATTR DEVICE_ATTR(name, S_IRUGO,		\
-					  iio_trigger_read_name,	\
-					  NULL);
-
-/**
  * iio_trigger_register() - register a trigger with the IIO core
  * @trig_info:	trigger to be registered
  **/
@@ -154,6 +143,7 @@ static inline void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
  * @h:				the function that is actually run on trigger
  * @thread:			threaded interrupt part
  * @type:			the type of interrupt (basically if oneshot)
+ * @name:			name used to identify the trigger consumer.
  * @irq:			the corresponding irq as allocated from the
  *				trigger pool
  * @timestamp:			some devices need a timestamp grabbed as soon
@@ -179,8 +169,8 @@ irqreturn_t iio_pollfunc_store_time(int irq, void *p);
 int iio_triggered_ring_postenable(struct iio_dev *indio_dev);
 int iio_triggered_ring_predisable(struct iio_dev *indio_dev);
 
-struct iio_trigger *iio_allocate_trigger(void);
-struct iio_trigger *iio_allocate_trigger_named(const char *name);
+struct iio_trigger *iio_allocate_trigger(const char *fmt, ...)
+	__attribute__((format(printf, 1, 2)));
 void iio_free_trigger(struct iio_trigger *trig);
 
 #endif /* _IIO_TRIGGER_H_ */
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 583bef0..4f17295 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -106,11 +106,9 @@ static ssize_t iio_bfin_tmr_frequency_show(struct device *dev,
 
 static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR, iio_bfin_tmr_frequency_show,
 		   iio_bfin_tmr_frequency_store);
-static IIO_TRIGGER_NAME_ATTR;
 
 static struct attribute *iio_bfin_tmr_trigger_attrs[] = {
 	&dev_attr_frequency.attr,
-	&dev_attr_name.attr,
 	NULL,
 };
 
@@ -118,6 +116,11 @@ static const struct attribute_group iio_bfin_tmr_trigger_attr_group = {
 	.attrs = iio_bfin_tmr_trigger_attrs,
 };
 
+static const struct attribute_group *iio_bfin_tmr_trigger_attr_groups[] = {
+	&iio_bfin_tmr_trigger_attr_group,
+	NULL
+};
+
 
 static irqreturn_t iio_bfin_tmr_trigger_isr(int irq, void *devid)
 {
@@ -165,24 +168,18 @@ static int __devinit iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
 	st->timer_num = ret;
 	st->t = &iio_bfin_timer_code[st->timer_num];
 
-	st->trig = iio_allocate_trigger();
+	st->trig = iio_allocate_trigger("bfintmr%d", st->timer_num);
 	if (!st->trig) {
 		ret = -ENOMEM;
 		goto out1;
 	}
 
 	st->trig->private_data = st;
-	st->trig->control_attrs = &iio_bfin_tmr_trigger_attr_group;
 	st->trig->owner = THIS_MODULE;
-	st->trig->name = kasprintf(GFP_KERNEL, "bfintmr%d", st->timer_num);
-	if (st->trig->name == NULL) {
-		ret = -ENOMEM;
-		goto out2;
-	}
-
+	st->trig->dev.groups = iio_bfin_tmr_trigger_attr_groups;
 	ret = iio_trigger_register(st->trig);
 	if (ret)
-		goto out3;
+		goto out2;
 
 	ret = request_irq(st->irq, iio_bfin_tmr_trigger_isr,
 			  0, st->trig->name, st);
@@ -201,8 +198,6 @@ static int __devinit iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
 	return 0;
 out4:
 	iio_trigger_unregister(st->trig);
-out3:
-	kfree(st->trig->name);
 out2:
 	iio_put_trigger(st->trig);
 out1:
@@ -218,7 +213,6 @@ static int __devexit iio_bfin_tmr_trigger_remove(struct platform_device *pdev)
 	disable_gptimers(st->t->bit);
 	free_irq(st->irq, st);
 	iio_trigger_unregister(st->trig);
-	kfree(st->trig->name);
 	iio_put_trigger(st->trig);
 	kfree(st);
 
diff --git a/drivers/staging/iio/trigger/iio-trig-gpio.c b/drivers/staging/iio/trigger/iio-trig-gpio.c
index 2ce95e9..b188635 100644
--- a/drivers/staging/iio/trigger/iio-trig-gpio.c
+++ b/drivers/staging/iio/trigger/iio-trig-gpio.c
@@ -47,17 +47,6 @@ static irqreturn_t iio_gpio_trigger_poll(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static IIO_TRIGGER_NAME_ATTR;
-
-static struct attribute *iio_gpio_trigger_attrs[] = {
-	&dev_attr_name.attr,
-	NULL,
-};
-
-static const struct attribute_group iio_gpio_trigger_attr_group = {
-	.attrs = iio_gpio_trigger_attrs,
-};
-
 static int iio_gpio_trigger_probe(struct platform_device *pdev)
 {
 	struct iio_gpio_trigger_info *trig_info;
@@ -79,7 +68,7 @@ static int iio_gpio_trigger_probe(struct platform_device *pdev)
 
 		for (irq = irq_res->start; irq <= irq_res->end; irq++) {
 
-			trig = iio_allocate_trigger();
+			trig = iio_allocate_trigger("irqtrig%d", irq);
 			if (!trig) {
 				ret = -ENOMEM;
 				goto error_free_completed_registrations;
@@ -90,21 +79,15 @@ static int iio_gpio_trigger_probe(struct platform_device *pdev)
 				ret = -ENOMEM;
 				goto error_put_trigger;
 			}
-			trig->control_attrs = &iio_gpio_trigger_attr_group;
 			trig->private_data = trig_info;
 			trig_info->irq = irq;
 			trig->owner = THIS_MODULE;
-			trig->name = kasprintf(GFP_KERNEL, "irqtrig%d", irq);
-			if (trig->name == NULL) {
-				ret = -ENOMEM;
-				goto error_free_trig_info;
-			}
 			ret = request_irq(irq, iio_gpio_trigger_poll,
 					  irqflags, trig->name, trig);
 			if (ret) {
 				dev_err(&pdev->dev,
 					"request IRQ-%d failed", irq);
-				goto error_free_name;
+				goto error_free_trig_info;
 			}
 
 			ret = iio_trigger_register(trig);
@@ -124,8 +107,6 @@ static int iio_gpio_trigger_probe(struct platform_device *pdev)
 /* First clean up the partly allocated trigger */
 error_release_irq:
 	free_irq(irq, trig);
-error_free_name:
-	kfree(trig->name);
 error_free_trig_info:
 	kfree(trig_info);
 error_put_trigger:
@@ -138,7 +119,6 @@ error_free_completed_registrations:
 				 alloc_list) {
 		trig_info = trig->private_data;
 		free_irq(gpio_to_irq(trig_info->irq), trig);
-		kfree(trig->name);
 		kfree(trig_info);
 		iio_trigger_unregister(trig);
 	}
@@ -159,7 +139,6 @@ static int iio_gpio_trigger_remove(struct platform_device *pdev)
 		trig_info = trig->private_data;
 		iio_trigger_unregister(trig);
 		free_irq(trig_info->irq, trig);
-		kfree(trig->name);
 		kfree(trig_info);
 		iio_put_trigger(trig);
 	}
diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index 24f174e..01cf7e2 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -72,20 +72,24 @@ error_ret:
 	return ret;
 }
 
-static IIO_TRIGGER_NAME_ATTR;
 static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR,
 	    iio_trig_periodic_read_freq,
 	    iio_trig_periodic_write_freq);
 
 static struct attribute *iio_trig_prtc_attrs[] = {
 	&dev_attr_frequency.attr,
-	&dev_attr_name.attr,
 	NULL,
 };
+
 static const struct attribute_group iio_trig_prtc_attr_group = {
 	.attrs = iio_trig_prtc_attrs,
 };
 
+static const struct attribute_group *iio_trig_prtc_attr_groups[] = {
+	&iio_trig_prtc_attr_group,
+	NULL
+};
+
 static void iio_prtc_trigger_poll(void *private_data)
 {
 	/* Timestamp is not provided currently */
@@ -103,7 +107,7 @@ static int iio_trig_periodic_rtc_probe(struct platform_device *dev)
 	for (i = 0;; i++) {
 		if (pdata[i] == NULL)
 			break;
-		trig = iio_allocate_trigger();
+		trig = iio_allocate_trigger("periodic%s", pdata[i]);
 		if (!trig) {
 			ret = -ENOMEM;
 			goto error_free_completed_registrations;
@@ -118,25 +122,19 @@ static int iio_trig_periodic_rtc_probe(struct platform_device *dev)
 		trig->private_data = trig_info;
 		trig->owner = THIS_MODULE;
 		trig->set_trigger_state = &iio_trig_periodic_rtc_set_state;
-		trig->name = kasprintf(GFP_KERNEL, "periodic%s", pdata[i]);
-		if (trig->name == NULL) {
-			ret = -ENOMEM;
-			goto error_free_trig_info;
-		}
-
 		/* RTC access */
 		trig_info->rtc
 			= rtc_class_open(pdata[i]);
 		if (trig_info->rtc == NULL) {
 			ret = -EINVAL;
-			goto error_free_name;
+			goto error_free_trig_info;
 		}
 		trig_info->task.func = iio_prtc_trigger_poll;
 		trig_info->task.private_data = trig;
 		ret = rtc_irq_register(trig_info->rtc, &trig_info->task);
 		if (ret)
 			goto error_close_rtc;
-		trig->control_attrs = &iio_trig_prtc_attr_group;
+		trig->dev.groups = iio_trig_prtc_attr_groups;
 		ret = iio_trigger_register(trig);
 		if (ret)
 			goto error_unregister_rtc_irq;
@@ -146,8 +144,6 @@ error_unregister_rtc_irq:
 	rtc_irq_unregister(trig_info->rtc, &trig_info->task);
 error_close_rtc:
 	rtc_class_close(trig_info->rtc);
-error_free_name:
-	kfree(trig->name);
 error_free_trig_info:
 	kfree(trig_info);
 error_put_trigger_and_remove_from_list:
@@ -161,7 +157,6 @@ error_free_completed_registrations:
 		trig_info = trig->private_data;
 		rtc_irq_unregister(trig_info->rtc, &trig_info->task);
 		rtc_class_close(trig_info->rtc);
-		kfree(trig->name);
 		kfree(trig_info);
 		iio_trigger_unregister(trig);
 	}
@@ -180,7 +175,6 @@ static int iio_trig_periodic_rtc_remove(struct platform_device *dev)
 		trig_info = trig->private_data;
 		rtc_irq_unregister(trig_info->rtc, &trig_info->task);
 		rtc_class_close(trig_info->rtc);
-		kfree(trig->name);
 		kfree(trig_info);
 		iio_trigger_unregister(trig);
 	}
diff --git a/drivers/staging/iio/trigger/iio-trig-sysfs.c b/drivers/staging/iio/trigger/iio-trig-sysfs.c
index 6d3dee3..47248cd 100644
--- a/drivers/staging/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/staging/iio/trigger/iio-trig-sysfs.c
@@ -92,11 +92,9 @@ static ssize_t iio_sysfs_trigger_poll(struct device *dev,
 }
 
 static DEVICE_ATTR(trigger_now, S_IWUSR, NULL, iio_sysfs_trigger_poll);
-static IIO_TRIGGER_NAME_ATTR;
 
 static struct attribute *iio_sysfs_trigger_attrs[] = {
 	&dev_attr_trigger_now.attr,
-	&dev_attr_name.attr,
 	NULL,
 };
 
@@ -104,11 +102,15 @@ static const struct attribute_group iio_sysfs_trigger_attr_group = {
 	.attrs = iio_sysfs_trigger_attrs,
 };
 
+static const struct attribute_group *iio_sysfs_trigger_attr_groups[] = {
+	&iio_sysfs_trigger_attr_group,
+	NULL
+};
+
 static int iio_sysfs_trigger_probe(int id)
 {
 	struct iio_sysfs_trig *t;
 	int ret;
-	char *name;
 	bool foundit = false;
 	mutex_lock(&iio_syfs_trig_list_mut);
 	list_for_each_entry(t, &iio_sysfs_trig_list, l)
@@ -120,25 +122,19 @@ static int iio_sysfs_trigger_probe(int id)
 		ret = -EINVAL;
 		goto out1;
 	}
-
-	name = kasprintf(GFP_KERNEL, "sysfstrig%d", id);
-	if (name == NULL) {
-		ret = -ENOMEM;
-		goto out1;
-	}
 	t = kmalloc(sizeof(*t), GFP_KERNEL);
 	if (t == NULL) {
 		ret = -ENOMEM;
-		goto free_name;
+		goto out1;
 	}
 	t->id = id;
-	t->trig = iio_allocate_trigger_named(name);
+	t->trig = iio_allocate_trigger("sysfstrig%d", id);
 	if (!t->trig) {
 		ret = -ENOMEM;
 		goto free_t;
 	}
 
-	t->trig->control_attrs = &iio_sysfs_trigger_attr_group;
+	t->trig->dev.groups = iio_sysfs_trigger_attr_groups;
 	t->trig->owner = THIS_MODULE;
 	t->trig->dev.parent = &iio_sysfs_trig_dev;
 
@@ -154,8 +150,6 @@ out2:
 	iio_put_trigger(t->trig);
 free_t:
 	kfree(t);
-free_name:
-	kfree(name);
 out1:
 	mutex_unlock(&iio_syfs_trig_list_mut);
 	return ret;
@@ -177,7 +171,6 @@ static int iio_sysfs_trigger_remove(int id)
 	}
 
 	iio_trigger_unregister(t->trig);
-	kfree(t->trig->name);
 	iio_free_trigger(t->trig);
 
 	list_del(&t->l);
-- 
1.7.3.4
