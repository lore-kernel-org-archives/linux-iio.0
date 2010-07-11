Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 01/12] staging:iio: Use kasprintf to allocate and fill trig->name
Date: Sun, 11 Jul 2010 16:39:08 +0100
Message-Id: <1278862759-19028-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1278862759-19028-1-git-send-email-jic23@cam.ac.uk>
References: <1278862759-19028-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16209_trigger.c      |    7 +++----
 drivers/staging/iio/accel/adis16240_trigger.c      |    7 +++----
 drivers/staging/iio/accel/lis3l02dq_ring.c         |    8 ++++----
 drivers/staging/iio/gyro/adis16260_trigger.c       |    7 +++----
 drivers/staging/iio/imu/adis16300_trigger.c        |    7 +++----
 drivers/staging/iio/imu/adis16350_trigger.c        |    7 +++----
 drivers/staging/iio/imu/adis16400_trigger.c        |    7 +++----
 drivers/staging/iio/industrialio-trigger.c         |    9 +++------
 drivers/staging/iio/trigger.h                      |    4 ----
 drivers/staging/iio/trigger/iio-trig-gpio.c        |    9 ++-------
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |   12 +++---------
 11 files changed, 30 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/staging/iio/accel/adis16209_trigger.c
index 4a0507c..cd901a4 100644
--- a/drivers/staging/iio/accel/adis16209_trigger.c
+++ b/drivers/staging/iio/accel/adis16209_trigger.c
@@ -83,14 +83,13 @@ int adis16209_probe_trigger(struct iio_dev *indio_dev)
 	struct adis16209_state *st = indio_dev->dev_data;
 
 	st->trig = iio_allocate_trigger();
-	st->trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
+	st->trig->name = kasprintf(GFP_KERNEL,
+				   "adis16209-dev%d",
+				   indio_dev->id);
 	if (!st->trig->name) {
 		ret = -ENOMEM;
 		goto error_free_trig;
 	}
-	snprintf((char *)st->trig->name,
-		 IIO_TRIGGER_NAME_LENGTH,
-		 "adis16209-dev%d", indio_dev->id);
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
diff --git a/drivers/staging/iio/accel/adis16240_trigger.c b/drivers/staging/iio/accel/adis16240_trigger.c
index df1312e..d58b405 100644
--- a/drivers/staging/iio/accel/adis16240_trigger.c
+++ b/drivers/staging/iio/accel/adis16240_trigger.c
@@ -83,14 +83,13 @@ int adis16240_probe_trigger(struct iio_dev *indio_dev)
 	struct adis16240_state *st = indio_dev->dev_data;
 
 	st->trig = iio_allocate_trigger();
-	st->trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
+	st->trig->name = kasprintf(GFP_KERNEL,
+				   "adis16240-dev%d",
+				   indio_dev->id);
 	if (!st->trig->name) {
 		ret = -ENOMEM;
 		goto error_free_trig;
 	}
-	snprintf((char *)st->trig->name,
-		 IIO_TRIGGER_NAME_LENGTH,
-		 "adis16240-dev%d", indio_dev->id);
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 6b0b124..a33599d 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -495,14 +495,14 @@ int lis3l02dq_probe_trigger(struct iio_dev *indio_dev)
 	if (!state->trig)
 		return -ENOMEM;
 
-	state->trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
+	state->trig->name = kasprintf(GFP_KERNEL,
+				      "lis3l02dq-dev%d",
+				      indio_dev->id);
 	if (!state->trig->name) {
 		ret = -ENOMEM;
 		goto error_free_trig;
 	}
-	snprintf((char *)state->trig->name,
-		 IIO_TRIGGER_NAME_LENGTH,
-		 "lis3l02dq-dev%d", indio_dev->id);
+
 	state->trig->dev.parent = &state->us->dev;
 	state->trig->owner = THIS_MODULE;
 	state->trig->private_data = state;
diff --git a/drivers/staging/iio/gyro/adis16260_trigger.c b/drivers/staging/iio/gyro/adis16260_trigger.c
index b3c5659..54afd9e 100644
--- a/drivers/staging/iio/gyro/adis16260_trigger.c
+++ b/drivers/staging/iio/gyro/adis16260_trigger.c
@@ -83,14 +83,13 @@ int adis16260_probe_trigger(struct iio_dev *indio_dev)
 	struct adis16260_state *st = indio_dev->dev_data;
 
 	st->trig = iio_allocate_trigger();
-	st->trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
+	st->trig->name = kasprintf(GFP_KERNEL,
+				   "adis16260-dev%d",
+				   indio_dev->id);
 	if (!st->trig->name) {
 		ret = -ENOMEM;
 		goto error_free_trig;
 	}
-	snprintf((char *)st->trig->name,
-		 IIO_TRIGGER_NAME_LENGTH,
-		 "adis16260-dev%d", indio_dev->id);
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
diff --git a/drivers/staging/iio/imu/adis16300_trigger.c b/drivers/staging/iio/imu/adis16300_trigger.c
index 54edb20..a55f383 100644
--- a/drivers/staging/iio/imu/adis16300_trigger.c
+++ b/drivers/staging/iio/imu/adis16300_trigger.c
@@ -86,14 +86,13 @@ int adis16300_probe_trigger(struct iio_dev *indio_dev)
 	struct adis16300_state *st = indio_dev->dev_data;
 
 	st->trig = iio_allocate_trigger();
-	st->trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
+	st->trig->name = kasprintf(GFP_KERNEL,
+				   "adis16300-dev%d",
+				   indio_dev->id);
 	if (!st->trig->name) {
 		ret = -ENOMEM;
 		goto error_free_trig;
 	}
-	snprintf((char *)st->trig->name,
-		 IIO_TRIGGER_NAME_LENGTH,
-		 "adis16300-dev%d", indio_dev->id);
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
diff --git a/drivers/staging/iio/imu/adis16350_trigger.c b/drivers/staging/iio/imu/adis16350_trigger.c
index 1ffa75d..fbe246a 100644
--- a/drivers/staging/iio/imu/adis16350_trigger.c
+++ b/drivers/staging/iio/imu/adis16350_trigger.c
@@ -86,14 +86,13 @@ int adis16350_probe_trigger(struct iio_dev *indio_dev)
 	struct adis16350_state *st = indio_dev->dev_data;
 
 	st->trig = iio_allocate_trigger();
-	st->trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
+	st->trig->name = kasprintf(GFP_KERNEL,
+				   "adis16350-dev%d",
+				   indio_dev->id);
 	if (!st->trig->name) {
 		ret = -ENOMEM;
 		goto error_free_trig;
 	}
-	snprintf((char *)st->trig->name,
-		 IIO_TRIGGER_NAME_LENGTH,
-		 "adis16350-dev%d", indio_dev->id);
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
diff --git a/drivers/staging/iio/imu/adis16400_trigger.c b/drivers/staging/iio/imu/adis16400_trigger.c
index 3b3250a..bf7c603 100644
--- a/drivers/staging/iio/imu/adis16400_trigger.c
+++ b/drivers/staging/iio/imu/adis16400_trigger.c
@@ -86,14 +86,13 @@ int adis16400_probe_trigger(struct iio_dev *indio_dev)
 	struct adis16400_state *st = indio_dev->dev_data;
 
 	st->trig = iio_allocate_trigger();
-	st->trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
+	st->trig->name = kasprintf(GFP_KERNEL,
+				   "adis16400-dev%d",
+				   indio_dev->id);
 	if (!st->trig->name) {
 		ret = -ENOMEM;
 		goto error_free_trig;
 	}
-	snprintf((char *)st->trig->name,
-		 IIO_TRIGGER_NAME_LENGTH,
-		 "adis16400-dev%d", indio_dev->id);
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index ef088a4..92e6006 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -295,10 +295,9 @@ static ssize_t iio_trigger_read_current(struct device *dev,
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	int len = 0;
 	if (dev_info->trig)
-		len = snprintf(buf,
-			       IIO_TRIGGER_NAME_LENGTH,
-			       "%s\n",
-			       dev_info->trig->name);
+		len = sprintf(buf,
+			      "%s\n",
+			      dev_info->trig->name);
 	return len;
 }
 
@@ -323,8 +322,6 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 	}
 	mutex_unlock(&dev_info->mlock);
 
-	len = len < IIO_TRIGGER_NAME_LENGTH ? len : IIO_TRIGGER_NAME_LENGTH;
-
 	dev_info->trig = iio_trigger_find_by_name(buf, len);
 	if (oldtrig && dev_info->trig != oldtrig)
 		iio_put_trigger(oldtrig);
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 784e7b6..89610b5 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -8,10 +8,6 @@
  */
 #ifndef _IIO_TRIGGER_H_
 #define _IIO_TRIGGER_H_
-#define IIO_TRIGGER_NAME_LENGTH 20
-#define IIO_TRIGGER_ID_PREFIX "iio:trigger"
-#define IIO_TRIGGER_ID_FORMAT IIO_TRIGGER_ID_PREFIX "%d"
-
 
 /**
  * struct iio_trigger - industrial I/O trigger device
diff --git a/drivers/staging/iio/trigger/iio-trig-gpio.c b/drivers/staging/iio/trigger/iio-trig-gpio.c
index 1da285d..3c0614e 100644
--- a/drivers/staging/iio/trigger/iio-trig-gpio.c
+++ b/drivers/staging/iio/trigger/iio-trig-gpio.c
@@ -93,16 +93,11 @@ static int iio_gpio_trigger_probe(struct platform_device *pdev)
 			trig->private_data = trig_info;
 			trig_info->irq = irq;
 			trig->owner = THIS_MODULE;
-			trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH,
-					GFP_KERNEL);
-			if (!trig->name) {
+			trig->name = kasprintf(GFP_KERNEL, "irqtrig%d", irq);
+			if (trig->name == NULL) {
 				ret = -ENOMEM;
 				goto error_free_trig_info;
 			}
-			snprintf((char *)trig->name,
-				 IIO_TRIGGER_NAME_LENGTH,
-				 "irqtrig%d", irq);
-
 			ret = request_irq(irq, iio_gpio_trigger_poll,
 					  irqflags, trig->name, trig);
 			if (ret) {
diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index 4ee3ae1..d8c58cb 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -25,7 +25,6 @@ static DEFINE_MUTEX(iio_prtc_trigger_list_lock);
 struct iio_prtc_trigger_info {
 	struct rtc_device *rtc;
 	int frequency;
-	char *name;
 	struct rtc_task task;
 };
 
@@ -78,8 +77,7 @@ static ssize_t iio_trig_periodic_read_name(struct device *dev,
 					   char *buf)
 {
 	struct iio_trigger *trig = dev_get_drvdata(dev);
-	struct iio_prtc_trigger_info *trig_info = trig->private_data;
-	return sprintf(buf, "%s\n", trig_info->name);
+	return sprintf(buf, "%s\n", trig->name);
 }
 
 static DEVICE_ATTR(name, S_IRUGO,
@@ -129,16 +127,12 @@ static int iio_trig_periodic_rtc_probe(struct platform_device *dev)
 		trig->private_data = trig_info;
 		trig->owner = THIS_MODULE;
 		trig->set_trigger_state = &iio_trig_periodic_rtc_set_state;
-		trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
+		trig->name = kasprintf(GFP_KERNEL, "periodic%s", pdata[i]);
 		if (trig->name == NULL) {
 			ret = -ENOMEM;
 			goto error_free_trig_info;
 		}
-		snprintf((char *)trig->name,
-			 IIO_TRIGGER_NAME_LENGTH,
-			 "periodic%s",
-			 pdata[i]);
-		trig_info->name = (char *)trig->name;
+
 		/* RTC access */
 		trig_info->rtc
 			= rtc_class_open(pdata[i]);
-- 
1.7.0.4
